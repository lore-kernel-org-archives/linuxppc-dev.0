Message-ID: <36EFCF5D.8892052A@nc.com>
Date: Wed, 17 Mar 1999 08:50:53 -0700
From: Rick Meier <rmeier@nc.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: L2CR for upgrade cards.
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Has anyone actually seen the a G3 upgrade card working with the backside
cache under LinuxPPC?  I have tried a NewerTECH G3/300 w/512k and a
PowerLogix 400/200.  I was never able to get the cache working.  I am
using BootX 1.0.2 and kernel 2.2.4 (checked out from vger).  I never see
the "override" statement in my dmesg and when I look at
/proc/sys/kernel/l2cr is shows the cache disabled.

Any Ideas?


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
