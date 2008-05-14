Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18475.30315.579805.168910@cargo.ozlabs.ibm.com>
Date: Thu, 15 May 2008 09:31:55 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: Patches added to powerpc.git powerpc-next branch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have added the following patches to the powerpc-next and master
branches of the powerpc.git repository.  This includes commits pulled
from Kumar's tree.

Paul.

Andy Fleming (2):
      [POWERPC] 85xx: Add 8568 PHY workarounds to board code
      [POWERPC] 85xx: Fix some sparse warnings for 85xx MDS

Anton Vorontsov (3):
      [POWERPC] 86xx: mpc8610_hpcd: use ULI526X driver for on-board ethernet
      [POWERPC] 86xx: mpc8610_hpcd: add support for NOR and NAND flashes
      [POWERPC] 86xx: mpc8610_hpcd: fix second serial port

Becky Bruce (1):
      [POWERPC] Delete unused fec_8xx net driver

Jeremy McNicoll (1):
      [POWERPC] 85xx: SBC8548 - Add flash support and HW Rev reporting

Kumar Gala (1):
      [POWERPC] Set lower flag bits in regs->trap to indicate debug level exception

Michael Ellerman (12):
      [POWERPC] Move declaration of init_bootmem_done into system.h
      [POWERPC] Fix sparse warnings in arch/powerpc/mm
      [POWERPC] Move declaration of tce variables into mmu-hash64.h
      [POWERPC] Remove duplicate variable definitions in mm/tlb_64.c
      [POWERPC] sysdev/mpic_msi.c should include sysdev/mpic.h
      [POWERPC] Add a declaration for xmon()
      [POWERPC] Move xmon_irq() declaration into xmon.h
      [POWERPC] Fix sparse warnings in xmon.c
      [POWERPC] Make cpus_in_xmon static and remove extern mess from hvc_console.c
      [POWERPC] Fix sparse warnings in arch/powerpc/kernel
      [POWERPC] pseries/firmware.c should include pseries/pseries.h
      [POWERPC] Fix sparse warnings in arch/powerpc/platforms/pseries

Olaf Hering (1):
      [POWERPC] Create modalias file in sysfs for of_platform bus

Remi Machet (1):
      [POWERPC] Create of_buses for MV64x60 devices

Roel Kluin (2):
      [POWERPC] mpic_pasemi_msi: Failed allocation unnoticed
      [POWERPC] mpic_u3msi: Failed allocation unnoticed

Roland McGrath (1):
      [POWERPC] Define and use TLF_RESTORE_SIGMASK

Zhang Wei (1):
      [POWERPC] 83xx: Enable DMA engine on the MPC8377 MDS board.
