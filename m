Date: Fri, 6 Aug 1999 15:41:18 +1000
Message-Id: <199908060541.PAA20067@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: bob@kunk.jriver.com
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <19990806045342.6946.qmail@kunk.jriver.com> (bob@kunk.jriver.com)
Subject: Re: Odd ethnetnet problem
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <19990806045342.6946.qmail@kunk.jriver.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


bob@kunk.jriver.com wrote:

> When the iMac talked to either Unix box from linux-ppc (several kernels
> tested), I would get nearly 100 percent on receive but REALLY slow
> response on transmit (like about 40k/sec). Watching the lights on the hub,
> it appears that there is a really big delay restarting transmit after
> a collision occurs. Perhaps duplex set wrong?

I have seen this too but I haven't figured out what's going wrong yet.
My suspicion is that some packets are getting corrupted somehow on
transmission and then we are having to wait for a TCP retransmit.  A
tcpdump might yield some interesting information.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
