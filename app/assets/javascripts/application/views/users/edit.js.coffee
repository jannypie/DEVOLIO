class App.Views.Users.Edit extends App.View
  template: JST['application/templates/users/edit']

  events:
    'submit form' : 'onFormSubmit'

  render: ->
    @$el.html(@template(@model.attributes))

  onFormSubmit: ->
    $('#get_api').attr('disabled', true)
    $('#get_api').val('Loading...')
    form = @$el.find "form"
    newAttrs = form.serializeJSON()
    success = =>
      console.log @model
      gh_handle = @model.get('github_handle')
      window.getGitHubData(gh_handle) if gh_handle
      App.router.navigate("/#{@model.get('username')}", {trigger: true});
    error = ->
      $('#get_api').attr('disabled', false)
      $('#get_api').val('Submit')
      $('.message').html("<span class='error'>There was an issue saving your updates</span>")
    @model.save(newAttrs, success: success, error: error)
    false
