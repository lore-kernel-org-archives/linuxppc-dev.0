Message-Id: <200108301948.PAA12019@orchid.cspi.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Brian Waite <bwaite@cspi.com>
Reply-To: bwaite@cspi.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: 5100 again
Date: Thu, 30 Aug 2001 15:40:08 -0400
MIME-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Now that I have a functioning 5100 board with my initrd I am seeing some
really strange things. When I enable IPMC_PRESENT I start booting but when I
get to the point of loading my romfs the kernel starts moving extrremely
slowly. I have not debugged this yet but I just wanted to let others know
ahead of time. I am using the latest devel_2_4 tree and I am seeing this.
I'll let you know what I find.

Thanks
Brian


--
Brian Waite

Looking for a TeraFLOP in a closet
www.fastcluster.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
