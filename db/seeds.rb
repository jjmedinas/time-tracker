# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
  admin = User.create!(
    first_name: "Juan",
    last_name: "Admin",
    email: "juan@admin.com",
    gender: "m",
    role: "admin",
    password: 'admin',
    password_confirmation: 'admin'
  )

  employee = User.create!(
    first_name: "Juan",
    last_name: "Employee",
    email: "juan@employee.com",
    gender: "m",
    role: "employee",
    password: 'employee',
    password_confirmation: 'employee'
  )

  employee_2 = User.create!(
    first_name: "Maria",
    last_name: "Employee",
    email: "maria@employee.com",
    gender: "f",
    role: "employee",
    password: 'employee',
    password_confirmation: 'employee'
  )

  12.times { |i|
    check_in = (20.days.from_now.beginning_of_day + 8.hours) - i.days
    check_out = check_in + (8.hours - i.minutes)

    ActivityLog.create!(
      user_id: employee.id, 
      active: false, 
      checked_in_at: check_in, 
      checked_out_at: check_out
    )

    ActivityLog.create!( 
      user_id: employee_2.id, 
      active: false, 
      checked_in_at: check_in, 
      checked_out_at: check_out
    )
  }

