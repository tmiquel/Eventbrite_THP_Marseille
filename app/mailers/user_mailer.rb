# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'my-eventbrite@yopmail.com '

  def welcome_email(user)
    # on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
    @user = user

    # on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url  = 'https://my-eventbrite.herokuapp.com/'

    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @user.email, subject: 'Bienvenue chez nous !')
  end

  def new_attendee_notif_to_admin_email(admin, attendee, event)
    # on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
    @admin = admin

    @attendee = attendee

    # on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url = 'https://my-eventbrite.herokuapp.com/'

    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @admin.email, subject: "#{@attendee.first_name} participe à votre événement #{event.title}")
  end
end
