class Transaction::TransferTaxs

  def initialize(ammount)
    @ammount = ammount
  end

  def weekend?
    date = Time.now
    date.saturday? || date.sunday?
  end

  def start_date_time
    Time.zone.parse('9am')
  end

  def end_date_time
    Time.zone.parse('18pm')
  end

  def cover_time?
    (start_date_time..end_date_time).cover?(Time.now) unless weekend?
  end

  def comercial_time
    if cover_time?
      5
    else
      7
    end
  end

  def valor
    @ammount > 1000.00 ? 10 : 0
  end

  def total
   comercial_time + valor
  end

  def calculate
    total
  end
end