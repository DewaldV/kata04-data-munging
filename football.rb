require "test/unit"

def smallest_goal_difference(days)
  min_day = days.min { |a, b| (a["For"] - a["Against"]).abs <=> (b["For"] - b["Against"]).abs }
  min_day["Name"]
end

def load_football(path)
  padded_lines   = File.open(path).map { |line| '%-60.60s' % line  }
  filtered_lines = padded_lines.select { |line| line.lstrip =~ /^\d+.*$/  }
  teams = filtered_lines.map do |line|
    {
      "Name"    => line.slice(7,16).strip,
      "For"     => line.slice(43,3).gsub(/\D/, '').to_i,
      "Against" => line.slice(50,3).gsub(/\D/, '').to_i
    }
  end
end

class TestFootball < Test::Unit::TestCase
  def test_smallest_difference
    test_teams = [
      { "Name" => "TeamA", "For" => 10, "Against" => 5 },
      { "Name" => "TeamB", "For" => 20, "Against" => 18 },
      { "Name" => "TeamC", "For" => 10, "Against" => 30 } ]

    assert_equal("TeamB", smallest_goal_difference(test_teams))
  end

  def test_load_football
    teams = load_football('football.dat')
    assert_equal({ "Name" => "Arsenal", "For" => 79, "Against" => 36 }, teams[0] )
  end

  def test_find_smallest_goal_difference
    teams = load_football('football.dat')
    assert_equal("Aston_Villa", smallest_goal_difference(teams))
  end
end
