class TweetsController < ApplicationController
  get "/tweets" do
    redirect_if_not_logged_in
    @tweets = Tweet.all
    erb :'/tweets/index'
  end


  get '/tweets/new' do
    redirect_if_not_logged_in
    erb :'/tweets/new'
  end

  post '/tweets' do
    if params[:content] != ""
      tweet = Tweet.create(content: params[:content])
      current_user.tweets << tweet
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    redirect_if_not_logged_in
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show'
  end

  get '/tweets/:id/edit' do
    redirect_if_not_logged_in
    @tweet = Tweet.find(params[:id])
    if current_user.tweets.include?(@tweet)
      erb :'/tweets/edit'
    else
      redirect '/tweets'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if params[:content] != ""
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    end
    redirect "/tweets/#{@tweet.id}/edit"
  end

  delete '/tweets/:id' do
    redirect_if_not_logged_in
    @tweet = Tweet.find(params[:id])
    if current_user.tweets.include?(@tweet)
      @tweet.destroy
    else
      redirect '/tweets'
    end
  end 
end	