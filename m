Message-ID: <3A87A3F6.6A9CA4C7@mpifr-bonn.mpg.de>
Date: Mon, 12 Feb 2001 09:51:02 +0100
From: Albrecht Dre_ <ad@mpifr-bonn.mpg.de>
MIME-Version: 1.0
To: "Michael K. Fleming" <mikef@praxis.etla.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: PCMCIA on a Pismo with pcmcia-cs-3.1.24
References: <Pine.LNX.4.21.0102101758020.20783-100000@praxis.etla.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Michael K. Fleming" wrote:
> I'm trying to get PCMCIA working on my Mac Powerbook Pismo, with kernel
> 2.2.18pre4-ben1 and pcmcia-cs-3.1.24 (no patches applied--as far as I can
> tell, none should be necessary...).  I'm primarily trying to get a

This should be your problem... If you have a Pismo, you can not boot with BootX,
and in this case you have to patch your kernel. Did not check 2.2.18 yet (yeah,
my web page is outdated...), but I guess it is still necessary...

Hope this helps, Albrecht.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

[snip]
>     PCI irq 58 test failed

This leads to a complete failure of the pcmcia package...

> include memory 0x90000000-0x9003ffff
> include port 0x1000-0x1fff

Looks fine.

>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=32

These entries look suspicious, and they do not work for sure with our pismos.

--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
