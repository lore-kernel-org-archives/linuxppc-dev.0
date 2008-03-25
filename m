Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Message-ID: <18409.32313.610943.187982@cargo.ozlabs.ibm.com>
Date: Wed, 26 Mar 2008 09:35:37 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: Patches added to powerpc.git powerpc-next and master branches
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have added the patches listed below to the master and powerpc-next
branches of the powerpc.git repository, and pulled in Linus' current
tree.

Paul.

Manish Ahuja (10):
      [POWERPC] pseries: phyp dump: Documentation
      [POWERPC] pseries: phyp dump: Reserve and release memory
      [POWERPC] pseries: phyp dump: Use sysfs to release reserved mem
      [POWERPC] pseries: phyp dump: Register dump area
      [POWERPC] pseries: phyp dump: Debugging print routines
      [POWERPC] pseries: phyp dump: Invalidate and print dump areas
      [POWERPC] pseries: phyp dump: Tracking memory range freed
      [POWERPC] pseries: phyp dump: Add Kconfig file option
      [POWERPC] pseries: phyp dump: Disable phyp-dump through boot-var
      [POWERPC] pseries: phyp dump: Inform kdump when phyp-dump is load=
ed

Marian Balakowicz (1):
      [POWERPC] Add 'model: ...' line to common show=5Fcpuinfo()

Nathan Lynch (4):
      [POWERPC] maple: Use platform name in define=5Fmachine()
      [POWERPC] maple: Kill fixup=5Fmaple=5Fide
      [POWERPC] maple: Enable ipr driver in defconfig
      [POWERPC] scanlog=5Finit cleanup and minor fixes

Robert P. J. Day (1):
      [POWERPC] Move a.out.h to header-y since it doesn't check =5F=5FK=
ERNEL=5F=5F

Roland McGrath (2):
      [POWERPC] Don't touch PT=5FDTRACE in exec
      [POWERPC] powerpc32: Remove asm-offsets ptrace cruft

S.=C3=87a=C4=9Flar Onur (1):
      [POWERPC] arch/powerpc/platforms/iseries/pci.c: Use time=5F* macr=
os

Stephen Rothwell (1):
      [POWERPC] Really export empty=5Fzero=5Fpage

Tony Breeds (1):
      [POWERPC] Update wait=5Fstate=5Fcycles in the VPA
