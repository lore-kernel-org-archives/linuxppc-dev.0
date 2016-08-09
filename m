Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7jSz2zGxzDqJ5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 15:26:58 +1000 (AEST)
Received: from localhost (localhost [IPv6:::1])
 by trent.utfs.org (Postfix) with ESMTPS id 80C5865F18
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 07:19:34 +0200 (CEST)
Date: Mon, 8 Aug 2016 22:19:34 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: 4.8.0-rc1: Invalid memory access at $SRR0: 0140f86c  $SRR1: 00003030
Message-ID: <alpine.DEB.2.20.14.1608082213450.8131@trent.utfs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

while trying to upgrade this PowerBook G4 from 4.7-rc7 to 4.8-rc1, it's 
unable to boot the Yaboot (v1.3.16 from Debian/stable) boot loader:

================================================================
copying OF device tree...
Building dt strings...
Building dt stucture...
Device tree strings 0x01e72000 -> 0x01e73615
Device tree struct  0x01e74000 -> 0x01e7e000
Quiescing Open Firmware...
Bootng Linux via __start()...

Invalid memory access at $SRR0: 0140f86c  $SRR1: 00003030

Apple PowerBook6,8 4.9.0f0 BootROM built on 01/10/05 at 10:39:14
[...]

 ok
0:> _
================================================================

Going back to 4.7-rc7 (w/o installing Yaboot again) works just fine. The 
config is mostly the same (used "make oldconfig" from 4.7), but I've said 
YES to CONFIG_SLAB_FREELIST_RANDOM - could this be causing the boot 
failure? Full .config and screen shot: http://nerdbynature.de/bits/4.8.0-rc1/

Thanks,
Christian.
-- 
BOFH excuse #319:

Your computer hasn't been returning all the bits it gets from the Internet.
