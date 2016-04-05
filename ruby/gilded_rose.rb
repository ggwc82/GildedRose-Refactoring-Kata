class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      neither_brie_or_backstage_pass(item) ? decrease_quality(item) : increase_quality_if_less_than_fifty(item)
      decrease_sell_in(item)
      if_negative_sell_in(item) 
    end
  end

  private

  def neither_brie_or_backstage_pass(item)
    not_aged_brie?(item) && not_backstage_pass?(item)
  end

  def increase_quality_if_less_than_fifty(item)
    if quality_less_than_fifty?(item)
      increase_quality(item)
      is_backstage_pass(item) unless not_backstage_pass?(item)
    end
  end

  def is_not_backstage_pass(item)
    not_backstage_pass?(item) ? decrease_quality(item) : item.quality = 0;   
  end

  def if_negative_sell_in(item)
    if item.sell_in < 0
      not_aged_brie?(item) ? is_not_backstage_pass(item) : increase_quality(item)
    end
  end

  def is_backstage_pass(item)
    increase_quality(item) if item.sell_in < 11
    increase_quality(item) if item.sell_in < 6
  end

  def decrease_quality(item)
    item.quality -= 1 if not_sulfuras(item) && positive_quality(item)
  end

  def increase_quality(item)
    item.quality += 1 if quality_less_than_fifty?(item)
  end

  def decrease_sell_in(item)
    item.sell_in -= 1 if not_sulfuras(item)
  end

  def quality_less_than_fifty?(item)
    item.quality < 50
  end

  def not_aged_brie?(item)
    item.name != "Aged Brie"
  end

  def not_backstage_pass?(item)
    item.name != "Backstage passes to a TAFKAL80ETC concert"
  end

  def not_sulfuras(item)
    item.name != "Sulfuras, Hand of Ragnaros"
  end

  def positive_quality(item)
    item.quality > 0
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