wrApp = angular.module('wrApp')

wrApp.factory 'wrErrorMessages', () ->
  DEFAULT_ERROR_MESSAGE = "Please fill this out correctly"
  ERROR_MESSAGES = {
    'required': 'This is required',
    'email': "This doesn't look like an email address",
    'minlength': "This isn't long enough",
  }
  ERROR_MESSAGES_BY_FIELD = {
    'password': {
      'minlength': "Your password must be at least 6 characters."
    }
  }

  hasVisibleError = (field, formSubmitted) ->
    (field.$touched or formSubmitted) and
    (field.$invalid)

  singleErrorMessage = (field) ->
    firstError = Object.keys(field.$error)[0]
    errorMessage = getErrorMessage(field.$name, firstError)

  getErrorMessage = (field, error) ->
    message = ERROR_MESSAGES_BY_FIELD[field]?[error]
    if not message
      message = ERROR_MESSAGES[error]
    if not message
      message = DEFAULT_ERROR_MESSAGE
    return message


  return {
    hasVisibleError: hasVisibleError,
    singleErrorMessage: singleErrorMessage,
  }
