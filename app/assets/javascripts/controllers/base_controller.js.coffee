window.BaseController = class extends Spine.Controller
  helpers: (other_helpers...)->
    @helper_cache ?= _.extend({}, SampleHelper, other_helpers...)

  renderTemplate: (path, attributes...)->
    JST["views/#{ path }"]( _.extend({}, @.helpers(), @, attributes...) )
