Message-ID: <6B546A602AD2D211BFF00008C7A4288905843FEB@hrtades2.atea.be>
From: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>
To: "'??? '" <goodyjc@hanmail.net>,
	"'linuxppc-embedded@lists.linuxppc.org '" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Question about the dcache of ppcboot??
Date: Thu, 21 Feb 2002 08:31:14 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="euc-kr"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I think I have seen discussions on the ppcboot-users mailing list
mentioning that it is normal that ppcboot crashes when you switch dcache on
(icache should work)

Fred

-----Original Message-----
From: ???
To: linuxppc-embedded@lists.linuxppc.org
Sent: 2/21/02 6:33 AM
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

========================================================================
======
?? ???, Daum http://www.daum.net
- Daum??? ?? ????? + ?? ???? ? http://hmm.daum.net/shop_0202
- 100% ?? ??! Daum?? ???? ? http://hmm.daum.net/keyword_top_0202


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
