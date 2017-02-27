class TicketsController < ApiController
  def index
    render json: ticket_presenter.present(tickets)
  end

  def create
    ticket = current_account.tickets.create(ticket_params)
    render json: ticket
  end

  def show
    render json: ticket_presenter.present(ticket)
  end

  def update
    ticket.update_attributes(ticket_params)
    render json: ticket
  end

  def destroy
    ticket.destroy!
    render status: :ok, nothing: true
  end

  def incidents
    render json: ticket_presenter.present(ticket_incidents)
  end

  def related
    render json: ticket_presenter.present(all_related tickets)
  end

  private

  def all_related(tickets)
    @all_related ||= ticket.related(tickets)
  end

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
