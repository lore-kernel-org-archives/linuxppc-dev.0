Message-ID: <003801c1bad1$0e3a0860$3c438209@endicott.ibm.com>
From: "Michael Washburn" <mwashbur@stny.rr.com>
To: "??????" <goodyjc@hanmail.net>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <20020221143325.HM.B0000000003B0PX@www12.hanmail.net>
Subject: Re: Question about the dcache of ppcboot??
Date: Thu, 21 Feb 2002 07:12:38 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="EUC-KR"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Has each dcache line been invalidated before attempting to enable? I've had
similar problems on ppc4xx processors where either didn't invalidate the
entries, or went to a SOC with different dcache size and ran into problems
like this.

Mike
----- Original Message -----
From: "윤재철" <goodyjc@hanmail.net>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Thursday, February 21, 2002 12:33 AM
Subject: Question about the dcache of ppcboot??



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

============================================================================
==
우리 인터넷, Daum http://www.daum.net
- Daum회원을 위한 인터넷쇼핑 + 파워 공동구매 ☞
http://hmm.daum.net/shop_0202
- 100% 맞춤 광고! Daum검색 키워드샵 ☞ http://hmm.daum.net/keyword_top_0202


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
