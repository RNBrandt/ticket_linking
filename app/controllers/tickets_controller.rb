class TicketsController < ApiController
  ## # GET :index /api/v1/tickets.json
  ##
  ## Example Request:
  ##
  ## $ curl http://localhost:3000/api/v1/tickets.json
  ## [{  "id": 1,
  ##     "account_id": 1,
  ##     "user_id": 1,
  ##     "subject": "I'm having a problem!",
  ##     "problem_id": null,
  ##     "body": "Lorem ipsum dolor sit amet, consectetur adipisicing elit",
  ##     "created_at": "2015-12-04T23:40:42.805Z",
  ##     "updated_at": "2015-12-04T23:40:42.805Z",
  ##     "user": {
  ##       "id": 1,
  ##       "account_id": 1,
  ##       "name": "Dean Martin",
  ##       "created_at": "2015-12-04T23:40:42.780Z",
  ##       "updated_at": "2015-12-04T23:40:42.780Z"
  ##     }
  ##   }, {
  ##     "id": 2,
  ##     "account_id": 1,
  ##     "user_id": 3,
  ##     "subject": "I'm also having a problem!",
  ##     "problem_id": 1,
  ##     "body": "Lorem ipsum dolor sit amet, consectetur adipisicing elit",
  ##     "created_at": "2015-12-04T23:40:42.808Z",
  ##     "updated_at": "2015-12-04T23:40:42.808Z",
  ##     "user": {
  ##       "id": 3,
  ##       "account_id": 1,
  ##       "name": "Aubry Plaza",
  ##       "created_at": "2015-12-04T23:40:42.785Z",
  ##       "updated_at": "2015-12-04T23:40:42.785Z"
  ##     }
  ##   }]
  def index
    render json: ticket_presenter.present(tickets)
  end

  ## # POST :create /api/v1/tickets.json
  ##
  ## Example Request:
  ##
  ## $ curl -X POST -D "ticket[subject]=foo" http://localhost:3000/api/v1/tickets.json
  ## {
  ##   "id": 1,
  ##   "account_id": 1,
  ##   "user_id": null,
  ##   "subject": "foo",
  ##   "problem_id": null,
  ##   "body": null,
  ##   "created_at": "2015-12-04T23:40:42.805Z",
  ##   "updated_at": "2015-12-04T23:40:42.805Z",
  ##   "user": null
  ## }
  def create
    ticket = current_account.tickets.create(ticket_params)
    render json: ticket
  end

  ## # GET :show /api/v1/tickets/:id.json
  ##
  ## Example Request:
  ##
  ## $ curl http://localhost:3000/api/v1/tickets/1.json
  ## {
  ##   "id": 1,
  ##   "account_id": 1,
  ##   "user_id": 1,
  ##   "subject": "I'm having a problem!",
  ##   "problem_id": null,
  ##   "body": "Lorem ipsum dolor sit amet, consectetur adipisicing elit",
  ##   "created_at": "2015-12-04T23:40:42.805Z",
  ##   "updated_at": "2015-12-04T23:40:42.805Z",
  ##   "user": {
  ##     "id": 1,
  ##     "account_id": 1,
  ##     "name": "Dean Martin",
  ##     "created_at": "2015-12-04T23:40:42.780Z",
  ##     "updated_at": "2015-12-04T23:40:42.780Z"
  ##   }
  ## }
  def show
    render json: ticket_presenter.present(ticket)
  end

  ## # PUT :update /api/v1/tickets/:id.json
  ##
  ## Example Request:
  ##
  ## $ curl -X PUT -D "ticket[subject]=foo" http://localhost:3000/api/v1/tickets.json
  ## {
  ##   "id": 1,
  ##   "account_id": 1,
  ##   "user_id": 1,
  ##   "subject": "foo",
  ##   "problem_id": null,
  ##   "body": "Lorem ipsum dolor sit amet, consectetur adipisicing elit",
  ##   "created_at": "2015-12-04T23:40:42.805Z",
  ##   "updated_at": "2015-12-04T23:40:42.805Z",
  ##   "user": {
  ##     "id": 1,
  ##     "account_id": 1,
  ##     "name": "Dean Martin",
  ##     "created_at": "2015-12-04T23:40:42.780Z",
  ##     "updated_at": "2015-12-04T23:40:42.780Z"
  ##   }
  ## }
  def update
    ticket.update_attributes(ticket_params)
    render json: ticket
  end

  ## # DELETE :destroy /api/v1/tickets/:id.json
  ##
  ## Example Request:
  ##
  ## $ curl -X DELETE http://localhost:3000/api/v1/tickets/2.json
  def destroy
    ticket.destroy!
    render status: :ok, nothing: true
  end

  ## # GET :incidents /api/v1/tickets/:id/incidents.json
  ##
  ## Example Request:
  ##
  ## $ curl http://localhost:3000/api/v1/tickets/1/incidents.json
  ## [{  "id": 2,
  ##     "account_id": 1,
  ##     "user_id": 1,
  ##     "subject": "I'm having a problem!",
  ##     "problem_id": 1,
  ##     "body": "Lorem ipsum dolor sit amet, consectetur adipisicing elit",
  ##     "created_at": "2015-12-04T23:40:42.805Z",
  ##     "updated_at": "2015-12-04T23:40:42.805Z",
  ##     "user": {
  ##       "id": 1,
  ##       "account_id": 1,
  ##       "name": "Dean Martin",
  ##       "created_at": "2015-12-04T23:40:42.780Z",
  ##       "updated_at": "2015-12-04T23:40:42.780Z"
  ##     }
  ##   }, {
  ##     "id": 3,
  ##     "account_id": 1,
  ##     "user_id": 3,
  ##     "subject": "I'm also having a problem!",
  ##     "problem_id": 1,
  ##     "body": "Lorem ipsum dolor sit amet, consectetur adipisicing elit",
  ##     "created_at": "2015-12-04T23:40:42.808Z",
  ##     "updated_at": "2015-12-04T23:40:42.808Z",
  ##     "user": {
  ##       "id": 3,
  ##       "account_id": 1,
  ##       "name": "Aubry Plaza",
  ##       "created_at": "2015-12-04T23:40:42.785Z",
  ##       "updated_at": "2015-12-04T23:40:42.785Z"
  ##     }
  ##   }]
  def incidents
    render json: ticket_presenter.present(ticket_incidents)
  end

  private

  def ticket
    @ticket ||= current_account.tickets.find(params[:ticket_id] || params[:id])
  end

  def tickets
    @tickets ||= current_account.tickets
  end

  def ticket_incidents
    @incidents ||= ticket.incidents
  end

  def ticket_params
    params.require(:ticket).permit(:account_id, :user_id, :subject)
  end
end
