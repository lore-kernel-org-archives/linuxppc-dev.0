To: "liuming" <lm_mailbox@sohu.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	"liuming" <lm_mailbox@163.com>
Subject: Re: Need help booting linux on my 8265 board 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 19 Apr 2004 00:33:02 +0800."
             <000f01c42562$d3713150$a81e1aac@liuming>
Date: Sun, 18 Apr 2004 23:11:50 +0200
Message-Id: <20040418211155.E6F44C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <000f01c42562$d3713150$a81e1aac@liuming> you wrote:
>
>   I have problem booting linux on my 8265 board. Both u-boot and ppcboot
> run well, but when I boot the linux kernel, the board be dead. At this
> time the registers look like to be some default values(use powertap
> pro). I try u-boot1.1, ppcboot1.1.5; linux kernel 2.4.4 2.4.18 2.4.20.

I have already answered your questions on the U-Boot users mailing list.

Why didn't you read my message?

> (1)about compile kernel
> vim Makefile,        arch=ppc CROSS_COMPILE=ppc_82xx-
> vim arch/ppc/platforms/ads826x.h,      IMAP_ADDR=0x04700000 BCSR=0x04500000

Your memory map is broken; this cannot work.


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I will also, for an appropriate fee, certify that  your  keyboard  is
object-oriented,  and  that  the bits on your hard disk are template-
compatible.            - Jeffrey S. Haemer in <411akr$3ga@cygnus.com>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
