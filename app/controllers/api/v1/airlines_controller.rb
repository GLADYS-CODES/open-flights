module Api
    module V1
        class AirlineController < ApplicationController
            protect_from_forgery with: :null_session

            def index
                airlines = Airline.all

                render json: AirlineSerializer.new(airlines, options).serialized_json
            end

            def show
                airline = Airline.find_by(slug: params[:slug])

                render json: AirlineSerializer.new(airline, options).serialized_json
            end

# The create action is similar to the show action, except we need to create a new airline.
            def create
                airline = Airline.new(airline_params)

                if airline.save
                    render json: AirlineSerializer.new(airline).serialized_json
                else
                    render json: { error: airline.errors.messages }, status: 422
                end

            end

# The update action is similar to the create action, except we need to find the airline first.
            def update
                airline = Airline.find_by(slug: params[:slug])

                if airline.update(airline_params)
                    render json: AirlineSerializer.new(airline, options).serialized_json
                else
                    render json: { error: airline.errors.messages }, status: 422
                end

            end

# The destroy action is a little different from the others.
            def destroy
                airline = Airline.find_by(slug: params[:slug])

                if airline.destroy
                    head :no_content
                else
                    render json: { error: airline.errors.messages }, status: 422
                end

            end


            private

            def airline_params
                params.require(:airline).permit(:name, :image_url)
            end

            def options
                @options ||= { include: %i[reviews] }
            end
        end
end

end