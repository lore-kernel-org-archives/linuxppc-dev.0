From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <mlan@cpu.lu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.2 USB and "mon>" (was Re: All 6 cards!!!)
Date: Wed, 7 Mar 2001 13:19:54 +0100
Message-Id: <20010307121954.29343@mailhost.mipsys.com>
In-Reply-To: <200103070649.HAA00777@piglet.grunz.lu>
References: <200103070649.HAA00777@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Oh yes, sure enough. However, I am unable to tell you _where_ exactly it
>breaks.
>
>I've been unable to boot _any_ 2.3/2.4 kernels on my machine since
>around 2.3.99 or a bit earlier. Some revisions would boot part of the
>time, but most of them not at all. Symtom is always the same: hang
>before initializing the framebuffer, i.e. still on the OF screen.
>
>I get the 'retunring 0x... from prom_init' string, but nothing after
>that.....

That's weird ? I suppose you tried removing/moving PCI cards ?

You can also try to hack printk so that it calls prom_prinf (or xmon_printf),
that may help figure out where it goes wrong.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
