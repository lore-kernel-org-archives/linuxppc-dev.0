From: bob@kunk.jriver.com
Message-ID: <20000413035855.19218.qmail@kunk.jriver.com>
Subject: MACE ethernet problem
To: linuxppc-dev@lists.linuxppc.org
Date: Wed, 12 Apr 2000 22:58:55 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Installed the latest stable kernel (2.2.15pre17) from Paul's rsync on a
powermac 7200/90.

If I do pings on the local network, 2/3 to 9/10's of the packets are lost.
Looking at the switch it's connected to, I see the blips for the
transmitted packets and also for the return packets but the 7200 doesn't
seem to see most of the return packets.

I believe this is not a hardware problem, the machine works great in MacOS.
Also, if I put a mitron E3200p (ne2k pci card) in the machine and use it
instead it works great. I feel fairly certain that this points to a driver
problem.

Other info:

The same OS and Kernel on a 7200/75 works fine (though it's connected to a
hub and not a switch).
The lights on the switch look OK, 10mb half duplex....

I was thinking of trying to tweak parameters in the driver source
but wondered if anyone had other ideas. Looking at the driver it
is written by Paul M.

Do you have any suggestions Paul??

Thanks,
Bob
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
