class RentMailer < ApplicationMailer
  def success_rent_email(user_id, rent_id)
    @user = User.find(user_id)
    @rent = Rent.find(rent_id)
    @book = @rent.book
    mail(to: @user.email, subject: 'Awesome book rented')
  end
end
