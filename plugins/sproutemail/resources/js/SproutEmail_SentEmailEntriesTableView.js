if (typeof Craft.SproutEmail === typeof undefined) {
	Craft.SproutEmail = {};
}

/**
 * Class Craft.SproutEmail.SentEmailEntriesTableView
 */
Craft.SproutEmail.SentEmailEntriesTableView = Craft.TableElementIndexView.extend({

	startDate: null,
	endDate: null,

	startDatepicker: null,
	endDatepicker: null,

	$chartExplorer: null,
	$totalValue: null,
	$chartContainer: null,
	$spinner: null,
	$error: null,
	$chart: null,
	$startDate: null,
	$endDate: null,

	sentEmailId: null,
	$icon: null,

	afterInit: function()
	{
		this.$explorerContainer = $('<div class="chart-explorer-container"></div>').prependTo(this.$container);

		this.createChartExplorer();

		this.base();

		this.initializeInfoIcons();
	},

	getStorage: function(key)
	{
		return Craft.SproutEmail.SentEmailEntriesTableView.getStorage(this.elementIndex._namespace, key);
	},

	setStorage: function(key, value)
	{
		Craft.SproutEmail.SentEmailEntriesTableView.setStorage(this.elementIndex._namespace, key, value);
	},

	createChartExplorer: function()
	{
		// chart explorer
		var $chartExplorer = $('<div class="chart-explorer"></div>').appendTo(this.$explorerContainer),
		    $chartHeader = $('<div class="chart-header"></div>').appendTo($chartExplorer),
		    $dateRange = $('<div class="date-range" />').appendTo($chartHeader),
		    $startDateContainer = $('<div class="datewrapper"></div>').appendTo($dateRange),
		    $to = $('<span class="to light">to</span>').appendTo($dateRange),
		    $endDateContainer = $('<div class="datewrapper"></div>').appendTo($dateRange),
		    $total = $('<div class="total"></div>').appendTo($chartHeader),
		    $totalLabel = $('<div class="total-label light">'+Craft.t('Total Submissions')+'</div>').appendTo($total),
		    $totalValueWrapper = $('<div class="total-value-wrapper"></div>').appendTo($total);
		$totalValue = $('<span class="total-value">&nbsp;</span>').appendTo($totalValueWrapper);

		this.$chartExplorer = $chartExplorer;
		this.$totalValue = $totalValue;
		this.$chartContainer = $('<div class="chart-container"></div>').appendTo($chartExplorer);
		this.$spinner = $('<div class="spinner hidden" />').prependTo($chartHeader);
		this.$error = $('<div class="error"></div>').appendTo(this.$chartContainer);
		this.$chart = $('<div class="chart"></div>').appendTo(this.$chartContainer);

		this.$startDate = $('<input type="text" class="text" size="20" autocomplete="off" />').appendTo($startDateContainer);
		this.$endDate = $('<input type="text" class="text" size="20" autocomplete="off" />').appendTo($endDateContainer);

		this.$startDate.datepicker($.extend({
			onSelect: $.proxy(this, 'handleStartDateChange')
		}, Craft.datepickerOptions));

		this.$endDate.datepicker($.extend({
			onSelect: $.proxy(this, 'handleEndDateChange')
		}, Craft.datepickerOptions));

		this.startDatepicker = this.$startDate.data('datepicker');
		this.endDatepicker = this.$endDate.data('datepicker');

		this.addListener(this.$startDate, 'keyup', 'handleStartDateChange');
		this.addListener(this.$endDate, 'keyup', 'handleEndDateChange');

		// Set the start/end dates
		var startTime = this.getStorage('startTime') || ((new Date()).getTime() - (60 * 60 * 24 * 30 * 1000)),
		    endTime = this.getStorage('endTime') || ((new Date()).getTime());

		this.setStartDate(new Date(startTime));
		this.setEndDate(new Date(endTime));

		// Load the report
		this.loadReport();
	},

	handleStartDateChange: function()
	{
		if (this.setStartDate(Craft.SproutEmail.SentEmailEntriesTableView.getDateFromDatepickerInstance(this.startDatepicker)))
		{
			this.loadReport();
		}
	},

	handleEndDateChange: function()
	{
		if (this.setEndDate(Craft.SproutEmail.SentEmailEntriesTableView.getDateFromDatepickerInstance(this.endDatepicker)))
		{
			this.loadReport();
		}
	},

	setStartDate: function(date)
	{
		// Make sure it has actually changed
		if (this.startDate && date.getTime() == this.startDate.getTime())
		{
			return false;
		}

		this.startDate = date;
		this.setStorage('startTime', this.startDate.getTime());
		this.$startDate.val(Craft.formatDate(this.startDate));

		// If this is after the current end date, set the end date to match it
		if (this.endDate && this.startDate.getTime() > this.endDate.getTime())
		{
			this.setEndDate(new Date(this.startDate.getTime()));
		}

		return true;
	},

	setEndDate: function(date)
	{
		// Make sure it has actually changed
		if (this.endDate && date.getTime() == this.endDate.getTime())
		{
			return false;
		}

		this.endDate = date;
		this.setStorage('endTime', this.endDate.getTime());
		this.$endDate.val(Craft.formatDate(this.endDate));

		// If this is before the current start date, set the start date to match it
		if (this.startDate && this.endDate.getTime() < this.startDate.getTime())
		{
			this.setStartDate(new Date(this.endDate.getTime()));
		}

		return true;
	},

	loadReport: function()
	{
		var requestData = this.settings.params;

		requestData.startDate = Craft.SproutEmail.SentEmailEntriesTableView.getDateValue(this.startDate);
		requestData.endDate = Craft.SproutEmail.SentEmailEntriesTableView.getDateValue(this.endDate);

		this.$spinner.removeClass('hidden');
		this.$error.addClass('hidden');
		this.$chart.removeClass('error');

		Craft.postActionRequest('SproutEmail/charts/getEntriesData', requestData, $.proxy(function(response, textStatus)
		{
			this.$spinner.addClass('hidden');

			if(textStatus == 'success' && typeof(response.error) == 'undefined')
			{
				if(!this.chart)
				{
					this.chart = new Craft.charts.Area(this.$chart);
				}

				var chartDataTable = new Craft.charts.DataTable(response.dataTable);

				var chartSettings = {
					localeDefinition: response.localeDefinition,
					orientation: response.orientation,
					formats: response.formats,
					dataScale: response.scale
				};

				this.chart.draw(chartDataTable, chartSettings);

				this.$totalValue.html(response.totalHtml);
			}
			else
			{
				var msg = Craft.t('An unknown error occurred.');

				if(typeof(response) != 'undefined' && response && typeof(response.error) != 'undefined')
				{
					msg = response.error;
				}

				this.$error.html(msg);
				this.$error.removeClass('hidden');
				this.$chart.addClass('error');
			}
		}, this));
	},

	initializeInfoIcons: function()
	{
		var $infoIcons = $('#sproutemail-sentemails');

		this.addListener($infoIcons, 'click', '.tableRowInfo', 'showHud');
	},

	showHud: function(event)
	{
		this.$icon = $(event.target);
		this.sentEmailId = this.$icon.closest('.infoRow').data('id');

		var $hudbody = $("<div/>");

		if (this.sentEmailId)
		{
			var data = {
				sentEmailId: this.sentEmailId
			};

			Craft.postActionRequest('sproutEmail/sentEmail/getInfoHtml', data, $.proxy(function(response, textStatus)
			{
				var response = JSON.parse(response);

				if (textStatus == 'success')
				{
					$(response.html).appendTo($hudbody);

					this.hud = new Garnish.HUD(this.$icon, $hudbody, {
						hudClass: 'hud',
					});
				}
				else
				{
					console.log('No email info found.');
				}

			}, this));
		}
	}

},
{
	storage: {},

	getStorage: function(namespace, key)
	{
		if (Craft.SproutEmail.SentEmailEntriesTableView.storage[namespace] && Craft.SproutEmail.SentEmailEntriesTableView.storage[namespace][key])
		{
			return Craft.SproutEmail.SentEmailEntriesTableView.storage[namespace][key];
		}

		return null;
	},

	setStorage: function(namespace, key, value)
	{
		if (typeof Craft.SproutEmail.SentEmailEntriesTableView.storage[namespace] == typeof undefined)
		{
			Craft.SproutEmail.SentEmailEntriesTableView.storage[namespace] = {};
		}

		Craft.SproutEmail.SentEmailEntriesTableView.storage[namespace][key] = value;
	},

	getDateFromDatepickerInstance: function(inst)
	{
		return new Date(inst.currentYear, inst.currentMonth, inst.currentDay);
	},

	getDateValue: function(date)
	{
		return date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate();
	}
});
