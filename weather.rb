require "test/unit"

def smallest_spread_day(days)
  min_day = days.min { |a, b| (a["MxT"] - a["MnT"]) <=> (b["MxT"] - b["MnT"]) }
  min_day["Dy"]
end

def load_weather(path)
  padded_lines = File.open(path).map { |line| '%-90.90s' % line  }
  days = padded_lines.map do |line|
    {
      "Dy"  => line.slice(2,2).to_i,
      "MxT" => line.slice(6,4).gsub(/\D/, '').to_f,
      "MnT" => line.slice(12,4).gsub(/\D/, '').to_f
    }
  end
  days.select { |d| d["Dy"] > 0 }
end

class TestWeather < Test::Unit::TestCase
  def test_smallest_spread
    test_days = [
      { "Dy" => 1, "MxT" => 60.0, "MnT" => 55.0 },
      { "Dy" => 2, "MxT" => 56.0, "MnT" => 55.0 },
      { "Dy" => 3, "MxT" => 65.0, "MnT" => 55.0 } ]

    assert_equal(2, smallest_spread_day(test_days))
  end

  def test_load_Weather
    days = load_weather('weather.dat')
    assert_equal({ "Dy" => 1, "MxT" => 88.0, "MnT" => 59.0 }, days[0] )
  end

  def test_find_smallest_spread
    days = load_weather('weather.dat')
    assert_equal(14, smallest_spread_day(days))
  end
end
