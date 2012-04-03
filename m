Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
 by ozlabs.org (Postfix) with ESMTP id 28EB5B6FE1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Apr 2012 17:25:53 +1000 (EST)
Date: Tue, 3 Apr 2012 00:20:24 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: 3.4.0-rc1: No init found
Message-ID: <alpine.DEB.2.01.1204030008080.4930@trent.utfs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Going from 3.3-rc7 to 3.4-rc1 (with "make oldconfig" inbetween) did not 
go well on this PowerBook G4 machine:

Apr  2 15:18:23 [   8.318816] EXT4-fs (hda6): mounted filesystem with ordered data mode. Opts: (null)
Apr  2 15:18:23 [   8.320286] VFS: Mounted root (ext4 filesystem) readonly on device 3:6.
Apr  2 15:18:23 [   8.341555] devtmpfs: mounted
Apr  2 15:18:23 [   8.343384] Freeing unused kernel memory: 204k freed
Apr  2 15:18:23 [   8.457056] Kernel panic - not syncing: No init found.  Try passing init= option to kernel. See Linux Documentation/init.txt for guidance.
Apr  2 15:18:23 [   8.459936] Rebooting in 180 seconds..

No bootoptions were changed, no disks swapped, no partitions altered 
whatsoever. Full .config & dmesg:

 http://nerdbynature.de/bits/3.4.0-rc1/init/

Thanks,
Christian.

PS: Unfortunately I cannot boot into the old (3.3-rc7) kernel 
    right now (which is still installed via "yaboot" and present in
    /boot), because of this: 
    http://nerdbynature.de/bits/3.4.0-rc1/init/mac-invalid-memory.JPG
    Booting into Debian's "squeeze" kernel (2.6.32) which resides in
    the same /boot directory succeeds.
-- 
BOFH excuse #334:

50% of the manual is in .pdf readme files
