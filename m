From: bob@kunk.jriver.com
Message-ID: <20000604040407.10637.qmail@kunk.jriver.com>
Subject: Frustration with MACE...
To: linuxppc-dev@lists.linuxppc.org
Date: Sat, 3 Jun 2000 23:04:07 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've spent several hours tonite trying to get the MACE driver to behave
properly on a 7200/90 with the 2.2.15pre20 kernel.

The internal ethernet is connected via the 10BT port. It works sometimes for
a while and then just stops working. I have tried it through a switch and
with a cisco 675.

I looked over the plscc configs, noticed the little force AAUI config.
Tried different plscc combos, tried different phycc (PHY) combos, it's
still flakey! I've tried it on 3 7200's. It works pretty well on only one.

If the machine is in MacOS I can pump megabytes through the Mesh without
trouble.

If I use a PCI ethernet card, it works perfectly. I'm running out of ideas
(and if don't get this working, I'll be out of PCI slots).

When it doesn't work, I don't even get errors in netstat -in.

Any IDEAS????

Bob
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
