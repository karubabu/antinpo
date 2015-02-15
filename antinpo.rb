Plugin.create(:antinpo) do
	DEFINED_TIME = Time.new.freeze
	exptmp = nil
    checktmp = nil
    firstSpaces = ""
    secondSpaces = ""
    on_appear do |ms|
      ms.each do |m|
         if m.message.to_me?()
            if !m.message.from_me?()
               exptmp = m.message.to_show()

                    # @screen_nameを弾く
                    exptmp = exptmp.gsub(/@[a-zA-Z0-9_]*/,'')
                    # 空の()を弾く
                    exptmp = exptmp.gsub(/[\(（][\)）]/,'')
                    exptmp = exptmp.gsub(/(https?|ftp):\/\/[\/A-Za-z0-9\.]*/,'')
                    checktmp=exptmp
                    checktmp = checktmp.gsub(/\p{blank}+?/,'')
                    # ﾌﾞﾁﾐﾘ系ではなく かつ ちんぽ系である
                    if checktmp !~ /チンポモ|ちんぽも|ﾌﾞﾘ|ﾘｭﾘｭﾘｭ|ﾌﾞﾂ|ﾁﾁ|ﾐﾘ|([うおあｕｏａ]){5,}?|[!！]{10,}/ and
                        checktmp =~ /[ㄘちんぽチンポﾁﾝﾎ]{3,}|[ｔｃｈｉｎｐｏtchinpo]{4,}/ and m[:created] > DEFINED_TIME and !m.retweet? then

                        if exptmp =~ /[ち|チ|ﾁ](\p{blank}*?)[ん|ン|ﾝ](\p{blank}*?)[ぽ|ポ|ﾎﾟ]/ then
                            firstSpaces = $1
                            secondSpaces = $2
                        end

                        exptmp = exptmp.gsub(/[ち|チ|ﾁ]/,
                        	"ㄘ" => "な" + firstSpaces,
                            "ち" => "な" + firstSpaces,
                            "チ" => "ナ" + firstSpaces,
                            "ﾁ" => "ﾅ" + firstSpaces)
                        exptmp = exptmp.gsub(/[ん|ン|ﾝ]/,
                            "ん" => "ん" + secondSpaces,
                            "ン" => "ン" + secondSpaces,
                            "ﾝ" => "ﾝ" + secondSpaces)
                        exptmp = exptmp.gsub(/[ぽ|ポ|ﾎﾟ]/,
                            "ぽ" => "で",
                            "ポ" => "デ",
                            'ﾎﾟ' => 'ﾃﾞ')

                        # 間の空白の対応をスマートに実装できるﾋﾄはなんとかしてあげてください
                            exptmp = exptmp.gsub(/t/, "n").gsub(/ｔ/, "ｎ")
                            .gsub(/c/, "n").gsub(/ｃ/, "ｎ")
                            .gsub(/h/, "").gsub(/ｈ/, "")
                            .gsub(/i/, "a").gsub(/ｉ/, "ａ")
                            .gsub(/p/, "d").gsub(/ｐ/, "ｄ")
                            .gsub(/o/, "e").gsub(/ｏ/, "ｅ")

                        exptmp = exptmp.gsub(/!|！/,
                            "!" => "?",
                            "！" => "？")

                        hatenaLength = 140 - ("@" + m.user.idname + ' ' + exptmp).size
                        if hatenaLength>20 then
                            hatenaLength=20
                        end
                        Service.primary.post(:message => "#{"@" + m.user.idname + ' ' + exptmp + "？"*rand(hatenaLength)}", :replyto => m)
                        m.message.favorite(true)
                    end
                end
            end
        end
    end
end