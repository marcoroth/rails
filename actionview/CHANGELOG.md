*   Add Herb as an opt-in HTML-aware ERB engine for ActionView.

    Herb is an HTML-aware ERB rendering engine that parses and understands HTML structure during template compilation. Unlike traditional regex-based ERB parsing, Herb parses templates into a syntax tree that understands HTML semantics, guaranteeing that templates cannot produce invalid HTML markup.

    Herb is API-compatible with `Erubi::Engine` and is specifically designed for HTML+ERB templates. Herb parses both ERB and HTML into a unified syntax tree, guaranteeing valid HTML output by validating structure during compilation.

    Because Herb understands the document structure and HTML semantics, it enables significantly better error reporting with enhanced error screens showing precise error locations with line and column information.

    This semantic understanding also enables future developer
    experience improvements like intelligent code completion, context-aware suggestions, and compile-time HTML validation, as well as performance optimizations and automatic context-based escaping, that should help prevent XSS in the future.

    Herb can be enabled for HTML templates via configuration:

        config.action_view.use_herb_for_html = true

    When enabled, HTML templates (`.html.erb`) will use Herb while all non-HTML templates (`.text.erb`, `.json.erb`, `.xml.erb`, etc.) will automatically fall back to `Erubi::Engine`. All existing `.html.erb` templates remain fully backward compatible, given they contain valid HTML markup.

    *Marco Roth*

*   Add `key:` and `expires_in:` options under `cached:` to `render` when used with `collection:`

    *Jarrett Lusso*

Please check [8-1-stable](https://github.com/rails/rails/blob/8-1-stable/actionview/CHANGELOG.md) for previous changes.
