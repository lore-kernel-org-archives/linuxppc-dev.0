Message-Id: <200004242009.QAA23947@ginger.cmf.nrl.navy.mil>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org, drow@false.org
Subject: Re: aty128 and offb and linux-2.3.99pre6 
In-reply-to: Your message of "Mon, 24 Apr 2000 20:10:03 +0200."
             <Pine.LNX.4.10.10004242008100.316-100000@cassiopeia.home>
Date: Mon, 24 Apr 2000 16:09:33 -0400
From: Chas Williams <chas@cmf.nrl.navy.mil>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <Pine.LNX.4.10.10004242008100.316-100000@cassiopeia.home>,Geert Uytt
erhoeven writes:
>Huh? This has nothing to do with the order of 2 RAGE PROs. Atyfb is probed for
>before offb (like it should be) since a long time, and the order is always the
>same.

with a 2.2 kernel, the console appears on the agp card.
with a 2.3 kernel, the console appears on the pci card. [yes, it tooks
me a while i figure this out since the other card was not connected to
a monitor]


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
