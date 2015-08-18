# See bottom of the file for command parameter details.

# Example city: Antibes
# Location:(23.7000° N, 90.3750° E)
# TimeZone: +6
calcMethod 	= 1
asrMethod  	= 1
latitude   	= 43.5808
longitude  	= 7.1239
timezone 	= +1

cityName 	: "Antibes"

hourFormat12  : true # If false, times shows in 24Hour format, otherwise in 12Hour format (without AM/PM)
hideSunset 	  : true # As Mugrib and Sunset times are same, It is preffered to hide Sunset column
addEdgeFiller : true # Adds extra padding in case of Fazr and Isha, to keep ribbon-style identical

command: "php -f ./prayer.widget/PrayTime.php calc_method=#{calcMethod} asr_method=#{asrMethod} lat=#{latitude} lon=#{longitude} tz=#{timezone}"

refreshFrequency: 15000

render: -> """
	<div id="widget-title">Prayer Times : #{@cityName}</div>
	<table>
		<thead><tr class="titles"></tr></thead>
		<tbody><tr class="values"></tr></tbody>
	</table>
	"""

style: """
	current-round = 6px
	no-bg = rgba(#000, .0)

	top: 44%
	left: 39%
	width: 450px
	background: none
	padding: 5px 1px 6px 1px
	border-radius: 8px
	font-family: Helvetica Neue
	font-size: 12px

	#widget-title
		color: #000
		font-size: 14px
		padding: 0 0 5px 5px
		display:none

	table
		font-weight: 400
		width: 100%
		text-align:center
		border-collapse:collapse

	td
		color: rgba(#000, 0.8)
		padding: 0 5px 0 5px
		background: none
		border-right:1px solid rgba(#000, 0.2)

	td:last-child
		border:none

	.titles
		font-size: 8px
		text-transform: uppercase
		font-weight: normal

	.values
		font-size: 18px
		font-weight: 300
		color: rgba(#fff, .9)

	.current
		color: #27ae60
		background: no-bg
		font-size:19px

	.titles .passed
		border-top-right-radius: current-round

	.values .passed
		border-bottom-right-radius: current-round

	.titles .upcoming
		border-top-left-radius: current-round

	.values .upcoming
		border-bottom-left-radius: current-round

	.filler
		padding: 0 2px 0 2px
	"""

update: (output, domEl) ->
	titles = ""
	values = ""

	lines = output.split "\n"
	names = lines[0].split ","
	times = lines[1].split ","

	if this.hideSunset
		names.splice(4,1)
		times.splice(4,1)

	curIndex = times.length-1
	now = new Date()
	time = new Date()
	for timeI, i in times
		timeComp = timeI.split ":"
		time.setHours(timeComp[0], timeComp[1])
		if time.getTime() < now.getTime() then curIndex = i else break

	for hhmm, i in times
			className = "normal";
			if i == curIndex then className = "current"
			else if i == curIndex-1 then className = "passed"
			else if i == curIndex+1 then className = "upcoming"
			if this.hourFormat12
				hhmm = hhmm.split ":"
				hhmm[0] -= if hhmm[0]>12 then 12 else 0
				hhmm = hhmm.join ":"

			titles += "<td class='#{className}'>#{names[i]}</td>"
			values += "<td class='#{className}'>#{hhmm}</td>"

	$(domEl).find('.titles').html(this.fillSides(titles, curIndex, names.length))
	$(domEl).find('.values').html(this.fillSides(values, curIndex, times.length))

fillSides: (cols, current, total) ->
	if this.addEdgeFiller
		if current==0
			return "<td class='passed filler'></td>#{cols}"
		else if current==total-1
			return "#{cols}<td class='upcoming filler'></td>"

	return cols

###
COMMAND PARAMETER DETAILS
---------------------------

1. calcMethod : Calculation method
=> Possible values:
	0: Ithna Ashari
  1: University of Islamic Sciences, Karachi
  2: Islamic Society of North America (ISNA)
  3: Muslim World League (MWL)
  4: Umm al-Qura, Makkah
  5: Egyptian General Authority of Survey
  6: Custom Setting
  7: Institute of Geophysics, University of Tehran

2. asrMethod : Juristic Methods / Asr Calculation Methods
=> Possible values:
	0: Shafii (standard)
  1: Hanafi

3. latitude  : Latitude
4. longitude : Longitude
5. timezone  : Timezone

> Note: You can find your latitude/longitude visiting http://freegeoip.net/ or from google map or so.
###