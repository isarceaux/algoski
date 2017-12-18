class ContactProspectHomelidays
  
  attr_accessor :browser, :first

  def initialize
    @browser = Watir::Browser.new(:firefox)
    @first = true
    @raised_error = false

    list_of_urls = []
    CSV.foreach("app/services/housing_url_list.csv") do |row|
        list_of_urls << row[0] #Be careful first line just says links
    end
    count = 793
    list_of_urls[793..900].each do |link|
        puts "contacting prospect n°#{count}"
        if @raised_error
            @browser = Watir::Browser.new(:firefox)
            puts "Raised an error, relaunch the browser"
            @first = true
            @raised_error = false
        end
        perform(link)
        count += 1
    end

    # perform(list_of_urls[1])

  end

  def perform(url_client)

    @browser.goto 'https://www.abritel.fr'+url_client

    class1 = %w(contact-owner hidden-xs)
    class2 = %w(btn btn-default)
    begin
        @browser.element(class:class1).button(class:class2).click

    # Filling the form

    if @first
        #Checking the box flexible date of stay
        checkbox_id = "modal-flexibleDateInput"
        @browser.checkbox(id:checkbox_id).click

        #Adding one adult
        increment_button_class = %w(btn btn-default counter-button counter-button--gray js-increment)
        @browser.button(class:increment_button_class).click

        #Filling information
        fill_first_name = @browser.text_field(id: 'modal-inquirerFirstName')
        fill_first_name.send_keys('Isabelle')

        fill_last_name = @browser.text_field(id: 'modal-inquirerLastName')
        fill_last_name.send_keys('Bonnet')

        fill_mail = @browser.text_field(id: 'modal-inquirerEmailAddress')
        fill_mail.send_keys('contact@algo.ski')

        #Writting the mail
        text_id = "modal-comments"
        @browser.textarea(id:text_id).send_keys(new_text)

        @first = false
    end


    #Sending the form (commented for tests)
    validation_button_class = %(btn btn-primary js-submitInquiry)
    browser.button(class:validation_button_class).click
    sleep(5)
    
    rescue Exception => e
        puts "#{e}"
        @raised_error = true
        sleep(5)
        @browser.close
    end

  end

  def new_text
    new_text = ""
    new_text = "Bonjour,

J'ai créé une start-up, Algoski, pour aider les propriétaires au ski à mieux louer leur appartement.

L'idée m'est venu de ma mère, elle même propriétaire dans les Alpes, qui me posaient des questions du type : je n'arrive pas à louer, suis-je trop chère ? Comment savoir si je suis au bon prix? 

Grâce à mes connaissances en informatique j'ai développé un outil pour récupérer sur Abritel et Homelidays les prix à la semaine de tous les appartements au ski. Et j'ai décidé de le mettre à disposition du public avec le site Algoski moyennant un tarif de 49€ pour les particuliers et 249€ pour les pros.

Si vous pensez qu'un tel service peut vous être utile n'hésitez pas à visiter mon site. Par ailleurs sachez que nous sommes une toute petite structure et nous sommes donc accessibles, vous pouvez nous contacter directement par mail, avec le mail que vous trouverez sur la page contact du site Algoski.

Au plaisir de vous aider dans vos locations,

Isabelle
Pour Algoski "
    return new_text
  end

end

