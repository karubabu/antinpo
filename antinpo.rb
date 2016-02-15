Plugin.create(:antinpo) do

DEFINED_TIME = Time.new.freeze
exptmp = nil
checktmp = nil

	def delaytweet(m,tweet,hatenaLength)
		m.message.favorite(true)
		Reserver.new((tweet.size)/2){
			Service.primary.post(:message => "#{"@" + m.user.idname + ' ' + tweet + "？"*rand(hatenaLength)}", :replyto => m)
		}
	end

	def tinpoConverter(exptmp)
		#ほんと誰かいい方法考えて
		exptmp.gsub! /ﾃｨ/, "ﾅｧ"
		exptmp.tr! "ちチﾁㄘぽポ", "ななナﾅでデ"
		exptmp.gsub! /ﾎﾟｩ/, "ﾃﾞｪ"
		exptmp.gsub! /ﾎﾟ/,"ﾃﾞ"
		# 間の空白の対応をスマートに実装できるﾋﾄはなんとかしてあげてください
		exptmp.tr! "ctinpoCTINPOｃｔｉｎｐｏ", "nnandeNNANDEｎｎａｎｄｅ"
		exptmp.gsub! /[hHｈ]/, ""

		exptmp.tr! "!！", "?？"
		return exptmp
	end

	on_appear do |ms|
		ms.each do |m|
			if m.message.to_me?()
				if !m.message.from_me?()
					exptmp = m.message.to_show()
					# @screen_nameを弾く
					exptmp = exptmp.gsub(/@[a-zA-Z0-9_]*\p{blank}?/,'')
					# 空の()を弾く
					exptmp = exptmp.gsub(/[\(（][\)）]/,'')
					exptmp = exptmp.gsub(/(https?|ftp):\/\/[\/A-Za-z0-9\.\p{blank}]*/,'')
					checktmp=exptmp
					checktmp = checktmp.gsub(/\p{blank}+?/,'')
					# ﾌﾞﾁﾐﾘ系ではなく かつ ちんぽ系である
					if checktmp !~ /チンポモ|ちんぽも|ﾌﾞﾘ|ﾘｭﾘｭﾘｭ|ﾌﾞﾂ|ﾁﾁ|ﾐﾘ|ﾌﾞ|([うおあｕｏａioOIAU]){5,}?|[!！]{10,}/ and
						checktmp =~ /[ㄘちんぽチンポﾁﾝﾎﾟ]{3,}|[TINMPOｔｃｉｎｍｐｏtcinmpo]{4,}|(チン|ちん|ﾁﾝ)([^でデﾃﾞ]+)/ and m[:created] > DEFINED_TIME and !m.retweet? and m.message.to_s !~ /[\(（]@karubabu[\)）]/ then

						exptmp=tinpoConverter(exptmp)
						delaytweet(m,exptmp,5)
					end
				end
			end
		end
	end
end
