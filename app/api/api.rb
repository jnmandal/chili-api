class API < Grape::API
  format :json
  get do
    {
      api: "PowerGives Chili API",
      version: "0.1",
      authors: ["@jnmandal", "@bentaylor2"],
      website: "http://pr-chili.herokuapp.com"
    }
  end
  
  resource :chilis do
    get do
      Chili.all
    end
    
    desc "Display chilis in Chicago"
    get '/chicago' do
      Chili.where(location: 'chicago')
    end
    
    desc "Display chilis in San Francisco"
    get '/sanfrancisco' do
      Chili.where(location: 'san francisco')
    end
    
    desc "Display info for a specific chili"
    get '/:chili_id' do
      Chili.find(params[:chili_id])
    end
    
    desc "Display ratings for a specific chili"
    get '/:chili_id/ratings' do
      Chili.find(params[:chili_id]).ratings
    end
  end
  
  resource :ratings do
    desc "Create a new chili rating"
    params do
      requires :chili_id, type: Integer, desc: "ID of chili being reviewed"
      requires :rating_value, type: Integer, desc: "star rating value"
      requires :author_email, type: String, desc: "email as validation of author's uniqueness"
      optional :tags, type: String, desc: "comma delineated string of chili tags"
      optional :comments, type: String, desc: "Any comments about the chili"
    end
    post do
      r = Rating.new(
        chili_id: params[:chili_id],
        rating_value: params[:rating_value],
        author_email: params[:author_email],
        tags: params[:tags],
        comments: params[:comments]
      )
      if r.save
        return r
      else
        status 400
        return {
          error: 'could not create rating',
          rating: r
        }
      end 
    end
    
    desc "Display all ratings"
    get do
      Rating.all
    end
  end
  
  resource :results do
    get do
      Chili.all.map do |chili|
        {
          id: chili.id,
          chef_name: chili.chef_name,
          average_score: chili.average_score,
          rating_count: chili.ratings.length
        }
      end
    end
    
    get '/averages' do
      Chili.all.map do |chili|
        {
          id: chili.id,
          chef_name: chili.chef_name,
          average_score: chili.average_score
        }
      end
    end
    
    get '/counts' do
      Chili.all.map do |chili|
        {
          id: chili.id,
          chef_name: chili.chef_name,
          rating_count: chili.ratings.length
        }
      end
    end
  end
end
