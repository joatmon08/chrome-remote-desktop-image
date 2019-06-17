control 'check golang' do
  impact 1.0
  title 'confirm go installed'
  desc 'confirm go installed'
  describe command('go version') do
    its('stdout') { should include '1.12' }
  end
end

control 'check terraform' do
  impact 1.0
  title 'confirm terraform installed'
  desc 'confirm terraform installed'
  describe command('terraform version') do
    its('stdout') { should include '0.12' }
  end
end

control 'check git' do
  impact 1.0
  title 'confirm git installed'
  desc 'confirm git installed'
  describe command('git version') do
    its('stdout') { should include '2.11' }
  end
end