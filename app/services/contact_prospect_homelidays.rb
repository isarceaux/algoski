class ContactProspectHomelidays
  
  def initialize
    browser = Watir::Browser.new(:firefox)

    browser.goto 'https://www.abritel.fr/location-vacances/p1477842'
    sleep(10)
    puts "sleep finished should refresh now"
    browser.refresh
    class_button = 'btn cta js-emailOwnerButton btn-sm btn-link btn-inquiry-link'
    browser.link(class: class_button).click
    # binding.pry

    # Filling the form

    #Checking the box flexible date of stay
    checkbox_id = "modal-flexibleDateInput"
    browser.checkbox(id:checkbox_id).click

    #Adding one adult
    increment_button_class = "btn btn-default counter-button counter-button--gray js-increment"
    browser.button(class:increment_button_class).click

    #Filling information
    fill_first_name = browser.text_field(id: 'modal-inquirerFirstName')
    fill_first_name.send_keys('Isabelle')

    fill_last_name = browser.text_field(id: 'modal-inquirerLastName')
    fill_last_name.send_keys('Bonnet')

    fill_mail = browser.text_field(id: 'modal-inquirerEmailAddress')
    fill_mail.send_keys('isabellecorp@gmail.com')

    #Writting the mail
    text_id = "modal-comments"
    browser.textarea(id:text_id).send_keys(new_text)

    puts "Everything is ready for submitting the form... just check while the program sleeps"
    # sleep(5)
    binding.pry
    
    #Sending the form
    validation_button_class = 'btn btn-primary js-submitInquiry'
    browser.button(class: validation_button_class).click

  end

  def new_text
    new_text = ""
    new_text = "Bonjour,

Connaissez-vous le site Algoski : www.algo.ski ? 

Il permet aux propriétaires d'appartements au ski de louer plus de semaines et au meilleur prix en leur permettant de se comparer aux autres propriétaires dans leur station !

De nombreux propriétaires à la montagne en France et en Suisse ont amélioré leur taux de remplissage et leurs revenus grâce à cet outil simple mais efficace. En un coup d'oeil vous obtenez les prix moyens de location pour chaque semaine !

Si vous souhaitez en savoir plus n'hésitez pas à nous contacter par mail. Le mail est disponible sur la page contact de notre site.

Au plaisir de vous aider dans vos locations,

Isabelle
Pour Algoski "
    return new_text
  end

end

