From: bob@kunk.jriver.com
Message-ID: <19990806045342.6946.qmail@kunk.jriver.com>
Subject: Odd ethnetnet problem
To: linuxppc-dev@lists.linuxppc.org
Date: Thu, 5 Aug 1999 23:53:42 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have an iMac with the usual builtin  bmac ethernet controller. It is on a 
10 mb hup with a couple of other boxes (one professional svr4 and one linux
2.2.10 on intel)

The hub is a generic dumb 10mb half duplex only unit. The problem is this,

When the iMac talked to either Unix box from MACOS, I would get
nearly 100% of the bandwidth of the ethernet on put's and get's.

When the iMac talked to either Unix box from linux-ppc (several kernels
tested), I would get nearly 100 percent on receive but REALLY slow
response on transmit (like about 40k/sec). Watching the lights on the hub,
it appears that there is a really big delay restarting transmit after
a collision occurs. Perhaps duplex set wrong?

Since it works fine in MACOS, I looked over the linux driver and didn't see
anything obviously wrong. Has anyone else run into this before? 

Bob
-- 
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
