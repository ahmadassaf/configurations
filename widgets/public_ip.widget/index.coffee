command: "curl -s checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//'"

refreshFrequency: 43200000

style: """
  bottom: 460px
  right: 200px
  color: #000
  font-family: Helvetica Neue


  div
    display: block
    text-shadow: 0 0 1px rgba(#000, 0.5)
    font-size: 12px
    font-weight: 400


"""


render: -> """
  <div class='ip_address'></div>
"""

update: (output, domEl) ->
  $(domEl).find('.ip_address').html(output)

