From: Juergen Beisert <jbeisert@eurodsn.de>
Reply-To: jbeisert@eurodsn.de
To: "Shih-Ying Chou" <sschou@mtu.edu>
Subject: Re: Question about IBM405 and IRQ
Date: Wed, 1 Oct 2003 08:47:41 +0200
References: <005201c387d0$dafdcf80$6401a8c0@sazabimobile>
In-Reply-To: <005201c387d0$dafdcf80$6401a8c0@sazabimobile>
Cc: <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="big5"
Message-Id: <200310010847.41202.jbeisert@eurodsn.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Am Mittwoch, 1. Oktober 2003 06:02 schrieb Shih-Ying Chou:
> The following is the /proc/pci
>
> PCI devices found:
>   Bus  0, device  10, function  0:
>     USB Controller: NEC Corporation USB (rev 65).
>        IRQ 25
<snip>
>     USB Controller: NEC Corporation USB 2.0 (rev 2).
>       IRQ 25
>       Master Capable.  Latency=128.  Min Gnt=16.Max Lat=34.
>       Non-prefetchable 32 bit memory at 0xbfffdf00 [0xbfffdfff].

Are you shure logical IRQ25 is connected to your PC104plus slot? Have a look
into CPU registers UIC0_PR and UIC0_TR: Is IRQ25 configured for negative
level triggering (like the PCI bus need)? Register CPC0_CR0: Is the physical
IRQ0 (logical IRQ25) enabled?

Hope it helps
-- JB

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
