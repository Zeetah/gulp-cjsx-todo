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


TodoApp = React.createClass
  getInitialState: ->
    todos = localStorage.getItem('todos') or '{"items":[], "text":""}'
    
    JSON.parse(todos)

  onChange: (event) ->
    @setState {text: event.target.value}
  
  handleSubmit: (event) ->
    event.preventDefault()
    item = 
      name: @state.text
      id: Math.random()
    
    state =
      items: @state.items.concat([item])
      text: ''
    localStorage.setItem('todos', JSON.stringify(state))
    @setState state

  updateState: (newState) ->
    @setState newState
  
  render: ->
    <div>
      <h1>TODO APP</h1>
      <TodoList items={@state.items} updateState={@updateState}/>
      <form onSubmit={@handleSubmit}>
        <input onChange={@onChange} value={@state.text} />
        <button>{'Add #' + (@state.items.length + 1)}</button>
      </form>
    </div>


module.exports = TodoApp
