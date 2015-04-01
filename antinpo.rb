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
                    exptmp = exptmp.gsub(/@[a-zA-Z0-9_]*\p{blank}?/,'')
                    # 空の()を弾く
                    exptmp = exptmp.gsub(/[\(（][\)）]/,'')
                    exptmp = exptmp.gsub(/(https?|ftp):\/\/[\/A-Za-z0-9\.]*/,'')
                    checktmp=exptmp
                    checktmp = checktmp.gsub(/\p{blank}+?/,'')
                    # ﾌﾞﾁﾐﾘ系ではなく かつ ちんぽ系である
                    if checktmp !~ /チンポモ|ちんぽも|ﾌﾞﾘ|ﾘｭﾘｭﾘｭ|ﾌﾞﾂ|ﾁﾁ|ﾐﾘ|([うおあｕｏａ]){5,}?|[!！]{10,}/ and
                        checktmp =~ /[ㄘちんぽチンポﾁﾝﾎﾟ]{3,}|[ｔｃｉｎｐｏtcinpo]{4,}|(チン|ちん|ﾁﾝ)([^でデﾃﾞ]+)/ and m[:created] > DEFINED_TIME and !m.retweet? then

                        exptmp = exptmp.gsub(/ち|チ|ﾁ/,
                        	"ㄘ" => "な",
                            "ち" => "な",
                            "チ" => "ナ",
                            "ﾁ" => "ﾅ")
                        exptmp = exptmp.gsub(/ん|ン|ﾝ/,
                            "ん" => "ん",
                            "ン" => "ン",
                            "ﾝ" => "ﾝ")
                        exptmp = exptmp.gsub(/ぽ|ポ|ﾎﾟ/,
                            "ぽ" => "で",
                            "ポ" => "デ",
                            "ﾎﾟ" => "ﾃﾞ")

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
                        sleep(("@" + m.user.idname + ' ' + exptmp).size)
                        Service.primary.post(:message => "#{"@" + m.user.idname + ' ' + exptmp + "？"*rand(hatenaLength)}", :replyto => m)
                        m.message.favorite(true)
                    end
                end
            end
        end
    end
end