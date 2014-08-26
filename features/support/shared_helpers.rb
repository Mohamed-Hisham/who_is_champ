require 'uri'

def path_for(page_name)
  case page_name
  when /^home$/i
    '/'
  # Competition Manager-related
  when /^registrations?$/i, /^sign up$/i
    '/creators/sign_up'
  when /^creator login$/i, /^sign in/i
    '/creators/sign_in'

  # Member-related
  when /^member login$/i
    '/users/sign_in'
  when /^member profile$/i
    "/users/#{@user.id}"
  else
    raise "Undefined path for #{page_name} page"
  end
end

def fixture_app_default_file(filename)
  Rails.root.join("#{default_path}/#{filename}")
end

def default_path
  'public/defaults/images/payload'
end

def upload_path
  'test/fixtures/uploads'
end

def fixture_file(filename)
  Rails.root.join("#{upload_path}/#{filename}")
end

def uploaded_file_from_path(path)
  Rails.root.join("public/#{path}")
end

def path_from_url(url)
  URI(url).path
end
