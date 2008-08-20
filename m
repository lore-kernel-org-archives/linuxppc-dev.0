Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from VA3EHSOBE003.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id 41C72DEF82
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 06:19:13 +1000 (EST)
Message-ID: <48AC7AAB.4090109@am.sony.com>
Date: Wed, 20 Aug 2008 13:12:27 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 0/4] PS3 patches for 2.6.27
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

This is a set of PS3 fixup patches for 2.6.27.

Patch 4/4, Fix ioremap of spu shadow regs, is a bit of a hack, but I
can't think of a better way to get the needed protection bits.

 [patch 1/4] powerpc: Fix typo in pgtable-ppc64.h
 [patch 2/4] powerpc/ps3: Update ps3_defconfig
 [patch 3/4] powerpc/ps3: Rework htab to remove ioremap
 [patch 4/4] powerpc/ps3: Fix ioremap of spu shadow regs

-Geoff


-- 
