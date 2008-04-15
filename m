Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18436.41073.464457.384938@cargo.ozlabs.ibm.com>
Date: Tue, 15 Apr 2008 22:32:49 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: Patches pushed to powerpc.git master and powerpc-next branches
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have just pushed the following patches to the master and
powerpc-next branches of the powerpc.git repository, and pulled in
Linus' tree as of 2.6.25-rc9.

Paul.

Dale Farnsworth (5):
      [POWERPC] prpmc2800: Fix frequencies in prpmc2800.dts
      [POWERPC] mv64x60: Remove device tree absolute path references
      [POWERPC] mv643xx_eth: Prepare to support multiple silicon blocks
      [POWERPC] Document the mv64x60 device tree bindings
      [POWERPC] prpmc2800 needs a dtbImage

David S. Miller (1):
      [LMB] Add lmb_alloc_nid()

Mark A. Greer (3):
      [POWERPC] prpmc2800: Convert DTS to v1 and add labels
      [POWERPC] mv64x60: Fix FDT compatible names: mv64x60 => mv64360
      [POWERPC] prpmc2800: Clean up dts properties

Paul Mackerras (3):
      [POWERPC] Fix handling of unrecoverable SLB miss interrupts
      [LMB] Fix some whitespace and other formatting issues, use pr_debug
      [LMB] Restructure allocation loops to avoid unsigned underflow

Stephen Rothwell (6):
      [POWERPC] Fix MAX_ORDER config problem
      [POWERPC] iSeries: Use alternate paca structure for booting
      [POWERPC] iSeries: Make iseries_reg_save private to iSeries
      [POWERPC] iSeries: Localise and constify some iSeries data
      [POWERPC] remove include of asm/of_device.h from pmi.h
      [POWERPC] replace asm/of_device.h with linux/of_device.h in macio.h
