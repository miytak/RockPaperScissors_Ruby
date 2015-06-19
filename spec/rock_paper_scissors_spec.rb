require_relative '../lib/rock_paper_scissors'
describe RockPaperScissors do
  let(:player) {Player.new('John')}
  let(:players) {%w(John Jane Matz).map{|name| Player.new(name)}}

  describe '#entry' do
    it 'プレイヤーを1人参加させるとプレイヤー人数が1人になる' do
      expect(subject.entry(player).size).to eq 1
    end
    it 'プレイヤーを2人参加させるとプレイヤー人数が2人になる' do
      expect(2.times{subject.entry(player).size}).to eq 2
    end
  end

  describe '#shoot!' do

  end

  describe '#results' do
    before do
      players.each{|player| subject.entry player}
      subject.shoot!
    end

    it 'じゃんけんの結果が返る' do
      expect(subject.results).to have(3).items
    end
  end
end

describe Player do
  let(:player) {Player.new('John')}
  specify { expect(player.name).to eq 'John'}

  describe '#shoot!' do
    it 'ランダムに出し手が決まる' do
      hands1 = []
      hands2 = []
      10.times { player.shoot!; hands1 << player.hand}
      10.times { player.shoot!; hands2 << player.hand}
      expect(hands1).not_to eq hands2
    end

    it '勝ち手と負け手の組み合わせが正しく設定される' do
      hands = []
      10.times { hands << player.shoot!}
      expect(hands.all?{|hand| hand == %w(Rock Scissors) || hand == %w(Paper Rock) || hand == %w(Scissors Paper)}).to eq true
    end
  end

  describe '#settle' do
    before do
      player.shoot!
    end

    shared_examples 'あいこでしょ' do
      it { expect(player.settle! draw_hands).to eq 'Draw' }
    end
    context '全員の手が1種類の場合' do
      let(:draw_hands) { %w(Rock Rock Rock) }
      it_behaves_like 'あいこでしょ'
    end
    context '全員の手が3種類の場合' do
      let(:draw_hands) { %w(Rock Paper Scissors) }
      it_behaves_like 'あいこでしょ'
    end

    context '全員の手が2種類の場合' do
      results = []
      it '100回じゃんけんしたら勝ったり負けたりする' do
        100.times do
          player.shoot!
          player.settle! %w(Rock Paper Paper)
          results << player.result
        end
        expect(results.include?('Win') && results.include?('Lose') && !results.include?('Draw')).to be_truthy
      end
    end
  end

end
