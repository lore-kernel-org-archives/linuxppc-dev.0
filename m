From: frank.pierce@hedb.uib.no
Message-ID: <XFMail.990301121846.frank.pierce@hedb.uib.no>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <199902282049.VAA06261@piglet.cpu.lu>
Date: Mon, 01 Mar 1999 12:18:46 -0500 (EST)
Reply-To: frank.pierce@hedb.uib.no
To: linuxppc-dev@lists.linuxppc.org
Subject: PowerCenterPro + L2 cache
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi. I'm having some problems with the PowerCenterPro210 and L2 cache. When I do
a cat < /proc/cpuinfo
the L2 cache does not show up even tough it has 1MB on it.

If any1 out there is running linuxppc on this machine could you check if the
cache shows up in your /proc/cpuinfo ?

I need to know if I have a hardware problem. The problem is the same if I run
R4 or R5.

I'm booting via bootx but I don't think that's the problem.

Compared with the 3400c the PowerCenter is really unstable. The power book has
not crashed ones and can compile a kernel without 1 segmentation fault. The
powercenter gives me at least 10 before it crashes completely.

----------------------------------
E-Mail: frank@cmc.uib.no
Phone(Private):55234679
Phone(Work):55589279
Mob.: 93289455
Date: 01-Mar-99
Time: 12:03:09

This message was sent by XFMail
----------------------------------

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
