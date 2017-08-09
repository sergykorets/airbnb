class AirbnbWorker
	include Sidekiq::Worker
  require 'capybara/poltergeist'

  def perform(appartment_id)
    # session = Capybara::Session.new(:poltergeist)
    # session.visit('https://www.airbnb.com/host/homes')
    # puts session.visit('https://www.airbnb.com/host/homes')
    # l = session.find('select[data-reactid="75"]').click
    # l.find(:xpath, 'option[2]').select_option
    # s = session.find('input[data-reactid="74"]').set(address)
    # s.send_keys :enter
    # earning = session.find('.earning-estimation__amount strong').text
    # city = session.find('.space-4 .text-babu span').text
    # puts earning
    # puts city
    appartment = Appartment.find_by_id(appartment_id)
    session = Capybara::Session.new(:poltergeist)
    session.visit('https://www.airbnb.com/host/homes')
    s = session.find('.earning-estimation__location-input input').set(appartment.address)
    s.send_keys :enter
    l = session.find('.earning-estimation__accommodation select').click
    l.find(:xpath, 'option[2]').select_option

    # earning = session.find('.earning-estimation__amount strong').text
    # city = session.find('.space-4 .text-babu span').text
    sleep 1
    puts '*-/*/-/*-/*/*-/*-/*/*-/-*/*-/*/*/*/-*/*-/-*/*-/*/*-/-*/*-/*-'
    puts session.find('.space-4 .text-babu span').text
    puts session.find('.earning-estimation__amount strong').text

    earning = session.find('.earning-estimation__amount strong').text
    converted_earning = '%.2f' % earning.split(',').join[1..-1]
    monthly_earning = converted_earning.to_f * 4
    profit = monthly_earning - appartment.rent
    appartment.update_attributes(earning: monthly_earning, profit: profit)
  end
end