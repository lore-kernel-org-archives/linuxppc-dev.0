Return-Path: <wilbur512@gmail.com>
Received: from mail-yw0-f184.google.com (mail-yw0-f184.google.com
	[209.85.211.184]) by ozlabs.org (Postfix) with ESMTP id C38B8B7B69
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 25 Sep 2009 02:33:38 +1000 (EST)
Received: by ywh14 with SMTP id 14so2291595ywh.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 24 Sep 2009 09:33:36 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 25 Sep 2009 00:33:36 +0800
Message-ID: <e997b7420909240933y38717f46p5ff128f3b05b6eb8@mail.gmail.com>
Subject: Problem when loading initrd
From: "wilbur.chan" <wilbur512@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I got some problems when starting a kernel withCONFIG_BLK_DEV_RAM  and
using initrd-image (not cpio)    (mpc85xx)

RAMDISK: ext2 filesystem found at block 0
RAMDISK: Loading 4096KiB [1 disk] into ram disk... RAMDISK: Loading
4096KiB [1 d
isk] into ram disk... done.

No filesystem could mount root, tried: No filesystem could mount root, tried:

Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(1,0)




kernel boot param:  bootargs root=/dev/ram console=ttyS0,115200

I guess the problem lie in :

mount_root-->mount_block_root--->do_mount_root--->
sys_mount(name, "/root")

but I don't know  where the problem is . Any suggestions?  Thank you very much.
