require "./spec_helper"
require "../src/local_time_helper.cr"

include LocalTimeHelper

def example_time_utc
  Time.utc(2013, 11, 21, 6)
end

def example_time_js_str
  "2013-11-21T06:00:00Z"
end

describe LocalTimeHelper do
  Spec.before_each do
    # @original_zone = Time.zone
    # Time.zone = ActiveSupport::TimeZone["Central Time (US & Canada)"]
    # I18n.backend.store_translations(:en, {
    #   time: { formats: { simple_time: "%b %e" } },
    #   date: { formats: { simple_date: "%b %e" } } })
    # Time::DATE_FORMATS[:time_formats_simple_time] = '%b %e'
    # Date::DATE_FORMATS[:date_formats_simple_date] = '%b %e'

    # @date = "2013-11-21"
    # @time = Time.zone.parse(@date)
    # @time_utc = "2013-11-21 06:00:00 UTC"
    # @time_js = "2013-11-21T06:00:00Z"
  end

  Spec.after_each do
    # Time.zone = @original_zone
  end

  # def test_utc_time_with_a_date
  #   date = Date.parse(@date)
  #   assert_equal @time_utc, utc_time(date).to_s
  # end

  # def test_utc_time_with_a_local_time
  #   assert_equal @time_utc, utc_time(@time).to_s
  # end

  # def test_utc_time_with_a_utc_time
  #   assert_equal @time_utc, utc_time(@time.utc).to_s
  # end

  describe "local_time" do
    it "outputs provided string if nil (NEW)" do
      msg = "never"
      local_time(nil, nil_message: msg).should eq msg
      local_time(nil, "%b %e", nil_message: msg).should eq msg
      local_time(nil, format: "%b %e", nil_message: msg).should eq msg
    end

    it "outputs time element in default format if none provided" do
      time = example_time_utc
      expected = %(<time data-format="%B %e, %Y %l:%M%P" data-local="time" datetime="#{example_time_js_str}">November 21, 2013  6:00am</time>)
      local_time(time).should eq expected
    end

    it "outputs time element in provided format (named argument)" do
      time = example_time_utc
      expected = %(<time data-format="%b %e" data-local="time" datetime="#{example_time_js_str}">Nov 21</time>)
      local_time(time, format: "%b %e").should eq expected
    end

    it "outputs time element in provided format (string argument)" do
      time = example_time_utc
      expected = %(<time data-format="%b %e" data-local="time" datetime="#{example_time_js_str}">Nov 21</time>)
      local_time(time, "%b %e").should eq expected
    end

    it "outputs time element in provided format with options" do
      time = example_time_utc
      expected = %(<time data-format="%b %e" data-local="time" datetime="#{example_time_js_str}" style="display:none">Nov 21</time>)
      local_time(time, "%b %e", style: "display:none").should eq expected
    end

    # def test_local_time_with_i18n_format
    #   expected = %Q(<time data-format="%b %e" data-local="time" datetime="#{@time_js}">Nov 21</time>)
    #   assert_dom_equal expected, local_time(@time, format: :simple_time)
    # end

    # def test_local_time_with_date_formats_format
    #   expected = %Q(<time data-format="%b %e" data-local="time" datetime="#{@time_js}">Nov 21</time>)
    #   assert_dom_equal expected, local_time(@time, format: :time_formats_simple_time)
    # end

    # def test_local_time_with_missing_i18n_and_date_formats_format
    #   expected = %Q(<time data-format="%B %e, %Y %l:%M%P" data-local="time" datetime="#{@time_js}">November 21, 2013  6:00am</time>)
    #   assert_dom_equal expected, local_time(@time, format: :missing_format)
    # end

    # def test_local_time_with_date_formats_proc_format
    #   Time::DATE_FORMATS[:proc] = proc { |time| "nope" }
    #   expected = %Q(<time data-format="%B %e, %Y %l:%M%P" data-local="time" datetime="#{@time_js}">November 21, 2013  6:00am</time>)
    #   assert_dom_equal expected, local_time(@time, format: :proc)
    # end
  end

  describe "local_date" do
    it "outputs provided string if nil (NEW)" do
      msg = "never"
      local_date(nil, nil_message: msg).should eq msg
      local_date(nil, "%B %e, %Y", nil_message: msg).should eq msg
      local_date(nil, format: "%B %e, %Y", nil_message: msg).should eq msg
    end

    it "outputs time element in default format if none provided" do
      time = example_time_utc
      expected = %(<time data-format="%B %e, %Y" data-local="time" datetime="#{example_time_js_str}">November 21, 2013</time>)
      local_date(time).should eq expected
    end

    it "outputs time element in provided format (named argument)" do
      time = example_time_utc
      expected = %(<time data-format="%b %e" data-local="time" datetime="#{example_time_js_str}">Nov 21</time>)
      local_date(time, format: "%b %e").should eq expected
    end

    it "outputs time element in provided format (string argument)" do
      time = example_time_utc
      expected = %(<time data-format="%b %e" data-local="time" datetime="#{example_time_js_str}">Nov 21</time>)
      local_date(time, "%b %e").should eq expected
    end

    # def test_local_date_with_i18n_format
    #   expected = %Q(<time data-format="%b %e" data-local="time" datetime="#{@time_js}">Nov 21</time>)
    #   assert_dom_equal expected, local_date(@time.to_date, format: :simple_date)
    # end

    # def test_local_date_with_date_formats_format
    #   expected = %Q(<time data-format="%b %e" data-local="time" datetime="#{@time_js}">Nov 21</time>)
    #   assert_dom_equal expected, local_date(@time.to_date, format: :date_formats_simple_date)
    # end

    # def test_local_date_with_missing_i18n_and_date_formats_format
    #   expected = %Q(<time data-format="%B %e, %Y %l:%M%P" data-local="time" datetime="#{@time_js}">November 21, 2013  6:00am</time>)
    #   assert_dom_equal expected, local_date(@time.to_date, format: :missing_date_format)
    # end
  end

  describe "local_time_ago" do
    it "outputs provided string if nil (NEW)" do
      msg = "never"
      local_time_ago(nil, nil_message: msg).should eq msg
      local_time_ago(nil, format: "%B %e, %Y", nil_message: msg).should eq msg
    end

    it "should return time element with data-local=\"time-ago\"" do
      time = example_time_utc
      expected = %(<time data-local="time-ago" datetime="#{example_time_js_str}">November 21, 2013  6:00am</time>)
      local_time_ago(time).should eq expected
    end

    it "should return time element with data-local=\"time-ago\" with provided html options" do
      time = example_time_utc
      expected = %(<time data-local="time-ago" datetime="#{example_time_js_str}">November 21, 2013  6:00am</time>)
      local_time_ago(time, class: "date-time")
    end
  end

  describe "local_relative_time" do
    it "should return time element with data-local=\"time-or-date\" (named argument)" do
      time = example_time_utc
      expected = %(<time data-local="time-or-date" datetime="#{example_time_js_str}">November 21, 2013  6:00am</time>)
      local_relative_time(time, type: "time-or-date").should eq expected
    end

    it "should return time element with data-local=\"time-or-date\" (string argument)" do
      time = example_time_utc
      expected = %(<time data-local="time-or-date" datetime="#{example_time_js_str}">November 21, 2013  6:00am</time>)
      local_relative_time(time, "time-or-date").should eq expected
    end
  end
end
