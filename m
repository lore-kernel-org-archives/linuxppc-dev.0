Date: Fri, 7 Sep 2001 04:18:28 -0700 (PDT)
From: James F Dougherty <jfd@GigabitNetworks.COM>
Message-Id: <200109071118.EAA14228@krakatoa.gigabitnetworks.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: swapspace in HHL 2.0
Cc: jfd@krakatoa.gigabitnetworks.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I used initdconfig to enable mountall.sh and have an /etc/fstab like
so:

# /etc/fstab: static file system information.
#
# <file system> <mount point>   <type>  <options>               <dump>  <pass>
/dev/root       /               auto    defaults,errors=remount-ro      0 0
/proc           /proc           proc    defaults                        0 0
/dev/hda1       /               auto    rw                              0 1
/dev/hda2       swap            swap    defaults                        0 2

When the system boots, it says that it is enabling the swapspace, however
if you cat /proc/meminfo, it shows that it is really not enabled.
Now, if you do a "swapon -a" instead of "swapon -a 2" (like in the mountall.sh)
then swap comes on.

What am I doing wrong?

MTIA				-James

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
