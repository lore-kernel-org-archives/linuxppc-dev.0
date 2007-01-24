Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17847.18482.465113.686036@cargo.ozlabs.ibm.com>
Date: Wed, 24 Jan 2007 22:51:14 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: Patches pushed to powerpc.git for-2.6.21 branch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I just pushed the following patches to the for-2.6.21 (and master)
branches of the powerpc.git repository.  If anyone has sent any other
patches in the past that they think should go in 2.6.21 (or 2.6.20,
for that matter), they should resend them.  I also have two small
bug-fix patches from Geert that I will try to get Linus to take before
2.6.20.

Paul.

Adrian Bunk (1):
      [POWERPC] Remove the broken Gemini support

Akinobu Mita (1):
      [POWERPC] Use is_init() instead of pid==1

Anton Blanchard (1):
      [POWERPC] Move ELF_ET_DYN_BASE up to 512MB point

David Woodhouse (1):
      [POWERPC] Mask 32-bit system call arguments to 32 bits on PPC64 in audit code

Ishizaki Kou (9):
      [POWERPC] spufs: Add SPU register lock
      [POWERPC] TLB insertion cleanup
      [POWERPC] Fix oprofile support on Cell LPAR
      [POWERPC] Add a field for each specific bus to struct pci_controller
      [POWERPC] Add IRQ remapping hook
      [POWERPC] Celleb: hypervisor call numbers
      [POWERPC] Celleb: Cell SCC definitions
      [POWERPC] Celleb: Support PCI bus and base of I/O
      [POWERPC] Celleb: setup sio in SCC

Linas Vepstas (1):
      [POWERPC] Clarify EEH error message

Mariusz Kozlowski (6):
      [POWERPC] arch/ppc/kernel/prom.c of_node_(get|put) cleanup
      [POWERPC] arch/powerpc/kernel/vio.c of_node_put cleanup
      [POWERPC] arch/powerpc/sysdev/ipic.c of_node_get cleanup
      [POWERPC] arch/powerpc/sysdev/mpic.c of_node_get cleanup
      [POWERPC] arch/powerpc/sysdev/qe_lib of_node_get cleanup
      [POWERPC] arch/powerpc/sysdev/cpm2_pic.c of_node_get cleanup

Michal Ostrowski (1):
      [POWERPC] Do not write virq back to PCI config space

Nathan Lynch (1):
      [POWERPC] maple: improve CPC9x5 host bridge detection

Olaf Hering (1):
      [POWERPC] Update fixup_winbond_82c105 comment

Paul Gortmaker (1):
      [POWERPC] Select DEFAULT_UIMAGE for HPC-NET/8641

Simon Vallet (1):
      [POWERPC] Add support for R_PPC_ADDR16_HI relocations
