From: "=?EUC-KR?B?wLHA58O2?=" <goodyjc@hanmail.net>
Reply-To: "=?EUC-KR?B?wLHA58O2?=" <goodyjc@hanmail.net>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Question about the dcache of ppcboot??
Date: Thu, 21 Feb 2002 14:33:25 +0900 (KST)
Message-Id: <20020221143325.HM.B0000000003B0PX@www12.hanmail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello.
Greetings from korea.
My name is jaechol, and I'm a newbie.
Please excuse my English.

I ported ppcboot-1.1.4 to my custom board with mpc862 cpu.
Everything is OK, except of dcache.
Icache works fine. but dcache don't work
Atfer issuing dcache on,  my custom board hangs.
Is there a need that I do for dcache on??

my board:
                cpu mpc862
                2MByte Boot-flash on CS0
                SDRAM on CS2

==============================================================================
우리 인터넷, Daum http://www.daum.net
- Daum회원을 위한 인터넷쇼핑 + 파워 공동구매 ☞ http://hmm.daum.net/shop_0202
- 100% 맞춤 광고! Daum검색 키워드샵 ☞ http://hmm.daum.net/keyword_top_0202

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
