# frozen_string_literal: true

require "herb"

module ActionView
  class Template
    module Handlers
      class ERB
        class Herb < ::Herb::Engine
          # :nodoc: all
          def initialize(input, properties = {})
            @newline_pending = 0

            # Dup properties so that we don't modify argument
            properties = Hash[properties]

            properties[:bufvar]     ||= "@output_buffer"
            properties[:preamble]   ||= ""
            properties[:postamble]  ||= "#{properties[:bufvar]}"

            # Tell Herb whether the template will be compiled with `frozen_string_literal: true`
            properties[:freeze_template_literals] = !Template.frozen_string_literal

            properties[:escapefunc] = ""

            super
          end

        private
          def add_text(text)
            return if text.empty?

            if text == "\n"
              @newline_pending += 1
            else
              with_buffer do
                src << ".safe_append='"
                src << "\n" * @newline_pending if @newline_pending > 0
                src << text.gsub(/['\\]/, '\\\\\&') << @text_end
              end
              @newline_pending = 0
            end
          end

          def add_expression(indicator, code)
            add_rails_expression(indicator, code, wrap_parentheses: true)
          end

          def add_expression_block(indicator, code)
            add_rails_expression(indicator, code, wrap_parentheses: false)
          end

          def add_rails_expression(indicator, code, wrap_parentheses:)
            flush_newline_if_pending(@src)

            with_buffer do
              @src << if (indicator == "==") || @escape
                        ".safe_expr_append="
                      else
                        ".append="
                      end

              if wrap_parentheses
                @src << "(" << code << ")"
              else
                @src << " " << code
              end
            end
          end

          def add_code(code)
            flush_newline_if_pending(@src)
            super
          end

          def add_postamble(_)
            flush_newline_if_pending(@src)
            super
          end

          def flush_newline_if_pending(src)
            return unless @newline_pending.positive?

            with_buffer { src << ".safe_append='#{"\n" * @newline_pending}" << @text_end }
            @newline_pending = 0
          end
        end
      end
    end
  end
end
