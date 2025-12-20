data "jinja_template" "configuration" {
  context {
    type = "json"
    data = local.jinja_context
  }

  source {
    directory = dirname(local.configuration_template_path)
    template  = file(local.configuration_template_path)
  }
}

data "jinja_template" "init_script" {
  context {
    type = "json"
    data = local.jinja_context
  }

  source {
    directory = dirname(local.init_script_template_path)
    template  = file(local.init_script_template_path)
  }
}
