class ContactProspectAgencesImmo
    
  attr_accessor :email_hunter

  DIRECTORY_AGENCES_IMMO = 'http://www.immobilieres-agences.fr/'

  def initialize
    @email_hunter = EmailHunter.new(:HUNTER_API_KEY)
  end

  def perform
    puts 'lets get those mails :)'

    result = @email_hunter.search('DIRECTORY_AGENCES_IMMO')

    CSV.open("app/services/list_of_mails_agences_immo.csv", "wb") do |csv|
      result.each do |mail|
        csv << mail
      end
    end

    binding.pry

  end

end