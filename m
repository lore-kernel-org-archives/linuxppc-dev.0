Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18604.47717.829929.695541@cargo.ozlabs.ibm.com>
Date: Thu, 21 Aug 2008 10:44:21 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: Patches pushed to powerpc.git master & powerpc-next branches
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have committed the following patches to the master and powerpc-next
branches of the powerpc.git repository.  These will be going upstream
in the 2.6.28 merge window.

Paul.

Adrian Bunk (1):
      powerpc: Use bcd2bin/bin2bcd

Benjamin Herrenschmidt (2):
      powerpc: Turn get/set_hard_smp_proccessor_id into inlines
      powerpc: Expose PMCs & cache topology in sysfs on 32-bit

David Gibson (1):
      powerpc: Update in-kernel dtc and libfdt to version 1.2.0

Harvey Harrison (2):
      powerpc: Use the common ascii hex helpers
      powerpc: Replace __FUNCTION__ with __func__

Michael Ellerman (5):
      powerpc: Streamline ret_from_except_lite for non-iSeries platforms
      powerpc: fsl_msi doesn't need it's own of_node
      powerpc: Split-out common MSI bitmap logic into msi_bitmap.c
      powerpc: Convert the FSL MSI code to use msi_bitmap
      powerpc: Convert the MPIC MSI code to use msi_bitmap

Nathan Lynch (1):
      powerpc: Remove redundant sysfs_remove_file calls for cache info

Stephen Rothwell (4):
      powerpc: Remove include of linux/of_platform.h from asm/of_platform.h
      hotplug/rpaphp: Remove unused error path code
      powerpc/drivers: Use linux/of_device.h instead of asm/of_device.h
      powerpc: Remove include of linux/of_device.h from asm/of_device.h

Tony Breeds (3):
      powerpc: Guard htab_dt_scan_hugepage_blocks appropriately
      powerpc: Guard from_rtc_time() in platforms/powermac/time.c
      powerpc: Guard print_device_node_tree() with #if 0
