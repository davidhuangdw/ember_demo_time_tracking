short_str = (desc,limit=100) ->
  if desc.length>limit
    desc[0...limit]+"    ..."
  else desc

short_rows = (str, limit_row=4) ->
  rows = str.trim().split('\n')
  if rows.length>limit_row
    rows = rows[0...limit_row-1]
    rows.push("...")
  rows

format_html = (rows) ->
  rows.map (s)->s+'<br>'
    .join('\n')

shortenDescription = (desc, limit_char=100, limit_row=4) ->
  trim = short_str(desc||'', limit_char)
  format_html short_rows trim, limit_row




Track.ShortDescComponent = Ember.Component.extend
  layoutName: 'components/short_desc'
  desc: ""
  limit_char: 100
  limit_row: 4
  shortDescHTML: (->
    shortenDescription @get('desc'), @get('limit_char'), @get('limit_row')
  ).property('desc')

