From: "Elan Feingold" <elan@nxnetworks.com>
To: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Subject: strace crashes kernel
Date: Fri, 3 Aug 2001 12:37:27 -0500
Message-ID: <NDBBLJKOJGKDOFBHNPGEAEGACEAA.elan@nxnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


EST 8260 board, Kernel version 2.4.5 + PPC patches, strace from Hardhat
Linux 1.2 release.

1. We found that with the 2.4.5 kernel + patches, some important
configuration numbers (BRG, CPM clocks) were mismatches, in that
embed_config put them in Hz and other parts of the Linux kernel wanted them
in Mhz.  Once we fixed these issues, the kernel actually booted!!

2. Once booted and NFS mounting a root partition, we ran strace on ls, which
worked.  We then ran strace on inetd, which spewed out a few lines and then
hung the kernel hard.  No oops on console, just hung.

Any ideas on the hang?  Could it be an strace/linux mismatch or something?

Best regards,

-elan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
