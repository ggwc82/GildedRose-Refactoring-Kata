require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "normal item decrements both sellIn and quality" do
      items = [Item.new("bar", 10, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq(9)
      expect(items[0].quality).to eq(9)
    end

    it "Once the sell by date has passed, Quality degrades twice as fast" do
      items = [Item.new("foo", 0, 6)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq(-1)
      expect(items[0].quality).to eq(4)
    end

    it "The Quality of an item is never negative" do
      items = [Item.new("foo", 0, 1)]
      GildedRose.new(items).update_quality()
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq(0)
    end

    it "Aged Brie actually increases in Quality the older it gets" do
      items = [Item.new(name="Aged Brie", sell_in=2, quality=0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq(1)
    end

    it "The Quality of an item is never more than 50" do
      items = [Item.new(name="Aged Brie", sell_in=2, quality=50)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq(50)
    end

    it "Sulfuras, being a legendary item, never has to be sold or decreases in Quality" do
      items = [Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=-1, quality=80)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq(80)            
    end

    it '"Backstage passes", like aged brie, increases in Quality as its SellIn value approaches' do
      items = [Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=15, quality=20)]
      5.times  { GildedRose.new(items).update_quality() }
      expect(items[0].quality).to eq(25)
      expect(items[0].sell_in).to eq(10)  
    end

    it "Quality increases by 2 when there are 10 days or less" do
      items = [Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=10, quality=20)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq(22)
    end

    it "Quality increases by 3 when there are 5 days or less" do
      items = [Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=5, quality=20)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq(23)
    end

    it "Quality drops to 0 after the concert" do
      items = [Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=0, quality=20)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq(0)
    end
  end
end
