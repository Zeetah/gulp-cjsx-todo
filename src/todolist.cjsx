TodoList = React.createClass
  removeItem: (event) ->
    event.preventDefault()

    items = _.remove @props.items, (item) ->
      "#{item.id}" isnt $(event.currentTarget).parent().attr('data-id')

    state = { items, text: '' }
    @props.updateState state
    localStorage.setItem('todos', JSON.stringify(state))

  render: ->
    self = @

    createItem = (item) ->
      <li data-id={item.id}><span>{item.name}</span> <a href="#" onClick={self.removeItem}>Remove</a></li>
  
    <ul>{@props.items.map(createItem)}</ul>


module.exports = TodoList
