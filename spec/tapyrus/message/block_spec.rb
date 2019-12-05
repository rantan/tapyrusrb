require 'spec_helper'

describe Tapyrus::Message::Block do

  describe 'parse from payload' do
    # 000000000000a7c25a2032d97800c509e4d6ccd633212c5956a52c58d8cef11d block data
    subject { Tapyrus::Message::Block.parse_from_payload('00000020f29ae31fe472fea5a9812cd8bd9d73c7e4491ee62fbaf9b1be20000000000000e4e24580186a17432dee5ada29678f3f5e6b51a451f3b8d09917a2de11dba12d11bd48590bd6001bcd3c87cb0101000000010000000000000000000000000000000000000000000000000000000000000000ffffffff2a038c7f110411bd48592f244d696e65642062792037706f6f6c2e636f6d2f0100000bd807000000000000ffffffff0340597307000000001976a91489893957178347e87e2bb3850e6f6937de7372b288ac50d6dc01000000001976a914ca560088c0fb5e6f028faa11085e643e343a8f5c88ac0000000000000000266a24aa21a9ede2f61c3f71d1defd3fa999dfa36953755c690689799962b48bebd836974e8cf900000000'.htb) }
    it 'should be parsed' do
      expect(subject.header.block_hash).to eq('1df1ced8582ca556592c2133d6ccd6e409c50078d932205ac2a7000000000000')
      expect(subject.transactions.length).to eq(1)
      expect(subject.transactions.first.txid).to eq('71d91ef4e7aff57d5f1383f681d36d9bcdfde43b2b6bab44a2221cf33a43e202')
    end
  end

  describe 'to_pkt' do

    context 'not use segwit' do
      subject {
        h = Tapyrus::BlockHeader.parse_from_payload('020000005e9ed64c83c56eb6a3a7303e8c094d8331634108c05f5f13fd65e81800000000bf94c2950b4fd1afe8029c6c5bdd22f1ae9791037c9223a3851a84a5c7a82d028b4849518aca1e1cd05c7d32'.htb)
        b = Tapyrus::Message::Block.new(h)
        tx = Tapyrus::Tx.parse_from_payload('01000000010000000000000000000000000000000000000000000000000000000000000000ffffffff1303beec00065149488b2435ac0312b700000007ffffffff0100f2052a010000001976a914b2979cf5eb2cfdc8cebc082c39a65a7b602093d288ac00000000'.htb)
        b.transactions << tx
        b.to_pkt
      }
      it 'should be generate' do
        expect(subject.bth).to eq('0b110907626c6f636b00000000000000b9000000b9cd299d020000005e9ed64c83c56eb6a3a7303e8c094d8331634108c05f5f13fd65e81800000000bf94c2950b4fd1afe8029c6c5bdd22f1ae9791037c9223a3851a84a5c7a82d028b4849518aca1e1cd05c7d320101000000010000000000000000000000000000000000000000000000000000000000000000ffffffff1303beec00065149488b2435ac0312b700000007ffffffff0100f2052a010000001976a914b2979cf5eb2cfdc8cebc082c39a65a7b602093d288ac00000000')
      end
    end

  end

end