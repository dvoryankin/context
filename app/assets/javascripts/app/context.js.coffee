class Context
  @initialize: ->
    console.log "[Context]: Context initialize"
    window.context = new Context

  constructor: ->
    console.log "[Context]: Context app object created"
    do @handleEmptyTasks
    do @handleFilledTasks
    do @handleContextTask

  handleEmptyTasks: ->
    $(document).on 'click', '.tasks__next__empty-element', ->
      content = prompt 'Fill task content'
      if content
        $.post '/tasks', content: content, (answer) =>
          if answer.success
            console.log '[Context]: Created task'
            $(this).html content
            $(this).data('id', answer.id)
            $(this).removeClass 'tasks__next__empty-element'
            $(this).addClass 'tasks__next__filled-element'
          else
            alert 'Task is not create!'

  handleFilledTasks: ->
    $(document).on 'click', '.tasks__next__filled-element', ->
      id = $(this).data 'id'
      $.post '/tasks/' + id + '/incontext', {}, (answer) =>
        if answer.success
          console.log "[Context]: Task #{id} was set in context"
          $('.tasks__context__element').html answer.content
          $(this).removeClass 'tasks__next__filled-element'
          $(this).addClass 'tasks__next__empty-element'
          $(this).html '+'
        else
          alert 'Your context already set'

  handleContextTask: ->


window.Context = Context
