Date: Mon, 27 Mar 2000 21:59:45 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Michel Lanners <mlan@cpu.lu>
cc: toa@pop.agri.ch, linuxppc-dev@lists.linuxppc.org
Subject: Re: pci-resources feedback
In-Reply-To: <200003271909.VAA01187@piglet.grunz.lu>
Message-ID: <Pine.LNX.4.10.10003272157250.2447-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
> Here the resource code notices the conflict on the ATI.
>
> > PCI: Resource 81803000-81803fff (f=200, d=0, p=0)
> > PCI: Resource 81802000-81802fff (f=200, d=0, p=0)
> >   for root[0:ffffffff] min[80000000] size[1000]
> >   got res[80000000:80000fff] for resource 2
>
> This is the message as the conflicting (second) region of the ATI gets
> remapped. It did work... as can be seen ba the lspci outtput.

And it even used the right function (the one in drivers/pci/ to do it. Now
what kernel version was that with?

Seems the wallstreet was another one of the 'broken mapping for atyfb'
boxes. XFree86 4.0 should work fine now.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
