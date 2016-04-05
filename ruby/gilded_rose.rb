class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        decrease_quality(item)
      else
        if item.quality < 50
          item.quality = item.quality + 1
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            increase_quality(item) if item.sell_in < 11
            increase_quality(item) if item.sell_in < 6
          end
        end
      end
      decrease_sell_in(item)
      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            decrease_quality(item) 
          else
            item.quality = item.quality - item.quality
          end
        else
          increase_quality(item)
        end
      end
    end
  end

  private


  def decrease_quality(item)
    if item.name != "Sulfuras, Hand of Ragnaros" && item.quality > 0
      item.quality = item.quality - 1
    end
  end

  def increase_quality(item)
    if item.quality < 50
      item.quality = item.quality + 1
    end
  end

  def decrease_sell_in(item)
    if item.name != "Sulfuras, Hand of Ragnaros"
      item.sell_in = item.sell_in - 1
    end
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