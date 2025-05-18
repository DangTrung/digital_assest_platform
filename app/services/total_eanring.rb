class TotalEanring
  def creator_total_eanring
    ActiveRecord::Base.connection.execute(
      <<~SQL.squish,
        select
          u.name,
          sum(a.price * pi.quantity) as total_earnings
        from
          purchases p
          join purchase_items pi on p.id = pi.purchase_id
          join assets a on pi.asset_id = a.id
          join users u on a.user_id = u.id
        where
          u.role = 1 and p.payable = true
        group by
          u.name
        order by
          u.name
      SQL
      ).values
  end
  def customer_total_eanring
    ActiveRecord::Base.connection.execute(
      <<~SQL.squish,
        select
          u.name,
          sum(a.price * pi.quantity) as total_earnings
        from
          purchases p
          join purchase_items pi on p.id = pi.purchase_id
          join assets a on pi.asset_id = a.id
          join users u on a.user_id = u.id
        where
          u.role = 2 and p.payable = true
        group by
          u.name
        order by
          u.name
      SQL
      ).values
  end
end