# Crystal implementation of view helper for https://github.com/basecamp/local_time
module LocalTimeHelper
  VERSION = "0.2.1"

  DEFAULT_TIME_FORMAT = "%B %e, %Y %l:%M%p"

  def local_time(time : Time?, format : String = DEFAULT_TIME_FORMAT, **options)
    known_options = %w[nil_message]

    if time.nil?
      if (nil_message = options[:nil_message]?)
        return nil_message
      else
        raise ArgumentError.new("time argument was nil, but no nil_message was provided")
      end
    end

    time = utc_time(time)

    html_options = options.map { |k, v|
      if known_options.includes?(k)
        nil
      else
        "#{HTML.escape(k.to_s)}=\"#{HTML.escape(v.to_s)}\""
      end
    }.compact.join(" ")

    String.build do |html|
      html << "<time data-format=\"#{format_for_data(format)}\" data-local=\"time\" datetime=\"#{time.to_s("%FT%XZ")}\""
      html << " " << html_options if html_options != ""
      html << ">#{time.to_s(format)}</time>"
    end
  end

  def local_time(time : Time?, *, format : String, **options)
    local_time(time, format, **options)
  end

  def local_date(time : Time?, format : String = "%B %e, %Y", **options)
    local_time(time, format, **options)
  end

  def local_date(time : Time?, *, format : String, **options)
    local_time(time, format, **options)
  end

  def local_relative_time(time : Time?, type : String = "time-or-date", **options)
    if time.nil?
      if (nil_message = options[:nil_message]?)
        return nil_message
      else
        raise ArgumentError.new("time argument was nil, but no nil_message was provided")
      end
    end

    time = utc_time(time)

    html_options = options.map { |k, v|
      "#{HTML.escape(k.to_s)}=\"#{HTML.escape(v)}\""
    }.compact.join(" ")

    String.build do |html|
      html << "<time data-local=\"#{type}\" datetime=\"#{time.to_s("%FT%XZ")}\""
      html << " " << html_options if html_options != ""
      html << ">#{time.to_s(DEFAULT_TIME_FORMAT)}</time>"
    end
  end

  def local_relative_time(time : Time?, *, type : String, **options)
    local_relative_time(time, type)
  end

  def local_time_ago(time : Time?, **options)
    local_relative_time(time, "time-ago", **options)
  end

  private def utc_time(time)
    time.to_utc
  end

  # account for differences between crystal's format strings and javascript's
  private def format_for_data(fmt)
    # crystal's %p/%P make sense, but are the opposite of other implementations
    placeholder = "X$k?kjEvRtADE9mqzgFVWd7v" # use long random string as placeholder
    fmt.gsub("%P", placeholder).gsub("%p", "%P").gsub(placeholder, "%p")
  end
end
