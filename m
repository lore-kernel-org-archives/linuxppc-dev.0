Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18437.61934.495516.351438@cargo.ozlabs.ibm.com>
Date: Wed, 16 Apr 2008 22:32:46 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: More patches pushed to powerpc.git master and powerpc-next branches
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following commits are now in the master and powerpc-next branches
in the powerpc.git tree.  This includes commits pulled from Josh
Boyer's and Olof Johansson's trees.

Paul.

Adrian Bunk (1):
      [POWERPC] Add MODULE_LICENSE to powerpc/sysdev/rtc_cmos_setup.c

Anton Vorontsov (2):
      [POWERPC] OF helpers for the GPIO API
      [POWERPC] Implement support for the GPIO LIB API

Benjamin Herrenschmidt (3):
      [POWERPC] Initialize paca->current earlier
      [POWERPC] Fixup softirq preempt count
      [POWERPC] properly declare onstack completion in iseries veth

David Woodhouse (1):
      [POWERPC] Efika: Really, don't pretend to be CHRP

Ishizaki Kou (2):
      [POWERPC] celleb: Coding style cleanup
      [POWERPC] hvcbeat: Fix buffer manipulation

Jerone Young (1):
      [POWERPC] 4xx: Add idle wait support for 44x platforms

Jochen Friedrich (1):
      [POWERPC] i2c: OF helpers for the i2c API

Josh Boyer (2):
      [POWERPC] 4xx: Reorganize 4xx defconfigs
      [POWERPC] 4xx: Add ppc40x_defconfig

Kumar Gala (12):
      [POWERPC] Remove Kconfig option BOOT_LOAD
      [POWERPC] Provide access to arch/powerpc include path on ppc64
      [POWERPC] Remove and replace uses of PPC_MEMSTART with memstart_addr
      [POWERPC] Introduce lowmem_end_addr to distinguish from total_lowmem
      [POWERPC] 85xx: Cleanup TLB initialization
      [POWERPC] Use lowmem_end_addr to limit lmb allocations on ppc32
      [POWERPC] Rename __initial_memory_limit to __initial_memory_limit_addr
      [POWERPC] Clean up some linker and symbol usage
      [POWERPC] Move phys_addr_t definition into asm/types.h
      [POWERPC] Update linker script to properly set physical addresses
      [POWERPC] bootwrapper: Use physical address in PHDR for uImage
      [POWERPC] Cleanup pgtable-ppc32.h

Manish Ahuja (1):
      [POWERPC] pseries/phyp dump: Reserve a variable amount of space at boot

Nate Case (1):
      pasemi_mac: Netpoll support

Olof Johansson (2):
      pasemi_mac: Jumbo frame bugfixes
      [POWERPC] pasemi: Minor iommu cleanup

Valentine Barshak (3):
      [POWERPC] kexec: MPIC ack interrupts at mpic_teardown_this_cpu()
      [POWERPC] ibm_newemac: PowerPC 440GX EMAC PHY clock workaround
      [POWERPC] ibm_newemac: PowerPC 440EP/440GR EMAC PHY clock workaround
