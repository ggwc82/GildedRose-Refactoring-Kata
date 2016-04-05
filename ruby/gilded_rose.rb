class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if not_aged_brie?(item) && not_backstage_pass?(item)
        decrease_quality(item)
      else
        if item.quality < 50
          increase_quality(item)
          is_backstage_pass(item) unless not_backstage_pass?(item)
        end
      end
      decrease_sell_in(item)
      if item.sell_in < 0
        if not_aged_brie?(item)
          is_not_backstage_pass(item)
        else
          increase_quality(item)
        end
      end
    end
  end

  private

  def is_not_backstage_pass(item)
    not_backstage_pass?(item) ? decrease_quality(item) : item.quality = 0;   
  end

  def is_backstage_pass(item)
    increase_quality(item) if item.sell_in < 11
    increase_quality(item) if item.sell_in < 6
  end

  def decrease_quality(item)
    item.quality -= 1 if not_sulfuras(item) && positive_quality(item)
  end

  def increase_quality(item)
    item.quality += 1 if item.quality < 50
  end

  def decrease_sell_in(item)
    item.sell_in -= 1 if not_sulfuras(item)
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