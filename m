Date: Thu, 29 Aug 2002 09:51:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pcmcia- config.opts, cis and pci
Message-ID: <20020828235113.GA7330@zax>
References: <6DF87017DA95D611AC6000606730DE9B0BD764@BLREXSR>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6DF87017DA95D611AC6000606730DE9B0BD764@BLREXSR>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Aug 28, 2002 at 03:30:14PM +0530, Sanjeev Manral wrote:
>
> Hi all,
>
> I'm using pcmcia-cs-3.2.0 my kernel is 2.4.17. It's a ppc405 board.
>
> pcmcia-cs is not able to detect ide_cs card and telling it a Blank card.
>
> I've tried many options in /etc/pcmcia/config.opts but nothing is working.
>
> I'm having one more doubt. there is no PCI brige in manual of my hardware.
> It is using coreconnect architecture and PCMCIA controller is directly
> connected to processor local bus. In hardware there is not a single mention
> of pci-plb bridge.
>
> If I disable "pci" in "make xconfig" "card bus support" is also disabling
> and there are no sockets.
> shall I enable "pci" and "card bus support"( I'm trying this, IS IT
> CORRECT?)

Probably not - are you using a 16-bit PCMCIA "PC Card" or a 32-bit
"CardBus" card.  Since you have no PCI, chances are your hardware will
only support the 16-bit cards.

> I debugged it with enable "pci" and "card bus support". driver is not able
> to get a valid cis. and trying to load a blank card driver( memory_cs )
> instead of ide_cs.
>
> Is it a problem with only config.opts or some other problem.
>
> I don't know where to proceed. if somebody knows how and where to get a
> valid config.opts please let me know.
>
> thanks,
> Sanjeev
>
>
>

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
