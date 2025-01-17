require_relative '../app'

RSpec.describe Application do
  before(:each) do
    reset_stock_table
  end

  it 'it displays the options menu to the user' do
    io = double :Kernel
    app = Application.new(io)
    expect(io).to receive(:puts).with(app.menu_string)
    expect(io).to receive(:gets).and_return('quit')

    app.run
  end

  it 'displays a list of all items' do
    io = double :Kernel
    app = Application.new(io)
    expect(io).to receive(:puts).with(app.menu_string)
    expect(io).to receive(:gets).and_return('1')
    expect(io).to receive(:puts).with("Id: 1 - Item: pens - £2 - Qty: 234")
    expect(io).to receive(:puts).with("Id: 2 - Item: pencils - £1 - Qty: 998")
    expect(io).to receive(:puts).with("Id: 3 - Item: paper - £5 - Qty: 123")
    expect(io).to receive(:puts).with("Id: 4 - Item: brush - £4 - Qty: 927")
    expect(io).to receive(:puts).with(
      app.menu_string
    )
    expect(io).to receive(:gets).and_return('quit')

    app.run
  end

  it 'creates an item' do
    io = double :Kernel
    app = Application.new(io)
    expect(io).to receive(:puts).with(app.menu_string)
    expect(io).to receive(:gets).and_return('2')
    expect(io).to receive(:puts).with(
      "Please enter the name of the item to add:"
    )
    expect(io).to receive(:gets).and_return('eraser')
    expect(io).to receive(:puts).with(
      "Please enter the price of the item:"
    )
    expect(io).to receive(:gets).and_return('1')
    expect(io).to receive(:puts).with(
      "Please enter the quantity of the item:"
    )
    expect(io).to receive(:gets).and_return('777')
    expect(io).to receive(:puts).with(
      "Id: 5 - Item: eraser - £1 - Qty: 777 added"
    )
    expect(io).to receive(:puts).with(app.menu_string)
    expect(io).to receive(:gets).and_return('quit')

    app.run
  end

  it 'displays a list of orders' do
    io = double :Kernel
    app = Application.new(io)
    expect(io).to receive(:puts).with(app.menu_string)
    expect(io).to receive(:gets).and_return('3')
    expect(io).to receive(:puts).with("Id: 1 - Customer: Mike - Order date: 2023-04-28")
    expect(io).to receive(:puts).with("Id: 2 - Customer: Steve - Order date: 2023-04-27")
    expect(io).to receive(:puts).with(
      app.menu_string
    )
    expect(io).to receive(:gets).and_return('quit')

    app.run
  end

  it 'creates a new order' do
    io = double :Kernel
    date = double :Date, today: '2023-04-29'
    app = Application.new(io, date)
    expect(io).to receive(:puts).with(app.menu_string)
    expect(io).to receive(:gets).and_return('4')
    expect(io).to receive(:puts).with("Please enter the customer name:")
    expect(io).to receive(:gets).and_return("Barney")
    expect(io).to receive(:puts).with(
      "Id: 3 - Customer: Barney - Order date: 2023-04-29 added"
    )
    expect(io).to receive(:puts).with(
      app.menu_string
    )
    expect(io).to receive(:gets).and_return('quit')

    app.run
  end

  it 'adds items to order' do
    io = double :Kernel
    app = Application.new(io)
    expect(io).to receive(:puts).with(app.menu_string)
    expect(io).to receive(:gets).and_return('5')
    expect(io).to receive(:puts).with("Please enter the order id:")
    expect(io).to receive(:gets).and_return('1')
    expect(io).to receive(:puts).with("Please enter the item id:")
    expect(io).to receive(:gets).and_return('1')
    expect(io).to receive(:puts).with(
      "pens have been added to Mike's order"
    )
    expect(io).to receive(:puts).with(app.menu_string)
    expect(io).to receive(:gets).and_return('quit')

    app.run
  end

  context 'invalid user inputs' do
    it 'refuses invalid entries for menu' do
      io = double :Kernel
      app = Application.new(io)
      expect(io).to receive(:puts).with(app.menu_string)
      expect(io).to receive(:gets).and_return('potato')
      expect(io).to receive(:puts).with(
        "Please choose one of the valid options or type 'quit' to close the application"
      )
      expect(io).to receive(:puts).with(app.menu_string)
      expect(io).to receive(:gets).and_return('quit')
  
      app.run
    end

    it 'refuses invalid entries for item price' do
      io = double :Kernel
      app = Application.new(io)
      expect(io).to receive(:puts).with(app.menu_string)
      expect(io).to receive(:gets).and_return('2')
      expect(io).to receive(:puts).with(
        "Please enter the name of the item to add:"
      )
      expect(io).to receive(:gets).and_return('eraser')
      expect(io).to receive(:puts).with(
        "Please enter the price of the item:"
      )

      expect(io).to receive(:gets).and_return('potato')
      expect(io).to receive(:puts).with(
        "Please enter a valid price for an item"
      )
      expect(io).to receive(:puts).with(
        "Please enter the price of the item:"
      )

      expect(io).to receive(:gets).and_return('1')
      expect(io).to receive(:puts).with(
        "Please enter the quantity of the item:"
      )
      expect(io).to receive(:gets).and_return('777')
      expect(io).to receive(:puts).with(
        "Id: 5 - Item: eraser - £1 - Qty: 777 added"
      )
      expect(io).to receive(:puts).with(app.menu_string)
      expect(io).to receive(:gets).and_return('quit')

      app.run
    end

    it 'refuses invalid entries for item quantity' do
      io = double :Kernel
      app = Application.new(io)
      expect(io).to receive(:puts).with(app.menu_string)
      expect(io).to receive(:gets).and_return('2')
      expect(io).to receive(:puts).with(
        "Please enter the name of the item to add:"
      )
      expect(io).to receive(:gets).and_return('eraser')
      expect(io).to receive(:puts).with(
        "Please enter the price of the item:"
      )
      expect(io).to receive(:gets).and_return('1')
      expect(io).to receive(:puts).with(
        "Please enter the quantity of the item:"
      )

      expect(io).to receive(:gets).and_return('potato')
      expect(io).to receive(:puts).with(
        "Please enter a valid quantity for an item"
      )
      expect(io).to receive(:puts).with(
        "Please enter the quantity of the item:"
      )

      expect(io).to receive(:gets).and_return('777')
      expect(io).to receive(:puts).with(
        "Id: 5 - Item: eraser - £1 - Qty: 777 added"
      )
      expect(io).to receive(:puts).with(app.menu_string)
      expect(io).to receive(:gets).and_return('quit')

      app.run
    end

    it 'refuses invalid entries for order id' do
      io = double :Kernel
      app = Application.new(io)
      expect(io).to receive(:puts).with(app.menu_string)
      expect(io).to receive(:gets).and_return('5')
      expect(io).to receive(:puts).with("Please enter the order id:")
      expect(io).to receive(:gets).and_return('potato')
      expect(io).to receive(:puts).with("This order id is invalid. Please try again")
      expect(io).to receive(:puts).with("Please enter the order id:")
      expect(io).to receive(:gets).and_return('1')
      expect(io).to receive(:puts).with("Please enter the item id:")
      expect(io).to receive(:gets).and_return('1')
      expect(io).to receive(:puts).with("pens have been added to Mike's order")
      expect(io).to receive(:puts).with(app.menu_string)
      expect(io).to receive(:gets).and_return('quit')

      app.run
    end

    it 'refuses invalid entries for item id' do
      io = double :Kernel
      app = Application.new(io)
      expect(io).to receive(:puts).with(app.menu_string)
      expect(io).to receive(:gets).and_return('5')
      expect(io).to receive(:puts).with("Please enter the order id:")
      expect(io).to receive(:gets).and_return('1')
      expect(io).to receive(:puts).with("Please enter the item id:")
      expect(io).to receive(:gets).and_return('potato')
      expect(io).to receive(:puts).with("This item id is invalid. Please try again")
      expect(io).to receive(:puts).with("Please enter the item id:")
      expect(io).to receive(:gets).and_return('1')
      expect(io).to receive(:puts).with("pens have been added to Mike's order")
      expect(io).to receive(:puts).with(app.menu_string)
      expect(io).to receive(:gets).and_return('quit')

      app.run
    end

  end

end
