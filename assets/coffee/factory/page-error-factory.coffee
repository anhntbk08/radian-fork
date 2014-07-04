# This factory provides a mechanism to throw application level errors from anywhere in the app. This keeps in mind the
# [DRY](http://en.wikipedia.org/wiki/Don't_repeat_yourself) development principles by making it very simple to define
# errors that the app can throw and exposing specific methods to throw those errors.
define [
  'lodash'
  # Jump to [`factory/radian-factory.coffee`](radian-factory.html) ☛
  'factory/radian-factory'
], (_, RF) ->
  RF 'pageErrorFactory', [
    '$location'
  ], ($location) ->
    redirect = (code) ->
      $location.path "/error/#{code}"

    factory =
      showError: (code) ->
        redirect code

    # As well as calling `pageErrorFactory.showError '123'`, you can define a specific error here; this function will
    # then create a function specific for throwing that error code, eg `pageErrorFactory.show123()`.
    _.forEach ['404', '500'], (code) ->
      factory["show#{code}"] = () ->
        factory.showError code

    factory