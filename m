Message-ID: <20020524215707.26073.qmail@web11507.mail.yahoo.com>
Date: Fri, 24 May 2002 14:57:07 -0700 (PDT)
From: Khai Trinh <kqtrinh@yahoo.com>
Subject: in_ntoa built error
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I downloaded the linuxppc2.4 devel tree from bitmover
and tried to build the the ebony kernel for my ebony
board. I got the built error in that in_ntoa is
referenced in the fs/nfs/nfsroot.c file but no include
lib for it.

What is this call anyway? It sounds like the root file
system is broken.

I then went and disable the NFS stuff in the defconfig
file. The kernel is then built. When I loaded the
kernel to Ebony, it failed on mounting the root
filesystem as expected.

Does anybody have a fix for this problem yet?

Regards,

--Khai


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
