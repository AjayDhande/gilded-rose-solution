require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require "./gilded_rose"

class CharacterizationTest < Minitest::Test
  def setup
    @items = []
    @items << Item.new("+5 Dexterity Vest", 10, 20)
    @items << Item.new("Aged Brie", 2, 0)
    @items << Item.new("Elixir of the Mongoose", 5, 7)
    @items << Item.new("Sulfuras, Hand of Ragnaros", 0, 80)
    @items << Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)
    @items << Item.new("Conjured Mana Cake", 3, 6)
    @rose = GildedRose.new(@items)
    @items = @rose.instance_variable_get(:@items)
  end

  attr_reader :rose, :items

  def test_after_1_day
    rose.update_item_quality
    assert_items([9, 19], [1, 1], [4, 6], [0, 80], [14, 21], [2, 4])
  end

  def test_after_2_days
    2.times { rose.update_item_quality }
    assert_items([8, 18], [0, 2], [3, 5], [0, 80], [13, 22], [1, 2])
  end

  def test_after_3_days
    3.times { rose.update_item_quality }
    assert_items([7, 17], [-1, 4], [2, 4], [0, 80], [12, 23], [0, 0])
  end

  def test_after_4_days
    4.times { rose.update_item_quality }
    assert_items([6, 16], [-2, 6], [1, 3], [0, 80], [11, 24], [-1, 0])
  end

  def test_after_5_days
    5.times { rose.update_item_quality }
    assert_items([5, 15], [-3, 8], [0, 2], [0, 80], [10, 26], [-2, 0])
  end

  def test_after_6_days
    6.times { rose.update_item_quality }
    assert_items([4, 14], [-4, 10], [-1, 1], [0, 80], [9, 28], [-3, 0])
  end

  def test_after_7_days
    7.times { rose.update_item_quality }
    assert_items([3, 13], [-5, 12], [-2, 0], [0, 80], [8, 30], [-4, 0])
  end

  def test_after_8_days
    8.times { rose.update_item_quality }
    assert_items([2, 12], [-6, 14], [-3, 0], [0, 80], [7, 32], [-5, 0])
  end

  def test_after_9_days
    9.times { rose.update_item_quality }
    assert_items([1, 11], [-7, 16], [-4, 0], [0, 80], [6, 34], [-6, 0])
  end

  def test_after_10_days
    10.times { rose.update_item_quality }
    assert_items([0, 10], [-8, 18], [-5, 0], [0, 80], [5, 37], [-7, 0])
  end

  def test_after_11_days
    11.times { rose.update_item_quality }
    assert_items([-1, 9], [-9, 20], [-6, 0], [0, 80], [4, 40], [-8, 0])
  end

  def test_after_12_days
    12.times { rose.update_item_quality }
    assert_items([-2, 8], [-10, 22], [-7, 0], [0, 80], [3, 43], [-9, 0])
  end

  private

  def assert_items(*expected_items)
    expected_items.zip(items) do |(sell_in, quality), item|
      assert_equal(sell_in, item.sell_in, "#{item.name} sell_in")
      assert_equal(quality, item.quality, "#{item.name} quality")
    end
  end
end