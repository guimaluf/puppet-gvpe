Facter.add('gvpe_pubkey') do
  setcode do
    `openssl rsa -in /etc/gvpe/hostkey -RSAPublicKey_out 2>/dev/null` if File.exist? '/etc/gvpe/hostkey'
  end
end
