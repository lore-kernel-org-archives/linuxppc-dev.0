Date: Wed, 17 Mar 1999 15:40:20 -0500 (EST)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Apple Open Source: the drivers
In-Reply-To: <19990317162518.010351@mail.mipsys.com>
Message-ID: <Pine.LNX.3.96L.990317153729.4041A-100000@unix48.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 17 Mar 1999, Benjamin Herrenschmidt wrote:
> 
> Ok, I finally found where the driver are hidden: In the kernel archive,
> in bsd/dev/ppc. They are mostly objective C drivers. Among other things,
> there are drivers for the PowerMac ATA with apparently all the timing
> stuffs, and for the CMD646 controller in the blue G3.

So they're useful? Last night I suddenly got worried because OS X is based on
Mach... so wouldn't any OS X drivers be more helpful to the MkLinux folks than
to monolithic Linux?

And another question: how is it that OS X, based on Mach, is still comparable
in speed to other non-microkernel operating systems? It was my (uneducated)
impression that one of the tradeoffs of a microkernel was a performance
penalty.

-Hollis


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
