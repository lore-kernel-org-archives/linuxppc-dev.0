From: bob@kunk.jriver.com
Message-ID: <19990808175727.19320.qmail@kunk.jriver.com>
Subject: Re: Odd iMac ethernet problem
In-Reply-To: <199908060541.PAA20067@tango.anu.edu.au> from Paul Mackerras at
 "Aug 6, 1999 03:41:18 pm"
To: Paul.Mackerras@cs.anu.edu.au
Date: Sun, 8 Aug 1999 12:57:27 -0500 (CDT)
CC: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


User Paul Mackerras says:
> bob@kunk.jriver.com wrote:
> 
> > When the iMac talked to either Unix box from linux-ppc (several kernels
> > tested), I would get nearly 100 percent on receive but REALLY slow
> > response on transmit (like about 40k/sec). Watching the lights on the hub,
> > it appears that there is a really big delay restarting transmit after
> > a collision occurs. Perhaps duplex set wrong?
> 
> I have seen this too but I haven't figured out what's going wrong yet.
> My suspicion is that some packets are getting corrupted somehow on
> transmission and then we are having to wait for a TCP retransmit.  A
> tcpdump might yield some interesting information.

I haven't got tcpdump setup on another linux box yet but I did borrow a 
10/100 NWay switch from work and tested the 4 speed/duplex combinations.

The iMac transmits properly only on 100mb/half duplex (860 k/sec, it's
talking to a redhat i386 linux box on 10mb on another switch port).
All the rest of the combinations are 60k/sec or less on transmit.

Hopefully I'll have time to do a packet trace this evening.

Bob
-- 
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
