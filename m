Subject: linuxppc_2_4_devel: 2.4.20 rc2 - where's pImage build?
From: Tom Guilliams <tguilliams@sbs.com>
To: Linux PPC Embedded List <linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain
Message-Id: <1052969438.14900.8.camel@aurora.rr.com>
Mime-Version: 1.0
Date: 14 May 2003 20:30:38 -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Anyone know why the BOOT_TARGET define for "pImage" in arch/ppc/Makefile
was taken out?  Are we not going to support the build rule for
U-Boot/PPCBoot anymore other than building it manually (gzip vmlinux
then use "mkimage").

Thanks in advance,

Tom


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
