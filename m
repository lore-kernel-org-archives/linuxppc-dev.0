Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound6-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B6AE6DE1D6
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 08:09:09 +1000 (EST)
Message-ID: <467301DB.7000108@am.sony.com>
Date: Fri, 15 Jun 2007 14:17:15 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 00/33] PS3 patches for 2.6.23, take 3
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
	
	I feel these patches are now ready.  There are no outstanding issues.
	We did a lot of format cleanups since the last set, so these have a
	lot of small differences.
	
	There are three new patches.  Patch 31 to set CONFIG_MEMORY_HOTPLUG
	for PS3 builds, Patch 32 a collection of sparse warning fixes,
	and Patch 33 to update ps3_defconfig.
	
	[01/32] Cell: Add spu shutdown method
	[02/32] PS3: Rename IPI symbols
	[03/32] PS3: Use __maybe_unused
	[04/32] PS3: Compare firmware version
	[05/32] PS3: Use ioremap_flags
	[06/32] PS3: Fix sparse warnings
	[07/32] PS3: Add support for HDMI RGB Full Range mode
	[08/32] PS3: Move chip mask defs up
	[09/32] PS3: Simplify definition of DBG
	[10/32] PS3: Kexec support
	[11/32] PS3: System-bus rework
	[12/32] PS3: System-bus uevent
	[13/32] PS3: System-bus modinfo attribute
	[14/32] PS3: Repository probe cleanups
	[15/32] PS3: Vuart rework
	[16/32] PS3: System manager re-work
	[17/32] PS3: Rework AV settings driver
	[18/32] PS3: Frame buffer system-bus rework
	[19/32] PS3: Device registration routines.
	[20/32] PS3: Rename processor id symbols
	[21/32] PS3: Use clear_bit
	[22/32] powerpc: Output params value in early_init_devtree
	[23/32] powerpc: Localize mmu_off
	[24/32] powerpc: Correct __secondary_hold comment
	[25/32] Powerpc: Add signed types to bootwrapper
	[26/32] Powerpc: Add u64 printf to bootwrapper
	[27/32] Powerpc: Fix constantness of bootwrapper arg
	[28/32] powerpc: Bootwrapper global scope kernel_entry_t.
	[29/32] PS3: Device tree source.
	[30/32] PS3: Bootwrapper support.
	[31/32] PS3: Select MEMORY_HOTPLUG.
	[32/32] PS3: Fix more sparse warnings
	[33/33] PS3: Update ps3_defconfig

	-Geoff

-- 
