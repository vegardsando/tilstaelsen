(function($)
{
	var MutationObserver = window.MutationObserver || window.WebKitMutationObserver;

	// If mutation observer is not supported, create a harness for it for graceful degradation.
	// Older browsers could be supported through the DOMNodeInserted event, but that can be saved for another day...
	if (!MutationObserver)
	{
		MutationObserver = function() {
		};
		MutationObserver.prototype.observe = function() {
		};
		MutationObserver.prototype.disconnect = function() {
		};
	}

	/**
	 * FieldModal class
	 * Handles the modal window for creating new fields.
	 */
	var FieldModal = Garnish.Modal.extend({

		$body: null,
		$content: null,
		$main: null,
		$footer: null,
		$leftButtons: null,
		$rightButtons: null,
		$saveBtn: null,
		$cancelBtn: null,
		$saveSpinner: null,
		$deleteSpinner: null,
		$loadSpinner: null,

		$html: null,
		$js: null,
		$css: null,
		$currentHtml: null,
		$currentJs: null,
		$currentCss: null,

		$observed: null,
		observer: null,

		templateLoaded: false,
		executedJs: null,
		loadedCss: null,

		/**
		 * The constructor.
		 */
		init: function(settings)
		{
			this.base();
			this.setSettings(settings, {
				resizable: true
			});

			this.$currentHtml = $();
			this.$currentJs = $();
			this.$currentCss = $();
			this.$observed = $();

			this.executedJs = {};
			this.loadedCss = {};

			// Observe the DOM
			this.observer = new MutationObserver($.proxy(function(mutations)
			{
				for (var i = 0; i < mutations.length; i++)
				{
					this.$observed = this.$observed.add(mutations[i].addedNodes);
				}
			}, this));

			var $container = $('<form class="modal sprout-field-modal" style="display: none; opacity: 0;">').appendTo(Garnish.$bod);

			this.$body = $('<div class="body">').appendTo($container);
			this.$content = $('<div class="content">').appendTo(this.$body);
			this.$main = $('<div class="main">').appendTo(this.$content);
			this.$footer = $('<div class="footer">').appendTo($container);
			this.$loadSpinner = $('<div class="spinner big">').appendTo($container);

			this.$leftButtons = $('<div class="buttons left">').appendTo(this.$footer);
			this.$rightButtons = $('<div class="buttons right">').appendTo(this.$footer);

			this.$deleteSpinner = $('<div class="spinner hidden">').appendTo(this.$leftButtons);

			this.$cancelBtn = $('<div class="btn disabled" role="button">').text(Craft.t('Cancel')).appendTo(this.$rightButtons);
			this.$saveBtn = $('<div class="btn submit disabled" role="button">').text(Craft.t('Save')).appendTo(this.$rightButtons);
			this.$saveSpinner = $('<div class="spinner hidden">').appendTo(this.$rightButtons);

			this.setContainer($container);
			var formId = $("#formId").val();
			var postData = {
				formId: formId
			};

			// Loads the field settings template file, as well as all the resources that come with it

			Craft.postActionRequest('sproutForms/fields/modalField', postData, $.proxy(function(response, textStatus)
			{
				if (textStatus === 'success')
				{
					this.$loadSpinner.addClass('hidden');
					this.initTemplate(response);
				}
				else
				{
					this.destroy();
				}
			}, this));
		},

		/**
		 * Prepares the field settings template HTML, CSS and Javascript.
		 *
		 * @param template
		 */
		initTemplate: function(template)
		{
			var callback = $.proxy(function(e)
			{
				this.$html = e.$html;
				this.$js = e.$js;
				this.$css = e.$css;

				this.templateLoaded = true;
				this.initListeners();

				if (this.visible)
				{
					this.initSettings();
				}

				this.off('parseTemplate', callback);
			}, this);

			this.on('parseTemplate', callback);
			this.parseTemplate(template);
		},

		/**
		 * Takes raw HTML, CSS and Javascript and parses it ready to be used in the DOM.
		 * It also loads any external resources if they are needed.
		 *
		 * @param template
		 */
		parseTemplate: function(template)
		{
			var that = this;
			var $head = Garnish.$doc.find('head');

			var $html = $(template.html);
			var $js = $(template.js).filter('script');
			var $css = $(template.css).filter('style, link');

			// Ensure that external stylesheets are loaded asynchronously
			var $cssFiles = $css.filter('link').prop('async', true);
			var $cssInline = $css.filter('style');

			$cssFiles.each(function()
			{
				var $this = $(this);
				var src = $this.prop('href');

				if (!that.loadedCss.hasOwnProperty(src))
				{
					$head.append($this);
					that.loadedCss[src] = $this;
				}
			});

			// Load external Javascript files asynchronously, and remove them from being executed again.
			// This assumes that external Javascript files are simply library files, that don't directly and
			// instantly execute code that modifies the DOM. Library files can be loaded and executed once and
			// reused later on.
			// The Javascript tags that directly contain code are assumed to be context-dependent, so they are
			// saved to be executed each time the modal is opened.
			var $jsFiles = $js.filter('[src]');
			var $jsInline = $js.filter(':not([src])');

			var jsFiles = [];
			$jsFiles.each(function()
			{
				var $this = $(this);
				var src = $this.prop('src');

				if (!that.executedJs.hasOwnProperty(src))
				{
					jsFiles.push(src);
					that.executedJs[src] = true;
				}
			});

			var callback = function()
			{
				that.off('runExternalScripts', callback);

				that.trigger('parseTemplate', {
					target: this,
					$html: $html,
					$js: $jsInline,
					$css: $cssInline
				});
			};

			that.on('runExternalScripts', callback);
			this.runExternalScripts(jsFiles);
		},

		/**
		 * Runs external Javascript files
		 *
		 * @param files - An array of URL's (as strings) to Javascript files
		 */
		runExternalScripts: function(files)
		{
			var filesCount = files.length;

			if (filesCount > 0)
			{
				for (var i = 0; i < files.length; i++)
				{
					var src = files[i];

					$.getScript(src, $.proxy(function(data, status)
					{
						if (status === 'success')
						{
							filesCount--;

							if (filesCount === 0)
							{
								this.trigger('runExternalScripts', {
									target: this
								});
							}
						}
						else
						{
							Craft.displayError(Craft.t('Could not load all resources.'));
						}
					}, this));
				}
			}
			else
			{
				this.trigger('runExternalScripts', {
					target: this
				});
			}
		},

		/**
		 * Binds all listeners so the quick field buttons can start working.
		 */
		initListeners: function()
		{
			this.$cancelBtn.removeClass('disabled');
			this.$saveBtn.removeClass('disabled');

			this.addListener(this.$cancelBtn, 'activate', 'closeModal');
			this.addListener(this.$saveBtn, 'activate', 'saveField');

			this.on('show', this.initSettings);
			this.on('fadeOut', this.destroySettings);

			this.enable();
		},

		/**
		 * Unbinds all listeners.
		 */
		destroyListeners: function()
		{
			this.$cancelBtn.addClass('disabled');
			this.$saveBtn.addClass('disabled');

			this.removeListener(this.$cancelBtn, 'activate');
			this.removeListener(this.$saveBtn, 'activate');

			this.off('show', this.initSettings);
			this.off('fadeOut', this.destroySettings);

			this.disable();
		},

		/**
		 * Initialises the HTML, CSS and Javascript for the modal window.
		 */
		initSettings: function(e)
		{
			var that = e && e.target ? e.target : this;

			// If the template files are not loaded yet, just cancel initialisation of the settings.
			if (!that.templateLoaded)
			{
				return;
			}

			that.$currentHtml = e && e.$html ? e.$html : that.$html.clone();
			that.$currentJs = e && e.$js ? e.$js : that.$js.clone();
			that.$currentCss = e && e.$css ? e.$css : that.$css.clone();

			// Save any new nodes that are added to the body during initialisation, so they can be safely removed later.
			that.$observed = $();
			that.observer.observe(Garnish.$bod[0], { childList: true, subtree: false });

			that.$main.append(that.$currentHtml);
			Garnish.$bod.append(that.$currentJs);

			// Only show the delete button if editing a field
			var $fieldId = that.$main.find('input[name="fieldId"]');

			Craft.initUiElements();

			// Rerun the external scripts as some field types may need to make DOM changes in their external files.
			// This means that libraries are being initialized multiple times, but hopefully they're smart enough to
			// deal with that. So far, no issues.
			var callback = function()
			{
				that.off('runExternalScripts', callback);

				// Stop observing after a healthy timeout to ensure all mutations are captured.
				setTimeout(function()
				{
					that.observer.disconnect();
				}, 1);
			};

			that.on('runExternalScripts', callback);
			that.runExternalScripts(Object.keys(that.executedJs));
		},

		/**
		 * Event handler for when the modal window finishes fading out after hiding.
		 * Clears out all events and elements of the modal.
		 */
		destroySettings: function(e)
		{
			var that = e && e.target ? e.target : this;

			that.$currentHtml.remove();
			that.$currentJs.remove();
			that.$currentCss.remove();
			that.$observed.remove();
		},

		/**
		 * Event handler for the Close button.
		 * Hides the modal window from view.
		 */
		closeModal: function()
		{
			this.hide();
		},

		/**
		 * Event handler for the save button.
		 * Saves the new field form to the database.
		 *
		 * @param e
		 */
		saveField: function(e)
		{
			if (e) e.preventDefault();

			if (this.$saveBtn.hasClass('disabled') || !this.$saveSpinner.hasClass('hidden'))
			{
				return;
			}

			this.destroyListeners();

			this.$saveSpinner.removeClass('hidden');
			var data = this.$container.serialize();

			var inputId = this.$container.find('input[name="fieldId"]');
			var id = inputId.length ? inputId.val() : false;

			Craft.postActionRequest('sproutForms/fields/saveField', data, $.proxy(function(response, textStatus)
			{
				this.$saveSpinner.addClass('hidden');

				var statusSuccess = (textStatus === 'success');

				if (statusSuccess && response.success)
				{
					this.initListeners();

					if (id === false)
					{
						this.trigger('newField', {
							target: this,
							field: response.field
						});
					}
					else
					{
						this.trigger('saveField', {
							target: this,
							field: response.field
						});

						Craft.cp.displayNotice(Craft.t('\'{name}\' field saved.', { name: response.field.name }));
					}

					this.hide();
				}
				else if (statusSuccess && response.template)
				{
					if (this.visible)
					{
						var callback = $.proxy(function(e)
						{
							this.initListeners();
							this.destroySettings();
							this.initSettings(e);
							this.off('parseTemplate', callback);
						}, this);

						this.on('parseTemplate', callback);
						this.parseTemplate(response.template);

						Garnish.shake(this.$container);
					}
					else
					{
						this.initListeners();
					}
				}
				else
				{
					this.initListeners();

					Craft.cp.displayError(Craft.t('An unknown error occurred.'));
				}
			}, this));
		},

		/**
		 *
		 * @param id
		 */
		editField: function(id)
		{
			this.destroyListeners();
			this.show();
			this.initListeners();

			this.$loadSpinner.removeClass('hidden');

			var formId = $("#formId").val();
			var data = {'fieldId': id, 'formId': formId};

			Craft.postActionRequest('sproutForms/fields/editField', data, $.proxy(function(response, textStatus)
			{
				this.$loadSpinner.addClass('hidden');

				var statusSuccess = (textStatus === 'success');

				if(statusSuccess && response.success)
				{
					var callback = $.proxy(function(e)
					{
						this.destroySettings();
						this.initSettings(e);
						this.off('parseTemplate', callback);
					}, this);

					this.on('parseTemplate', callback);
					this.parseTemplate(response.template);
				}
				else if(statusSuccess && response.error)
				{
					Craft.cp.displayError(response.error);

					this.hide();
				}
				else
				{
					Craft.cp.displayError(Craft.t('An unknown error occurred. '));

					this.hide();
				}
			}, this));
		},

		/**
		 * Prevents the modal from closing if it's disabled.
		 * This fixes issues if the modal is closed when saving/deleting fields.
		 */
		hide: function()
		{
			if (!this._disabled)
			{
				this.base();
			}
		},

		/**
		 * Removes everything to do with the modal form the DOM.
		 */
		destroy: function()
		{
			this.base.destroy();

			this.destroyListeners();
			this.destroySettings();

			this.$shade.remove();
			this.$container.remove();

			this.trigger('destroy');
		}
	},
	{
		/**
		 * (Static) Singleton pattern.
		 *
		 * @returns FieldModal
		 */
		getInstance: function()
		{
			if (!this._instance)
			{
				this._instance = new FieldModal();
			}

			return this._instance;
		}
	});

	window.SproutField.FieldModal = FieldModal;

})(jQuery);
