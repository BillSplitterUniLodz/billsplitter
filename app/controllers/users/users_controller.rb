module Users
    class UsersController < ApplicationController
        # before_action :authenticate_user!, only: [:show, :update]

        def show
            render json: Users::Presenter.new(current_user).serialize.to_json
        end



        def update
            
        end

        def group_params
            params.require(:user).permit(:name)
        end
    end
end
