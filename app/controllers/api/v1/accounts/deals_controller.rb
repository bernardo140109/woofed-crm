class Api::V1::Accounts::DealsController < Api::V1::InternalController

  def show
    @deal = @current_user.account.deals.find(params["id"])

    if @deal
      render json: @deal, include: [:contacts], status: :ok
    else
      render json: { errors: 'Not found' }, status: :not_found
    end
  end

  def create
    @deal = @current_user.account.deals.new(deal_params)

    if @deal.save
      render json: @deal, status: :created
    else
      render json: { errors: @deal.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @deal = @current_user.account.deals.find(params["id"])

    if @deal.update(deal_params)
      render json: @deal, status: :ok
    else
      render json: { errors: @deal.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def deal_params
    params.permit(:name, :status, :stage_id, contacts_attributes: [ :id, :full_name, :phone, :email ], custom_attributes: {} )
  end
end
