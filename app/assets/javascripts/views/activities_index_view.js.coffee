Track.ActivitiesIndexView = Ember.View.extend
  templateName: 'activities/index'
  data: Ember.computed.alias('controller.chartData')
  chart: null
  showChart:(->
    ctx = @$('#myChart')[0].getContext('2d')
    @chart = new Chart(ctx).Doughnut @get('data'),
      animationSteps:30, animationEasing: "easeOutQuart"
  ).on('didInsertElement')
  updateChart:(->
    if @chart
      @chart.segments = []
      @get('data').forEach (d)=>@chart.addData(d)
  ).observes('data.@each.duration')
