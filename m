Message-ID: <3839D8FD.2D6EE79D@jlc.net>
Date: Mon, 22 Nov 1999 18:59:57 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Cort Dougan <cort@ppc.kernel.org>
CC: Neil Blackwood <nb@terrafix.co.uk>, sorin@nitechinc.com,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: IDE on MBX board
References: <99111909331400.01435@splash.nitechinc.com> <000a01bf34db$79773180$6401a8c0@everyone> <383975BE.A9B2A487@jlc.net> <19991122115254.A29168@chimaera.ppc.kernel.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Cort Dougan wrote:


> .........  One of the big problems was tracking down
> the interrupt routing for IDE on the MBX.  If you check to see if you're
> getting any interrupts at all on the 8259 that may give you a good place to
> start.
> 
> I don't have an IDE drive for my MBX anymore but would like to have it
> working again.  Let me know if you want to work together on it.

I have a couple of projects over the next month or so (if the hardware
arrives :-) that include some kind of IDE disk interface.  They are not
PCI/ISA devices, rather unique hardware interfaces to the bus. I
also have the 8240/Sandpoint to finish, which currently has a similar
interrupt routing problem you mention above (integrated interrupt
controller with external 8259).  I also want the pcmcia-cs running
on the 8xx, which means we have to make IDE work there (and I think it
is still broken on the PowerBooks :-).

It appears there are enough of us to get it working, so let's just
keep in touch and post the progress.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
