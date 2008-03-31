Return-Path: <g.schardt@fz-juelich.de>
Received: from zam837.fz-juelich.de (zam837.fz-juelich.de [134.94.100.69])
	by ozlabs.org (Postfix) with ESMTP id 966EDDDF03
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Apr 2008 00:43:57 +1000 (EST)
Received: from [134.94.232.103] (zel201.zel.kfa-juelich.de
	[134.94.232.103])by zam837.fz-juelich.de (Postfix) with ESMTP id
	090A310006ACfor <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Mar 2008 16:33:44 +0200 (CEST)
Message-ID: <47F0F646.30002@fz-juelich.de>
Date: Mon, 31 Mar 2008 16:33:42 +0200
From: Georg Schardt <g.schardt@fz-juelich.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: JFFS2 root-fs
References: <16306218.post@talk.nabble.com>
In-Reply-To: <16306218.post@talk.nabble.com>
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,


i ask this questions a few months ago but i still have no solution for 
my problem :(

i try to boot linux with a root-fs from flash. i create a jffs2-image, 
download it to flash and
the u-boot "ls" shows me all my files, so i think all is right with the 
image.


BUT, the kernel hangs after mounting the rootfs:

[    0.572527] physmap platform flash device: 00400000 at 04000000
[    0.579205] physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit bank
[    0.586062]  Amd/Fujitsu Extended Query Table at 0x0041
[    0.591456] number of CFI chips: 1
[    0.594973] cfi_cmdset_0002: Disabling erase-suspend-program due to 
code brokenness.
[    0.602916] 4 cmdlinepart partitions found on MTD device physmap-flash.0
[    0.609759] Creating 4 MTD partitions on "physmap-flash.0":
[    0.615454] 0x00000000-0x00010000 : "env"
[    0.619599] mtd: Giving out device 0 to env
[    0.628166] 0x00010000-0x00030000 : "uboot"
[    0.632563] mtd: Giving out device 1 to uboot
[    0.641172] 0x00030000-0x00160000 : "kernel"
[    0.645744] mtd: Giving out device 2 to kernel
[    0.654372] 0x00160000-0x00400000 : "fs"
[    0.658604] mtd: Giving out device 3 to fs
[    0.666992] block2mtd: version $Revision: 1.30 $
[    0.673341] mice: PS/2 mouse device common for all mice
[    0.679193] TCP cubic registered
[    0.683016] NET: Registered protocol family 1
[    0.687619] NET: Registered protocol family 17
[    0.696556] MTDSB: dev_name "/dev/root"
[    0.700723] MTDSB: path_lookup() returned 0, inode c02ec290
[    0.706515] MTDSB: New superblock for device 3 ("fs")
[    2.386543] VFS: Mounted root (jffs2 filesystem).
[    2.392022] Freeing unused kernel memory: 76k init
[    2.397182] Warning: unable to open an initial console.
[    2.416877] Kernel panic - not syncing: No init found.  Try passing 
init= option to kernel.
[    2.427312] Rebooting in 180 seconds..


It seems to me, that the kernel does not find ANY file. because the 
/dev/console file is in the image, but the initial console is not found too

any ideas and hints are appreciated
regars
georg



-------------------------------------------------------------------
-------------------------------------------------------------------
Forschungszentrum Jülich GmbH
52425 Jülich

Sitz der Gesellschaft: Jülich
Eingetragen im Handelsregister des Amtsgerichts Düren Nr. HR B 3498
Vorsitzende des Aufsichtsrats: MinDir'in Bärbel Brumme-Bothe
Geschäftsführung: Prof. Dr. Achim Bachem (Vorsitzender),
Dr. Ulrich Krafft (stellv. Vorsitzender), Prof. Dr. Harald Bolt,
Dr. Sebastian M. Schmidt
-------------------------------------------------------------------
-------------------------------------------------------------------
