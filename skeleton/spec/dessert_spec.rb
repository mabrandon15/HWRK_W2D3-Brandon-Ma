require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef", name: "Brandon") }
  let(:donut) { Dessert.new("donut", 70, chef) }

  describe "#initialize" do
    it "sets a type" do 
      expect(donut.type).to eq("donut")
    end

    it "sets a quantity" do 
      expect(donut.quantity).to eq(70)
    end
    
    it "starts ingredients as an empty array" do 
      expect(donut.ingredients).to eq([])
    end

    it "raises an argument error when given a non-integer quantity" do 
      expect { Dessert.new("canoli", "twenny-won", chef) }.to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do 
      donut.add_ingredient("glazing")
      expect(donut.ingredients).to include("glazing")
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      ingredients = ["egg", "flour", "sugar", "milk", "yeast"]
      
      ingredients.each do |ingredient|
        donut.add_ingredient(ingredient)
      end 
      
      expect(donut.ingredients).to eq(ingredients)
      donut.mix!
      expect(donut.ingredients).not_to eq(ingredients)
      expect(donut.ingredients.sort).to eq(ingredients.sort)
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do 
      donut.eat(28)
      expect(donut.quantity).to eq(42)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect { donut.eat(71) }.to raise_error("not enough left!")
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      expect(chef).to receive(:titleize).and_return("Chef Brandon the Great Baker")
      expect(donut.serve).to eq("Chef Brandon the Great Baker has made 70 donuts!")
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      expect(chef).to receive(:bake).with(donut)
      donut.make_more
    end
  end
end
