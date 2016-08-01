# Config for Non-production Environments
unless Rails.env.production?
  Paperclip::Attachment.default_options[:validate_media_type] = false

  Paperclip::Attachment.default_options.merge!({
   # :url => ":rails_root/public/system/:class/:attachment/:id_partition/:style/:filename" #Default url scheme as per Github
   # :url => "/media/milo/Irreplaceable/notes_app.rails/paperclips/:class/:attachment/:id_partition/:style/:filename",
   # :url => "/milo/:class/:attachment/:id_partition/:style/:filename",
   ## The current 'real' path
   #  :url => "/milo/:class/:attachment/:id_partition/:style/:basename.:hash.:extension",
   ## Set to default to allow for testing on other machines

   # :path => ":rails_root/public:url"
   # :path => "/media/milo/Irreplaceable/notes_app.rails/paperclips/:class/:attachment/:id_partition/:style/:filename"
   ## The current 'real' path
   # :path => "/media/milo/Irreplaceable/notes_app.rails/paperclips/:class/:attachment/:id_partition/:style/:basename.:hash.:extension"
   ## Set to default to allow for testing on other machines

  })

  Paperclip::Attachment.default_options.update({
#    :url => "/milo/:class/:attachment/:id_partition/:style/:basename.:hash.:extension", ## Duplicate of url above. Can this be removed?
#    hash_secret: Rails.application.secrets.secret_key_base
    hash_secret: "secretkittens" # Hopefully this lets us verify the hash externally by using the same "secret"
  })

  Paperclip.options[:content_type_mappings] = {
    json: ["/\Atext\/.*\Z/", "application/json"]
  }
end
