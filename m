Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <4963CDCA.4080802@am.sony.com>
Date: Tue, 6 Jan 2009 13:31:54 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch 0/6] ps3vram driver patches
Content-Type: text/plain; charset="ISO-8859-1"
Cc: David Woodhouse <David.Woodhouse@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	Jim Paris <jim@jtan.com>, linuxppc-dev@ozlabs.org,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Vivien Chappelier <vivien.chappelier@free.fr>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben,

This is a set of patches for the ps3vram driver.

Patch 1 adds the driver.  It has already been reviewed on the cbe-oss-dev ML
and has been acked by David Woodhouse, so should be ready to merge.

Patch 2 is a minor update to reflect changes to the ps3-system-bus that have
been merged into mainline since this driver was posted, and so can be merged.

Patches 3-6 are minor cleanups suggested by Arnd Bergmann.  I have left two
of Arnd's sugestions, implementing the driver as a block device, similar to
the axonram driver, and eliminating the need to ioremap.  These will require
a significant re-work.


 [patch 1/6] powerpc/ps3: ps3vram driver for accessing video RAM as MTD
 [patch 2/6] powerpc/ps3: Add modalias support to the ps3vram driver
 [patch 3/6] mtd/ps3vram: Remove ps3vram debug routines
 [patch 4/6] mtd/ps3vram: Cleanup ps3vram driver messages
 [patch 5/6] mtd/ps3vram: Use kernel types
 [patch 6/6] mtd/ps3vram: Use msleep in waits

-Geoff


-- 
