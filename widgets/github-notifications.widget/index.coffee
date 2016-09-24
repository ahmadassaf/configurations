# Execute the shell command.
command: "github-notifications.widget/data.sh"

refreshFrequency: 150000

style: """
  right: 10px;
  top: 10px;

  .github-notifications {
    padding: 10px;
  }

  @font-face {
    font-family: 'octicons';
    src: url('github-notifications.widget/octicons/octicons.eot?#iefix') format('embedded-opentype'),
         url('github-notifications.widget/octicons/octicons.woff') format('woff'),
         url('github-notifications.widget/octicons/octicons.ttf') format('truetype'),
         url('github-notifications.widget/octicons/octicons.svg#octicons') format('svg');
    font-weight: normal;
    font-style: normal;
  }

  .octicon {
    font: normal normal normal 14px/1 octicons;
    display: inline-block;
    text-decoration: none;
    text-rendering: auto;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
  }

  .count-group {
    display: inline-block;
    width: 55px;
    font-size: 30px;
    text-align: center;
  }

  .count-group + .count-group {
    padding-left: 5px;
    border-left: 1px solid #CCC;
  }

  .count {
    font-size: 8px;
    padding: 3px;
    position: absolute;
    bottom: 5px
    background: #000;
    color: #fff;
    font-family: Tahoma;
  }

  .public .count {
    color: #ffffff;
    font-weight: normal;
    font-family: Sans-Serif;
    margin: 0;
    background: rgba(235, 84, 82, 0.75);
    padding: 3px;
    font-size: 9px;
    bottom: 7px;
    position: absolute;
    width:10px;
  }

"""

iconMapping: [
  ["mention"     ,"&#xf0be;"],
  ["author"      ,"&#xf018;"],
  ["team_mention","&#xf037;"],
  ["assign"      ,"&#xf035;"]
  ["manual"      ,"&#xf077;"],
  ["comment"     ,"&#xf02b;"],
  ["subscribed"  ,"&#xf04e;"],
  ["state_change","&#xf0ac;"],
]

render: (output) -> @getVisual output

update: (output, domEl) ->
  $domEl = $(domEl)
  $domEl.html @getVisual output

getVisual: (output) ->
  data = []
  try
    data = JSON.parse output
  catch ex
    return """
      <div class='github-notifications public}'>
        <span>Error Retrieving Notifications!</span>
      </div>
    """

  counts =
    subscribed: 0
    manual: 0
    author: 0
    comment: 0
    mention: 0
    team_mention: 0
    state_change: 0
    assign: 0

  for reason in (notification.reason for notification in data)
    counts[reason] += 1

  icons = []

  for icon in @iconMapping
    count =
      if counts[icon[0]] > 0
        count = "<sub><span class='count'>#{counts[icon[0]]}</span></sub>"
      else
        ''
    icons.push "<div class='count-group'><span class='octicon'>#{icon[1]}</span>#{count}</div>"

  return """
    <div class='github-notifications public}'>
      #{icons.join('')}
    </div>
  """
