Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18706.22388.866402.123514@cargo.ozlabs.ibm.com>
Date: Thu, 6 Nov 2008 13:33:24 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: Commits pushed to powerpc.git next branch
Cc: sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have just pushed the following commits to the "next" branch of my
powerpc.git repository.  The "next" branch is what I'll push to Linus
when the 2.6.29 merge window opens.

I'm now using a new "next" branch rather than the "powerpc-next"
branch at Stephen Rothwell's request, since the "powerpc-" part was
redundant.  (Stephen, please include the "next" branch in linux-next
rather than "powerpc-next".)

The "master" branch in powerpc.git is currently following "next".

Paul.

Anton Vorontsov (1):
      powerpc: Remove device_type = "rtc" properties in .dts files

Benjamin Herrenschmidt (10):
      powerpc: Fix domain numbers in /proc on 64-bit
      powerpc: Silence software timebase sync
      powerpc/pci: Cleanup debug printk's
      powerpc/pci: Use common PHB resource hookup
      powerpc/pci: Remove pcibios_do_bus_setup()
      powerpc/pci: Split pcibios_fixup_bus() into bus setup and device setup
      powerpc/eeh: Make EEH device add/remove more robust
      powerpc/pci: Make pcibios_allocate_bus_resources more robust
      powerpc/pci: Fix various pseries PCI hotplug issues
      powerpc/pci: Cosmetic cleanups of pci-common.c

Brian King (1):
      powerpc: Update page-in counter for CMM

Harvey Harrison (1):
      powerpc: Use the new byteorder headers

Jon Tollefson (1):
      powerpc: Hugetlb pgtable cache access cleanup

Mark Nelson (3):
      powerpc: Add new CPU feature: CPU_FTR_UNALIGNED_LD_STD
      powerpc: Update 64bit memcpy() using CPU_FTR_UNALIGNED_LD_STD
      powerpc: Remove map_/unmap_single() from dma_mapping_ops

Masakazu Mokuno (1):
      powerpc/ps3: Fix memory leak in device init

Paul Mackerras (2):
      powerpc: Improve resolution of VDSO clock_gettime
      powerpc: Eliminate unused do_gtod variable

Sebastian Siewior (1):
      powerpc/boot: Allocate more memory for dtb

Sebastien Dugue (1):
      powerpc/pseries: Fix getting the server number size
