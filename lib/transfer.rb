require_relative "bank_account.rb" 

require 'pry'

class Transfer

  attr_accessor :sender, :receiver, :amount, :status

  @@all = []

  def initialize(sender, receiver, amount)
    @sender = sender 
    @receiver = receiver
    @amount = amount
    @status = "pending" 
  end

  def valid?
    if sender.valid? && receiver.valid?
      return true
    else 
      false 
    end 
  end

  def execute_transaction
    if sender.balance < @amount or receiver.valid? == false or sender.valid? == false 
      @status = "rejected"
      return "Transaction rejected. Please check your account balance."
    elsif sender.balance > @amount && self.status == "pending"
      sender.balance -=@amount
      receiver.balance +=@amount
      self.status = "complete"
      @@all << self
    end 
  end 

  def reverse_transfer
    last_trans = @@all.last
    if last_trans.status != "complete"
      sender.balance = sender.balance
      receiver.balance = receiver.balance
    elsif last_trans.status == "complete"
      last_trans.status = "reversed"
      sender.balance= (last_trans.sender.balance) + last_trans.amount
      receiver.balance= (last_trans.receiver.balance) - last_trans.amount
    end
  end 

end
