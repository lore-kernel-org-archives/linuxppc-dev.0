From: Cort Dougan <cort@fsmlabs.com>
Date: Wed, 16 Apr 2003 12:24:53 -0600
To: linuxppc-embedded@lists.linuxppc.org
Subject: [PATCH] Fix RPX and add flash-burner in linuxppc_2_4_devel
Message-ID: <20030416182453.GP20197@host109.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This patch fixes the RPX boot which was generating a bad boot image (it was
an ELF) and will do the 'cp' command line correctly, too.

This patch also adds a boot image that will burn itself (and an initrd if
present) to the flash on the RPX.

It's large so I put it here:

http://www2.fsmlabs.com/~cort/rpx.patch.gz

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
