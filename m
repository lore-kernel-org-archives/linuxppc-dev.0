Return-Path: <mvw@nurfuerspam.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id A72E667C7B
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Nov 2006 00:30:43 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Mon, 06 Nov 2006 14:30:41 +0100
From: mvw@nurfuerspam.de
Message-ID: <20061106133041.94740@gmx.net>
MIME-Version: 1.0
Subject: Kernel 2.6.18 and JFFS2 Filesystem problem
To: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

i dont know what my mistake.
What files do i need for a filesystem?
Is it correct to build the filesystem with these parameters?
--> mkfs.jffs2 -r dir -o jffs2 -e 0x40000 -p

-------------------------------------------------------------------------
Probing MTD map driver for board flash at physical address 0x0(16-bit bank)
MTD map driver for board: Found 1 x16 devices at 0x0 in 16-bit bank
 Intel/Sharp Extended Query Table at 0x0031
Using buffer write method
cfi_cmdset_0001: Erase suspend on write enabled
Using default (built-in) partition definition
Creating 4 MTD partitions on "MTD map driver for board":
0x00000000-0x00020000 : "uboot"
0x00020000-0x00040000 : "environment"
0x00040000-0x00140000 : "kernel"
0x00140000-0x00f40000 : "jffs2"
mice: PS/2 mouse device common for all mice
VFS: Mounted root (jffs2 filesystem).
Freeing init memory: 60K
(nothing is displayed)
--------------------------------------------------------------------------

Thank you for your help.

armin
-- 
GMX DSL-Flatrate 0,- Euro* - Überall, wo DSL verfügbar ist!
NEU: Jetzt bis zu 16.000 kBit/s! http://www.gmx.net/de/go/dsl
