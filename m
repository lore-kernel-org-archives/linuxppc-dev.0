Message-ID: <20001213045523.1673.qmail@kunk.jriver.com>
Subject: Mace woes solved, NOT!
To: linuxppc-dev@lists.linuxppc.org
Date: Tue, 12 Dec 2000 22:55:23 -0600 (CST)
From: Robert E Brose II <bob@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Unfortunatly the mace has taken a turn for the worse again. Turning off
syncookies made it work longer but it still gets screwed up after a
while (this has nothing to do with the HW, the machine is on 24/7 and
the dropping only seems to depend on the number of packets handled by
the driver and the problem is quite reproducable with other hubs,
macs, etc and of course, it always works in macos).

I flood pinged the 7500 from a slower machine (486 linux portable) and
after 800,000 packets or so it started dropping. I stopped the flood
and went to a simple 1/sec ping and started loosing around 40%. I
am just guessing but there may be something wrong with collisions or
missing an interrupt or something.

Foo, I though it was working. I'm back to the pci tulip now which
always works. Hopefully I'll get some time to try other possibilities
on the mace driver....

Bob
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
