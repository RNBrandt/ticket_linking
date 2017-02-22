class AccountsController < ApiController
  ## # GET :show /api/v1/accounts/:id.json
  ##
  ## Example Request:
  ##
  ## $ curl http://localhost:3000/api/v1/accounts/default.json
  ## {
  ##   id:1,
  ##   name:"Takehome",
  ##   slug:"default",
  ##   created_at:"2015-12-04T23:40:42.757Z",
  ##   updated_at:"2015-12-04T23:40:42.757Z"
  ## }
  def show
    render json: account_presenter.present(account)
  end

  private

  def account
    @account ||= Account.find_by_slug!(params[:id])
  end
end
