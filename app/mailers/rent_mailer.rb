class RentMailer < ApplicationMailer
  def success_rent_email(user, rent, book)
    @user = user
    @rent = rent
    @book = book
    mail(to: user.email, subject: 'Awesome book rented')
  end
end
