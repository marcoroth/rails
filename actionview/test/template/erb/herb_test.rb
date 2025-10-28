# frozen_string_literal: true

require "abstract_unit"
require "action_view/template/handlers/erb/herb"

class HerbTest < ActiveSupport::TestCase
  test "can configure bufvar" do
    template = <<~ERB
      foo

      <%= "foo".upcase %>

      <%== "foo".length %>
    ERB

    baseline = ActionView::Template::Handlers::ERB::Herb.new(template)
    herb = ActionView::Template::Handlers::ERB::Herb.new(template, bufvar: "boofer")

    assert_equal baseline.src.gsub(baseline.bufvar, "boofer"), herb.src
  end
end
