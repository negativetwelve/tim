class Command < ActiveRecord::Base
  # attr_accessible :title, :body
  
  def oneline(command, list, user)
    while command[0] == ":"
      command = command[1..command.size]
    end
    parsed = command.split()
    self.execute(parsed, list, user)
  end
        
  def execute(lst, list, user)
    command = lst[0]
    args = lst[1..lst.size]
    case command
    when 'n'
      self.add_new_item(args, list)  
    when 'nl'
      self.add_new_list(args, user)
    when "d"
      self.delete_item(args, list)
    when "dl"
      self.delete_list(args, user)
    else
      return "Invalid command"
    end
  end
    

  def add_new_item(lst, list)        
    the_name = nil
    the_priority = 5
    the_date = nil
    
    the_index = 1
    list.items.each do |item|
      if !item.isdone
        the_index += 1
      end
    end
    
    # first argument is an number; is a priority
    if lst[0].to_i > 0 
      the_priority = lst[0]
      lst = lst[1..lst.size]
    end
    
    # check for a deadline
    if lst[lst.size - 3] == "in" #the last three elements are a deadline
      time_field = lst[lst.size - 1]
      number = lst[lst.size - 2].to_i
      lst = lst[0..(lst.size - 4)]
      the_date = Time.now
      if time_field.include?("week")
        the_date += number * 7 * 24 * 3600
      elsif time_field.include?("day")
        the_date += number * 24 * 3600
      elsif time_field.include?("hour")
        the_date += number * 3600
      elsif time_field.include?("minute")
        the_date += number * 60
      else
        the_date += number    
      end
    end
    the_name = lst.join(" ")
    i = Item.create(name: the_name, index: the_index, priority: the_priority, deadline: the_date, isdone: false)
    i.list = list
    i.save
  end

  def add_new_list(args, user)
    name = args.join(" ")
    lst = List.create(name: name, index: user.lists.count + 1)
    lst.user = user
    lst.save    
  end
  
  def delete_item(args, list)
    if args.size == 1 && args[0].to_i > 0
      index = args[0].to_i
      item = Item.where(index: index, isdone: false).first
      item.isdone = true
      item.save
      count = 1
      list.items.each do |item|
        if !item.isdone
          item.index = count
          count += 1
          item.save
        end
      end
    else
      "Incorrect number of deleting an item #{args}"
    end
  end 
  
  def delete_list(args, user)
    if args.size == 1
      lst = user.lists.where(index: args[0].to_i).first
      lst.destroy
    else
      return "Incorrect arguments for deleting a list #{args}"
    end
  end
end
