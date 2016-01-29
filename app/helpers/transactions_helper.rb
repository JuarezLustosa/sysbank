module TransactionsHelper
   def change_color_tr(item)
    "danger" if item.negative?
  end
end
