Date: Wed, 9 Dec 1998 23:17:12 -0700 (MST)
From: Matt Porter <mmporter@home.com>
To: Cort Dougan <cort@persephone.cs.nmt.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: changes to the kernel
In-Reply-To: <Pine.LNX.3.96.981209202241.18834A-100000@persephone.cs.nmt.edu>
Message-ID: <Pine.LNX.3.96.981209230721.17139A-100000@liberty.chnd1.az.home.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 9 Dec 1998, Cort Dougan wrote:

> Can someone tell me about this mcp750 thing?  Ian Hewitt at the Motorola
> booth mentioned something about them at the Atlanta conference but I
> haven't seen one or info on them.  Anyone feeling generous with info or
> pointers?

It a Compact PCI SBC w/ a MPC750 MPU and all the usual I/O and interfaces
you would come to expect from a Motorola board.  It's very similar to an
MVME2700 except it has a DEC Drawbridge for PCI->CPCI backplane bus 
whereas the MVME boards have a Universe II for PCI->VME backplane bus.

Press releases and manuals should be on he public mot.com site somewhere.

--
Matt Porter
mmporter@home.com
Unix is a Linux-like operating system.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
