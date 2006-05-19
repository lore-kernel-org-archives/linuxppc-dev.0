Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17517.24746.250859.20533@cargo.ozlabs.ibm.com>
Date: Fri, 19 May 2006 16:07:38 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: powerpc.git updated
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I just pushed a bunch of patches to the powerpc.git tree (master
branch) and pulled in Linus' current linux-2.6.git tree.  The list
below shows which patches are in there but not in Linus' tree yet.
These will all go upstream after 2.6.17 is released.  If you have a
patch that you want to go in that I haven't picked up yet, please
resend it.

Paul.

Andy Fleming:
      Add 85xx CDS to arch/powerpc

Anton Blanchard:
      powerpc: remove io_page_mask

Geoff Levand:
      powerpc: remove do-nothing cpu setup routines

Haren Myneni:
      powerpc: clear IPIs on kdump

Jeremy Kerr:
      powerpc: cell: use kzalloc in alloc_spu_context()
      powerpc: Add of_parse_dma_window()
      powerpc: pseries: Use generic dma-window parsing function

Jimi Xenidis:
      powerpc: Auto reserve of device tree blob

jimix@watson.ibm.com:
      powerpc: udbg_printf() formatting attribute

Kumar Gala:
      powerpc: provide ppc_md.panic() for both ppc32 & ppc64

Linas Vepstas:
      powerpc/pseries: clear PCI failure counter if no new failures
      powerpc/pseries: Increment fail counter in PCI recovery

Michael Ellerman:
      powerpc: Disable and EOI interrupts in machine_crash_shutdown()
      powerpc: Make early debugging options behave with oldconfig
      powerpc: Make early xmon logic immune to location of early parsing
      powerpc: Parse early parameters earlier
      powerpc: Unify mem= handling
      powerpc: Kdump header cleanup
      powerpc: Move crashkernel= handling into the kernel.

Michael Neuling:
      powerpc: whitespace cleanup in reg.h

mostrows@watson.ibm.com:
      powerpc: Create /proc/rtas, /proc/ppc64/rtas if RTAS exists.

Olof Johansson:
      powerpc: Quiet HVSI boot output
      powerpc: Quiet time init output
      powerpc: Quiet page order output
      powerpc: Quiet VETH version printk
      powerpc: Don't print chosen idle loop at every boot
      powerpc: Less verbose mem configuration output
      powerpc: Lack of ISA interrupts on XICS isn't dangerous
      powerpc: Quiet PCI init printouts
      powerpc: Quiet rtasd output at boot
      powerpc: Quiet oprofile output at boot
      powerpc: Remove stale iseries global
      powerpc: kill union tce_entry
      powerpc iommu: minor cleanup

Stephen Rothwell:
      powerpc: add all the iSeries virtual devices to the device tree
      powerpc: use the device tree for the iSeries vio bus probe
      powerpc: use a common vio_match_device routine
      powerpc: merge the rest of the vio code
      powerpc: update iseries_veth device-tree information
      powerpc: update iSeries viodasd device-tree entries
      powerpc: update iSeries vdevice
      powerpc: update iSeries viocd and viotape device-tree
      powerpc: the iSeries vio lan driver changed device type

Will Schmidt:
      nvram_print_partitions cosmetic fixup
