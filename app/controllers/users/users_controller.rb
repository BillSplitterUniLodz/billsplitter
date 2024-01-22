module Users
    class UsersController < ApplicationController
        def show
            render json: current_user.to_json
        end

        def update
            current_user.update(user_params)

            render json: current_user.to_json
        end

        private

        def user_params
            params.require(:current_user).permit(:username, :email)
        end
    end
end
