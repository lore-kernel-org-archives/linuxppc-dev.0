From: bob@kunk.jriver.com
Message-ID: <20000803131142.5183.qmail@kunk.jriver.com>
Subject: Re: Ethernet problem on 7200
To: brucea@spacestar.net (Bruce Anderson)
Date: Thu, 3 Aug 2000 08:11:42 -0500 (CDT)
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <B5AE9BDF-3472C5@192.168.2.21> from "Bruce Anderson" at Aug 03, 2000 03:47:38 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


User Bruce Anderson says:
> On Wed, Aug 2, 2000 11:03 PM, bob@kunk.jriver.com
> <mailto:bob@kunk.jriver.com> wrote:
> >
> >The driver problem I'm having with the MACE is NOT the one described
> >below or in the apple article. I have the problem on 2 different
> >motherboards, on a 75 and one a 90. BOTH have the "missing" clock
> >hardware. I've also see it on another. The packet size doesn't matter,
> >sometimes it dies on pings (64 bytes). It works PERFECTLY in MacOs.
> >
> >Bob
> >
>
> The missing clock hardware also affects PCI bus timing and devices
> on the PCI bus. Apple has a INIT that tries to fix the problem.
>
> 2.2.13 kernel works for me.
> Next time you have a problem
> Write down the bogomips and see if it changes over boots.
> Next time you have a problem you might see a change.
> That might be a clue that the kernel is geting the
> software delay timing wrong.

I'm sorry that my comment wasn't very clear, both of my 7200's HAVE the
clock hardware (according to the til). A 20 mhz can right next to the
ethernet chip and the 50 pin scsi connector.

So... the problems still appear to be in the drivers.. When I get some
time I'm going to move from a switch to a hub and put tcpdump on another
machine to see what's up when the mace stops working. In previous testing
it appeared that the 7200 was ignoring the INCOMING packets. We'll see...

Bob
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
