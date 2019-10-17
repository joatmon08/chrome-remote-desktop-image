control 'check golang' do
  impact 1.0
  title 'confirm go installed'
  desc 'confirm go installed'
  describe file('/usr/local/go/bin') do
    it { should exist }
  end
  describe command('/usr/local/go/bin') do
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

control 'check docker' do
  impact 1.0
  title 'confirm docker installed'
  desc 'confirm docker installed'
  describe command('docker version') do
    its('stdout') { should include '19.03.3' }
  end
end

control 'check consul-k8s-dev' do
  impact 1.0
  title 'confirm consul-k8s-dev installed'
  desc 'confirm consul-k8s-dev installed'
  describe command('consul-k8s-dev -h') do
    its('stdout') { should include 'up' }
  end
end