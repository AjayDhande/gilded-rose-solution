require 'delegate'

class GildedRose
  attr_accessor :items

  def initialize(items)
    @items = items
  end

  def update_item_quality
    items.each do |item|
      ItemsWrapper.wrap(item).update
    end
  end
end

class ItemsWrapper < SimpleDelegator
  def self.wrap(item)
    case item.name
    when "Aged Brie"
      AgedBrieItem.new(item)
    when "Backstage passes to a TAFKAL80ETC concert"
      BackstagePassItem.new(item)
    when "Conjured Mana Cake"
      ConjuredItem.new(item)
    when "Sulfuras, Hand of Ragnaros"
      SulfurasItem.new(item)
    else
      new(item)
    end
  end

  def update
    return if name == "Sulfuras, Hand of Ragnaros"

    item_age
    update_item_quality
  end

  def item_age
    self.sell_in -= 1
  end

  def update_item_quality
    self.quality += caluculate_item_quality_adjustment
  end

  def caluculate_item_quality_adjustment
    adjustment = 0

    if sell_in < 0
      adjustment -= 1
    else
      adjustment -= 1
    end

    adjustment
  end

  def quality=(new_quality)
    new_quality = 0 if new_quality < 0
    new_quality = 50 if new_quality > 50
    super(new_quality)
  end
end

class AgedBrieItem < ItemsWrapper
  def caluculate_item_quality_adjustment
    adjustment = 1
    if sell_in < 0
      adjustment += 1
    end

    adjustment
  end
end

class BackstagePassItem < ItemsWrapper
  def caluculate_item_quality_adjustment
    adjustment = 1
    if sell_in < 11
      adjustment += 1
    end
    if sell_in < 6
      adjustment += 1
    end
    if sell_in < 0
      adjustment -= quality
    end

    adjustment
  end
end

class ConjuredItem < ItemsWrapper
  def caluculate_item_quality_adjustment
    adjustment = -2
    if sell_in < 0
      adjustment -= 2
    end

    adjustment
  end
end

class SulfurasItem < ItemsWrapper
  def caluculate_item_quality_adjustment
    # This item does not change
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
