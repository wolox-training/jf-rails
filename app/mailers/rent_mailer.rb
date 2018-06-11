class RentMailer < ApplicationMailer
  def success_rent_email(rent_id)
    @rent = Rent.find(rent_id)
    @user = @rent.user
    @book = @rent.book
    mail(to: @user.email, subject: 'Awesome book rented')
  end
end
