Message-ID: <39C62590.83E1FE95@agelectronics.co.uk>
Date: Mon, 18 Sep 2000 15:24:16 +0100
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: mlan@cpu.lu
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: sysctl support for ICTC
References: <200009122127.XAA00922@piglet.grunz.lu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners wrote:

> Ah, temp registers. That's good, since IIRC there were a few atempts
> long ago in this place to add temperature monitoring, but none ever
> ended up with something useful. Finally, that 0 in the cpuinfo could be
> replaced with something meaningful ;-)

Motorola have recently revealed that you cannot enable both thermal and
decrementer interrupts simultaneously. In typical Motorola fashion, they
have published this hidden inside the manual for the 755, with a note
that it also applies to the 750.

I've posted patches for the temperature measurement a few times - all
you have to do is to use the correct bit numberings, rather than the
wrong ones that linger in the kernel headers like a bad cheese.

- Adrian Cox, AG Electronics

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
