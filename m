From: jonathan.hurley@ni.com
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Booting HHL on Motorola Sandpoint X3 (with MPC 8245)
Message-ID: <OFF9D2B304.538379E0-ON86256A86.006B0650@natinst.com>
Date: Wed, 11 Jul 2001 14:29:45 -0500
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I recently downloaded the journeyman HHL distribution to install on a
Motorola Sandpoint X3 system with an 8245 PPC processor (Unity X4 MPPMC).
I followed the install instructions, and realized (when the system didn't
boot) that the init code for the sandpoint was written for the Sanpoint X2
with an 8240 PPC.  I believe there have been some minor changes in the
main board design between the X2 and X3, and possibly some changes to the
MPPMC.  Does HHL currently support the Sandpoint X3 system, and if not are
there any future plans to add support for the new platform?

Thanks, in advance, for any assistance you can give me.

Jonathan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
