require 'csv'

class Obituary < ActiveRecord::Base
  default_scope :conditions => { :dirty => false }
  
  def self.dirty
    with_exclusive_scope { where(:dirty => true) }
  end
  
  def self.import
    data = CSV.read("#{Rails.root}/obits.csv")
    data.shift
    data.each do |row|
      obit = new
      obit.last_name   = row[0].try(:strip)
      obit.middle_name = row[1].try(:strip)
      obit.first_name  = row[2].try(:strip)
      obit.other_name  = row[3].try(:strip)
      obit.born_on     = row[5]
      obit.died_on     = row[7]
      obit.printed_on  = row[17]
      obit.page        = row[18].try(:strip)
      obit.notes       = sanitize_notes(birth_note:row[6],death_note:row[8],
        infant:row[9],location:sanitize_location(row[11],row[12],row[13]),
        maiden_name:row[4])
      obit.dirty       = true if obit.last_name.blank? ||
        obit.printed_on.blank? || obit.page.blank?

      obit.save!
    end
  end
  
  private
    def self.sanitize_location(city=nil,state=nil,country=nil)
      loc = ''.tap do |s|
        location = [city,state]
        location << country unless country.to_s.gsub(/\W/,'').match(/us/i)
        location = location.compact.join(', ')
        s << location unless location.blank?
      end

      loc.blank? ? nil : loc
    end
  
    def self.sanitize_notes(fields={})
      notes = [].tap do |a|
        fields.reject {|key,value| value.blank? }.each do |key,val|
          a << case key
          when :birth_note
            "born in #{val.strip}" unless val.match(/u[kn|nk]/i)
          when :death_note
            "died in #{val.strip}" unless val.match(/u[kn|nk]/i)
          when :infant
            "infant" if val == 1
          when :location
            val
          when :maiden_name
            "maiden name: #{val.strip}"
          end
        end
      end
      
      notes = notes.compact.join("\n")
      notes.blank? ? nil : notes
    end
end
