From: NBLIST@sbcglobal.net
To: linuxppc-embedded@lists.linuxppc.org
Message-Id: <AA-0E57C7D9B0DCDD436095A77F42959486-ZZ@www4.prodigy.net>
Date: Thu, 16 May 2002 10:52:11 -0500
Subject: network issues with fec on 860
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I have linux booting a ramdisk file system on an 860
processor. I am using the fec for ethernet. I send
these bootargs to the linux kernel.

root=/dev/ram ip=off

I start up the network using ifconfig and everything
works just fine. Now, if I bring the eth0 down using
ifconfig and try bringing it up again, everything
looks right. I see the eth0 interface up and running.
But, my network is not really working. I cant ping or
do anything else.

In summary, my ethernet connection works only the
first time. I cant take it down and bring it back up.

Any suggestions?

Thank you,
Navin.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
