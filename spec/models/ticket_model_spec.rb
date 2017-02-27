require 'rails_helper'

describe Ticket, type: :model do
  describe '#related' do
    let(:tick) { Ticket.create() }
    let(:tock) { Ticket.create() }
    let(:clock) { Ticket.create() }
    let(:tickets) { Ticket.all }

    context 'when a ticket has no relations' do

      it 'will return itself as its only relation' do
        expect(tick.related tickets).to contain_exactly(tick)
        expect(tock.related tickets).to contain_exactly(tock)
        expect(clock.related tickets).to contain_exactly(clock)
      end
    end

    context 'when a ticket is related to another ticket' do
      before do
        tick.update(incidents: [tock])
        tock.update(problem: tick)
      end

      it 'will return an array of only the two related tickets' do
        expect(tick.related tickets).to contain_exactly(tick, tock)
        expect(tock.related tickets).to contain_exactly(tick,tock)
      end
    end

    context 'when tickets are related linearly' do
      before do
        tick.update(incidents: [tock])
        tock.update(problem: tick, incidents: [clock])
        clock.update(problem: tock)
      end

      it 'each will return arrays with all related tickets' do
        expect(tick.related tickets).to contain_exactly(tick, tock, clock)
        expect(tock.related tickets).to contain_exactly(tick, tock, clock)
        expect(clock.related tickets).to contain_exactly(tick, tock, clock)
      end
    end

    context 'when tickets have branching (sibling) relationships' do
      before do
        tick.update(incidents: [tock, clock])
        tock.update(problem: tick)
        clock.update(problem: tick)
      end

      it 'will return arrays with all related tickets' do
        expect(tick.related tickets).to contain_exactly(tick, tock, clock)
        expect(tock.related tickets).to contain_exactly(tick, tock, clock)
        expect(clock.related tickets).to contain_exactly(tick, tock, clock)
      end
    end

    context 'when tickets are connected through the #other_relateds method' do
       let!(:mouse) { Ticket.create(other_relateds: [tick]) }

      before do
        tick.update(incidents: [tock])
        tock.update(problem: tick)
        clock.update(problem: tick)
      end

      it 'will return arrays with all related tickets' do
        expect(tick.related tickets).to contain_exactly(tick, tock, clock, mouse)
        expect(tock.related tickets).to contain_exactly(tick, tock, clock, mouse)
        expect(clock.related tickets).to contain_exactly(tick, tock, clock, mouse)
        expect(mouse.related tickets).to contain_exactly(tick, tock, clock, mouse)
      end
    end
  end
end
