command: "ps axo \"rss,pid,ucomm\" | sort -nr | head -n3 | awk '{printf \"%8.0f MB,%s,%s\\n\", $1/1024, $3, $2}'"

refreshFrequency: 5000

style: """
  top: 440px
  right: 200px
  color: rgba(#000, 0.5)
  font-family: Helvetica Neue


  table
    border-collapse: collapse
    table-layout: fixed

    &:before
      content: 'mem'
      position: absolute
      right: 0
      top: -14px
      font-size: 10px

  td
    border-top: 1px solid #000
    font-size: 24px
    font-weight: 100
    width: 120px
    max-width: 120px
    overflow: hidden
    text-shadow: 0 0 1px rgba(#000, 0.5)

  .wrapper
    padding: 4px 6px 4px 6px
    position: relative

  p
    padding: 0
    margin: 0
    font-size: 11px
    font-weight: normal
    max-width: 100%
    color: #000
    text-align:center
    text-overflow: ellipsis

  .pid
    position: absolute
    top: 2px
    right: 2px
    font-size: 8px
    font-weight: normal

"""


render: ->
  """
  <table>
    <tr>
      <td class='col1'></td>
      <td class='col2'></td>
      <td class='col3'></td>
    </tr>
  </table>
"""

update: (output, domEl) ->
  processes = output.split('\n')
  table     = $(domEl).find('table')

  renderProcess = (cpu, name, id) ->
    "<div class='wrapper'>" +
      "#{cpu}<p>#{name}</p>" +
      "<div class='pid'>#{id}</div>" +
    "</div>"

  for process, i in processes
    args = process.split(',')
    table.find(".col#{i+1}").html renderProcess(args...)

