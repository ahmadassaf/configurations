command: "cd"

command: "du -ch ~/.Trash | grep total | cut -c 1-5"

refreshFrequency: 10000

render: (output) -> """
  <div>
    <img src="trash-size.widget/icon.png">
    <a class="size">#{output}</a>
  </div>
"""

style: """
  bottom: 10px
  left: 10px
  font-size: 24px
  font-family: Helvetica Neue
  font-weight: 100
  color: #000
  padding: 4px 6px 4px 6px
  border-radius: 5px

  img
    height: 26px
    margin-bottom: -3px

  a
    margin-left: -3px
"""

update: (output, domEl) ->
  if (output.indexOf(" 0B") > -1)
    $(domEl).find('.size').html("Empty")
  else
    $(domEl).find('.size').html(output)