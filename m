Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 50DC5DDEF0
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 04:55:52 +1000 (EST)
Message-ID: <466EE8D9.2000309@am.sony.com>
Date: Tue, 12 Jun 2007 11:41:29 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 00/30] PS3 patches for 2.6.23, take 2
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul.

This is the full set of PS3 related patches I have for 2.6.23.

Patches 1-19 were sent out before.  The versions here have been
updated to address issues raised in the review.  Patches 20 and
21 are new, and came from the review of Patches 1-19.

Patches 22-28 are new.  These are changes to the core powerpc code.
They add some minor enhancements for debugging and add changes to the
bootwapper support needed for PS3.

Patches 29 and 30 are are new, and are the PS3 bootwrapper support.
These add the support needed to program the kernel into the PS3's
flash rom.

[01/30] Cell: Add spu shutdown method
[02/30] PS3: Rename IPI symbols
[03/30] PS3: Use __maybe_unused
[04/30] PS3: Compare firmware version
[05/30] PS3: Use ioremap_flags
[06/30] PS3: Fix sparse warnings
[07/30] PS3: Add support for HDMI RGB Full Range mode
[08/30] PS3: Move chip mask defs up
[09/30] PS3: Use inline DBG
[10/30] PS3: Kexec support
[11/30] PS3: System-bus rework
[12/30] PS3: System-bus uevent
[13/30] PS3: System-bus modinfo attribute
[14/30] PS3: Repository probe cleanups
[15/30] PS3: Vuart rework
[16/30] PS3: System manager re-work
[17/30] PS3: Rework AV settings driver
[18/30] PS3: Frame buffer system-bus rework
[19/30] PS3: Device registration routines.
[20/30] PS3: Rename processor id symbols
[21/30] PS3: Use clear_bit
[22/30] Powerpc: Output params value in early_init_devtree
[23/30] powerpc: Localize mmu_off
[24/30] powerpc: Correct __secondary_hold comment
[25/30] Powerpc: Add signed types to bootwrapper
[26/30] Powerpc: Add u64 printf to bootwrapper
[27/30] Powerpc: Fix constantness of bootwrapper arg
[28/30] powerpc: Bootwrapper global scope kernel_entry_t.
[29/30] PS3: Device tree source.
[30/30] PS3: Bootwrapper support.

-Geoff

-- 
