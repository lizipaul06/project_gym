require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/customer')
also_reload( '../models/*' )

get '/customers' do
  @customers = Customer.all
  erb (:"customers/index")
end


get '/customers/new' do
 erb(:"customers/new")
end

get '/customers/:id/update' do

  @customer = Customer.find( params[:id] )

   erb(:"customers/update")
end

post  '/customers/:id/delete' do
 id = params[:id]
 @customer = Customer.find(id)
 @customer.delete()

redirect '/customers'
end

post '/customers/:id' do
  @customer = Customer.new(params)
   @customer.update()

  erb(:"customers/show")

end

get '/customers/:id' do
  @customer = Customer.find(params['id'].to_i)
  erb(:"customers/show")
end



post '/customers/' do
 @customer = Customer.new(params)
 @customer.save()
redirect '/customers'
end
