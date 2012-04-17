# Extract keywords from a string.
module KeywordExtractor
  def self.extract(str)
    return [] unless str.present?
    str.downcase.gsub(/[\/\\-]/, ' ').split(' ')
  end
end