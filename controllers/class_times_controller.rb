require( 'sinatra' )
require( 'sinatra/contrib/all' )
require('pry')
require_relative( '../models/class_booking')
require_relative( '../models/gym.rb')
require_relative( '../models/instructor')
require_relative( '../models/class_time')
require_relative( '../models/customer')
also_reload( '../models/*' )

get '/class_times/:id/update' do

  @class_time = Class_time.find( params[:id] )
  @gym_classes = Gym_class.all
  erb(:"class_times/update")
end
  get '/class_times/:id/book/' do
    @class_time = Class_time.find( params[:id] )
      @gym_classes = Gym_class.all
      @customers = Customer.all

   erb(:"class_times/book")
  end

post '/class_times/:id/book' do

  @class_time = Class_time.find( params[:id] )

  @class_time.booking(params)

 redirect '/class_times'
 end


post '/class_times/:id' do

  @class_time = Class_time.new(params)
   @class_time.update()

redirect '/class_times'

end



post  '/class_times/:id/delete' do
@class_time = Class_time.find(params['id'].to_i)
 @class_time.delete()

redirect '/class_times'
end






post "/class_times/:id/booking/delete" do

  @booking = Booking.find( params[:id] )
  @class_time = @booking.class_time

  @class_time.increase_capacity
  @booking.delete



  redirect '/class_times'
end





post '/class_times' do
  @class_time = Class_time.new(params)
   @class_time.save()

redirect '/class_times'
end

get '/class_times/new' do
  @class_times = Class_time.all
    @gym_classes = Gym_class.all
 erb(:"class_times/new")
end

get '/class_times' do
  @class_times = Class_time.all
  erb (:"class_times/index")
end




  get '/class_times/:id' do
      @class_time = Class_time.find(params['id'].to_i)
      @bookings = @class_time.classbooking
      erb (:"class_times/show")
  end
