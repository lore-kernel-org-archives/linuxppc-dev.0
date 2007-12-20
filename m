Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: More patches added to for-2.6.25 and master branches of
	powerpc.git
In-reply-to: <18282.19253.485799.233476@cargo.ozlabs.ibm.com> 
References: <18282.19253.485799.233476@cargo.ozlabs.ibm.com>
Date: Fri, 21 Dec 2007 10:22:29 +1100
Message-ID: <6232.1198192949@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paulus,

Can you take the crash shutdown hook patches as well?

http://patchwork.ozlabs.org/linuxppc/patch?person=414&id=15546
http://patchwork.ozlabs.org/linuxppc/patch?person=414&id=15547

Mikey


In message <18282.19253.485799.233476@cargo.ozlabs.ibm.com> you wrote:
> Andre Detsch (1):
>       [POWERPC] cell: safer of_has_vicinity routine
> 
> Balbir Singh (1):
>       [POWERPC] Fake NUMA emulation for PowerPC
> 
> Benjamin Herrenschmidt (20):
>       [POWERPC] pci32: Remove bogus alignment message
>       [POWERPC] pci32: Use generic pci_assign_unassign_resources
>       [POWERPC] pci32: Remove PowerMac P2P bridge IO hack
>       [POWERPC] pci32: Add flags modifying the PCI code behaviour
>       [POWERPC] pci32: Remove obsolete PowerMac bus number hack
>       [POWERPC] pci32: Add platform option to enable /proc PCI domains
>       [POWERPC] Merge pcibios_resource_to_bus/bus_to_resource
>       [POWERPC] Merge PCI resource fixups
>       [POWERPC] Merge PCI resource allocation & assignment
>       [POWERPC] fix iSeries PCI resource management
>       [POWERPC] Updates/fixes to 32 bits pcibios_enable_device()
>       [POWERPC] Merge 32 and 64 bits pcibios_enable_device
>       [POWERPC] Fixup powermac enable device hook
>       [POWERPC] Clear pci_probe_only on 64 bits PowerMac
>       [POWERPC] Various fixes to pcibios_enable_device()
>       [POWERPC] Enable self-view of the HT host bridge on PowerMac G5
>       [POWERPC] Improve resource setup of PowerMac G5 HT bridge
>       [POWERPC] Fixup skipping of PowerMac PCI<->PCI bridge "closed" resource
s
>       [POWERPC] Disable PCI IO/Mem on a device when resources can't be alloca
ted
>       [POWERPC] Fix PCI IRQ fallback code to not map IRQ 0
> 
> Bob Nelson (1):
>       [POWERPC] OProfile: fix cbe pm signal routing problem
> 
> Cyrill Gorcunov (1):
>       [POWERPC] CHRP: Fix possible NULL pointer dereference
> 
> David Gibson (2):
>       [POWERPC] Merge dtc upstream source
>       [POWERPC] Use embedded dtc in kernel builds
> 
> Grant Likely (1):
>       [POWERPC] Add machine initcall macros
> 
> Ishizaki Kou (3):
>       [POWERPC] cell: add missing '\n'
>       [POWERPC] Cleanup calling mmio_nvram_init
>       [POWERPC] celleb: Split machine definition
> 
> Jeremy Kerr (6):
>       [POWERPC] cell: export force_sig_info()
>       [POWERPC] cell: handle kernel SLB setup in spu_base.c
>       [POWERPC] cell: use spu_load_slb for SLB setup
>       [POWERPC] cell: add spu_64k_pages_available() check
>       [POWERPC] cell: handle SPE kernel mappings that cross segment boundarie
s
>       [POWERPC] cell: catch errors from sysfs_create_group()
> 
> Jochen Friedrich (2):
>       [POWERPC] Add support for PORTA and PORTB odr registers
>       [POWERPC] Move CPM command handling into the cpm drivers
> 
> Johannes Berg (3):
>       [POWERPC] adb: Replace sleep notifier with platform driver suspend/resu
me hooks
>       [POWERPC] via-pmu: Kill sleep notifiers completely
>       [POWERPC] powermac: Use generic suspend code
> 
> Jon Loeliger (3):
>       [POWERPC] 8xxx: Convert #include of asm/of_{platform, device}.h into li
nux/of_{platform, device}.h.
>       [POWERPC] 86xx: Add aliases node to 8641hpcn DTS file.
>       [POWERPC] cell: Convert #include of asm/of_{platform, device}.h into li
nux/of_{platform, device}.h.
> 
> Julia Lawall (3):
>       [POWERPC] arch/ppc: Remove an unnecessary pci_dev_put
>       [POWERPC] arch/powerpc: Add missing of_node_put
>       [POWERPC] cell/cbe_regs.c: Add missing of_node_put
> 
> Kevin Corry (1):
>       [POWERPC] perfmon2: make pm_interval register read/write
> 
> Kumar Gala (5):
>       [POWERPC] Add SPRN for Embedded registers specified in PowerISA 2.04
>       [POWERPC] Emulate isel (Integer Select) instruction
>       [POWERPC] FSL: I2C device tree cleanups
>       [POWERPC] FSL: enet device tree cleanups
>       [POWERPC] FSL: Added aliases node to device trees
> 
> Li Yang (5):
>       [POWERPC] add e300c4 entry to cputable
>       [POWERPC] ipic: add new interrupts introduced by new chip
>       [POWERPC] 83xx: Add platform support for MPC837x MDS board
>       [POWERPC] 83xx: Add MPC837x MDS default kernel configuration
>       [POWERPC] ipic: ack only for edge interrupts
> 
> Li Zefan (1):
>       [POWERPC] Don't cast a struct pointer to list_head pointer
> 
> Lucas Woods (2):
>       [POWERPC] arch/powerpc: Remove duplicate includes
>       [POWERPC] arch/ppc: Remove duplicate includes
> 
> Michael Ellerman (1):
>       [POWERPC] Implement pci_set_dma_mask() in terms of the dma_ops
> 
> Milton Miller (6):
>       [POWERPC] Push down or eliminate smp_processor_id calls in xics code
>       [POWERPC] init_decrementer_clockevent can be static __init
>       [POWERPC] Use __get_cpu_var in time.c
>       [POWERPC] Timer interrupt: use a struct for two per_cpu varables
>       [POWERPC] Depend on ->initialized in calc_steal_time
>       [POWERPC] Optimize account_system_vtime
> 
> Olof Johansson (3):
>       [POWERPC] MPIC: Minor optimization of ipi handler
>       [POWERPC] pasemi: Implement MSI support
>       [POWERPC] holly.c: Remove unnecessary include of linux/ide.h
> 
> Paul Mackerras (5):
>       [POWERPC] Convert media-bay.c to use the kthread API
>       [POWERPC] Convert adb.c to use kthread API and not spin on ADB requests
>       [POWERPC] Convert therm_pm72.c to use the kthread API
>       [POWERPC] Convert therm_windtunnel.c to use the kthread API
>       [POWERPC] Fix sleep on powerbook 3400
> 
> Scott Wood (5):
>       [POWERPC] 8xx: Convert mpc866ads to the new device binding.
>       [POWERPC] 83xx: mpc834x_mds: Fix whitespace and call of_platform_bus_pr
obe().
>       [POWERPC] 83xx: mpc8313erdb: Fix whitespace.
>       [POWERPC] wrapper: Rename offset in offset_devp()
>       [POWERPC] wrapper: Treat NULL as root node in devp_offset; add devp_off
set_find()
> 
> Stephen Rothwell (2):
>       [POWERPC] iSeries: Fix unregistering HV event handlers
>       [POWERPC] Stop the TOC overflowing for large builds
> 
> Timur Tabi (4):
>       [POWERPC] 86xx: fix guts_set_dmacr() and add guts_set_pmuxcr_dma() to i
mmap_86xx.h
>       [POWERPC] QE: change qe_setbrg() to take an enum qe_clock instead of an
 integer
>       [POWERPC] qe: add function qe_clock_source()
>       [POWERPC] ucc_geth: use rx-clock-name and tx-clock-name device tree pro
perties
> 
> joe@perches.com (4):
>       [POWERPC] arch/powerpc/: Spelling fixes
>       [POWERPC] include/asm-powerpc/: Spelling fixes
>       [POWERPC] arch/ppc/: Spelling fixes
>       [POWERPC] include/asm-ppc/: Spelling fixes
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
