class Ticket < ActiveRecord::Base
  belongs_to :account
  belongs_to :user
  belongs_to :problem, class_name: 'Ticket'
  has_many :incidents, class_name: 'Ticket', foreign_key: :problem_id

  def incident?
    problem_id.present?
  end

  def related(tickets)
    related_ticket_array(tickets).map { |id| Ticket.find(id) }
  end

  def related_ticket_array(tickets)
    tree = searchable_hash(tickets)
    search_value = self.id
    return [search_value] if tree[search_value] == []
    stack = []
    results = []
    travelled = {}
    stack.push tree[search_value][0]
    travelled[search_value] = true
    results.push search_value
    while stack.length > 0
      current = stack.pop
      current_id = current['id']
      if !travelled[current_id]
        tree[current_id].each { |t_hash| stack.push t_hash }
        results.push current_id
        travelled[current_id] = true
      end
    end
    results
  end

  def searchable_hash(tickets)
    hash_array = relation_hash(tickets)
    searchable_hash = {}
    hash_array.each do |t_hash|
      ticket_id = t_hash["id"]
      related_hash = t_hash["incidents"]
      related_hash << t_hash["problem"] if t_hash['problem']
      searchable_hash[ticket_id] = related_hash.uniq
    end
    searchable_hash
  end

  def relation_hash(tickets)
    tickets.all.as_json(only: :id, include: {
      incidents: {
        only: :id
      },
      problem: {
        only: :id
      }
    })
  end

  def all_related_tickets
    unique_related.map { |id| Ticket.find(id) }
  end

 def unique_related
  id_array = Ticket.pluck(:id)
  accounted = {}
  unique_related = []
  id_array.each do |id|
    if !accounted[id]
      related = self.related_ticket_array(id)
      related.each { |id| accounted[id] = true }
      unique_related << related
    end
  end
  unique_related
 end
end
