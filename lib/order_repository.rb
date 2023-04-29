require_relative 'order'

class OrderRepository
  def list
    # query = 'SELECT id, customer_name, date FROM orders;'
    # returns an array of Order objects
    query = 'SELECT id, customer_name, date FROM orders;'
    entries = DatabaseConnection.exec_params(query, [])
    orders = []
    for entry in entries do
      order = Order.new
      order.id = entry["id"]
      order.customer_name = entry["customer_name"]
      order.date = entry["date"]
      orders << order
    end
    return orders
  end

  def assign_item(order, item)
    # query = 'INSERT INTO orders_items (order_id, item_id) VALUES ($1, $2);'
    # params = [order.id, item.id]
  end

  def create(order)
    # query = 'INSERT INTO orders (customer_name, date) VALUES ($1, $2);'
    # params = [order.customer_name, order.date]
    query1 = 'INSERT INTO orders (customer_name, date) VALUES ($1, $2);'
    params = [order.customer_name, order.date]
    DatabaseConnection.exec_params(query1, params)
    query2 = 'SELECT max(id) FROM orders'
    id = DatabaseConnection.exec_params(query2, []).to_a.first["max"]
    return id
  end
end
