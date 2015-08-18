command: "sysctl -n vm.swapusage | awk '{printf \"%s,%s\\n%s,%s\\n%s,%s\", $1,$3,$4,$6,$7,$9}'"

refreshFrequency: 5000

style: """
  top: 560px
  right: 200px
  color: rgba(#000, 0.5)
  font-family: Helvetica Neue


  table
    border-collapse: collapse
    table-layout: fixed

    &:before
      position: absolute
      left: 0
      top: -14px
      font-size: 10px

  td
    border: 1px solid #000
    border-right:none
    border-left:none
    font-size: 24px
    font-weight: 100
    width: 120px
    max-width: 120px
    overflow: hidden
    padding:5px 0
    text-shadow: 0 0 1px rgba(#000, 0.5)

  .value
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

  renderProcess = (name, value) ->
    "<div class='value'>" +
      "#{value}<p>#{name}</p>" +
    "</div>"

  for process, i in processes
    args = process.split(',')
    table.find(".col#{i+1}").html renderProcess(args...)
