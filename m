From: Benjamin Herrenschmidt <bh40@calva.net>
To: <mlan@cpu.lu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PCI fixups (was: re: xf 4.0.1 with rage II/rage...)
Date: Wed, 27 Sep 2000 12:33:06 +0200
Message-Id: <19340822040450.7355@mailhost.mipsys.com>
In-Reply-To: <200009270532.HAA00726@piglet.grunz.lu>
References: <200009270532.HAA00726@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>FWIW, I am reading the resource regions decoded by the hose from the OF
>device tree. The encoding is documented somewhere in the OF to PCI
>binding doc. I've also added a struct ranges_property in
>include/asm-ppc/prom.h.

I'm not very confident on the device tree content on those UniNorth
machines. I prefer reading the decoded regions from the address select
register of the bridge itself ;) (There's code in Darwin that shows how
it works).

Where can I find your patch that does this region hacking ?

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
