# frozen_string_literal: true

class AttendanceMailer < ApplicationMailer
  default from: 'my-eventbrite@yopmail.com '

  def new_attendee_notif_to_admin_email(admin, attendee, event)
    # on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
    @admin = admin
    @event = event

    @attendee = attendee

    # on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url = 'https://my-eventbrite.herokuapp.com/'

    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @admin.email, subject: "#{@attendee.first_name} participe à votre événement #{event.title}")
  end
end
