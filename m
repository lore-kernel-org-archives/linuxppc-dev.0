Date: Fri, 12 Feb 1999 21:45:17 -0700 (MST)
From: Matt Porter <mmporter@home.com>
To: Cort Dougan <cort@persephone.cs.nmt.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: platform specs (was: PReP spec)
In-Reply-To: <Pine.LNX.3.96.990212175439.19379A-100000@persephone.cs.nmt.edu>
Message-ID: <Pine.LNX.3.96.990212213821.3668A-100000@liberty.chnd1.az.home.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 12 Feb 1999, Cort Dougan wrote:

Yes, but from my point of view it is the most important feature. Sticking
with prep memmaps is fine for the current average configuration of a
single or dual cpu setup with a few PCI slaves.  When people start putting
together systems with 8-20 CPU's peering over the CPCI bus then PReP
simply won't work because of all the windows that will need to be opened
to map the other processors' board resources in local space.  It's good to
keep in mind for the future...

> That's not chrp, though.  That's just a chrp memmap.  The kernel doesn't
> yet deal with a chrp memmap and no-OF.  I'd rather stick with prep memmaps
> with those boards - it's simple.
> 
> }And from the looks of things, all new Motorola boards/systems.  Already,
> }VxWorks BSPs for Moto. boards are easily configured to a CHRP mem map.
> }Only the firmware defaults to PReP and it is getting dated with its poor
> }PCI mapping.
> 

--
Matt Porter
mmporter@home.com
Unix is a Linux-like operating system.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
