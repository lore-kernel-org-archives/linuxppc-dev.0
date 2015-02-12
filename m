Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 56E741A08CC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Feb 2015 11:33:46 +1100 (AEDT)
Message-ID: <1423701224.24302.1.camel@ellerman.id.au>
Subject: [git pull] Please pull mpe/linux.git powerpc-3.20-1 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 12 Feb 2015 11:33:44 +1100
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-cqLy/Pm/bIXOlWPJjzwK"
Mime-Version: 1.0
Cc: weiyang@linux.vnet.ibm.com, Shaohui.Xie@freescale.com,
 sukadev@linux.vnet.ibm.com, Emilian.Medve@freescale.com, agraf@suse.de,
 scottwood@freescale.com, yongjun_wei@trendmicro.com.cn, paulus@samba.org,
 alexandru.sardan@freescale.com, afleming@gmail.com, cody@linux.vnet.ibm.com,
 elfring@users.sourceforge.net, khandual@linux.vnet.ibm.com, mikey@neuling.org,
 rickard_strandqvist@spectrumdigital.se, jolsa@redhat.com, vincent@bernat.im,
 alessio.bogani@elettra.eu, joel@jms.id.au, bobby.prani@gmail.com,
 rupran@einserver.de, cyrilbur@gmail.com, imunsie@au1.ibm.com,
 tom.huynh@freescale.com, eha@deif.com, alistair@popple.id.au,
 gwshan@linux.vnet.ibm.com, anton@samba.org, felix@linux.vnet.ibm.com,
 naveen.n.rao@linux.vnet.ibm.com, pebolle@tiscali.nl, geoff@infradead.org,
 linux-kernel@vger.kernel.org, grimm@linux.vnet.ibm.com, asolokha@kb.kras.ru,
 colin.king@canonical.com, computersforpeace@gmail.com,
 linuxppc-dev@lists.ozlabs.org, cascardo@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-cqLy/Pm/bIXOlWPJjzwK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull powerpc updates for 3.20:

The following changes since commit b7392d2247cfe6771f95d256374f1a8e6a6f48d6=
:

  Linux 3.19-rc2 (2014-12-28 16:49:37 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux.git tags/powerpc-=
3.20-1

for you to fetch changes up to a6130ed253a931d2169c26ab0958d81b0dce4d6e:

  cxl: Add missing return statement after handling AFU errror (2015-02-06 1=
1:17:27 +1100)

----------------------------------------------------------------
powerpc updates for 3.20

Including:

- Update of all defconfigs
- Addition of a bunch of config options to modernise our defconfigs
- Some PS3 updates from Geoff
- Optimised memcmp for 64 bit from Anton
- Fix for kprobes that allows 'perf probe' to work from Naveen
- Several cxl updates from Ian & Ryan
- Expanded support for the '24x7' PMU from Cody & Sukadev
- Freescale updates from Scott:
  "Highlights include 8xx optimizations, some more work on datapath device
   tree content, e300 machine check support, t1040 corenet error reporting,
   and various cleanups and fixes."

----------------------------------------------------------------
Alessio Igor Bogani (2):
      powerpc/85xx: Add support for Emerson/Artesyn MVME2500.
      powerpc: dts: pq3/85xx: Fix GPIO address

Alexandru-Cezar Sardan (1):
      perf/powerpc: reset event hw state when adding it to the PMU

Andreas Ruprecht (1):
      powerpc/lib: Do not include string.o in obj-y twice

Andy Fleming (1):
      powerpc/config: Enable MDIO support

Anshuman Khandual (2):
      powerpc/pseries: All events of EPOW_SYSTEM_SHUTDOWN must initiate shu=
tdown
      selftests/powerpc: Make git ignore all binaries in powerpc test suite

Anton Blanchard (7):
      powerpc: Enable on demand governor on ppc64_defconfig
      powerpc: Enable CONFIG_SATA_AHCI on pseries and ppc64 defconfigs
      powerpc: Enable KSM on pseries and ppc64 defconfigs
      powerpc: Enable overlayfs on pseries and ppc64 defconfigs
      powerpc: Enable various container features on pseries defconfigs.
      powerpc: Add 64bit optimised memcmp
      selftests/powerpc: Add memcmp testcase

Arseny Solokha (2):
      powerpc/mm: bail out early when flushing TLB page
      powerpc/mm: Warn on flushing tlb page in kernel context

Brian Norris (1):
      powerpc: defconfigs: add MTD_SPI_NOR (new dependency for M25P80)

Cody P Schafer (7):
      powerpc/pseries: relocate "config DTL" so kconfig nests properly
      perf: provide sysfs_show for struct perf_pmu_events_attr
      perf: add PMU_EVENT_ATTR_STRING() helper
      powerpc/perf/hv-24x7: parse catalog and populate sysfs with events
      powerpc/perf/{hv-gpci, hv-common}: generate requests with counters an=
notated
      powerpc/perf/hv-gpci: add the remaining gpci requests
      powerpc/perf/hv-24x7: Document sysfs event description entries

Colin Ian King (1):
      cxl: remove redundant increment of hwirq

Cyril Bur (1):
      powerpc/pseries: Fix endian problems with LE migration

Emil Medve (5):
      powerpc: Replace cpumask_weight(cpu_possible_mask) with num_possible_=
cpus()
      powerpc/dts: Remove T4240 emulator support
      powerpc: Remove duplicate tlbcam_index declarations
      dt/bindings: b/qman: Fix the alloc-ranges in the example(s)
      dt/bindings: b/qman: Add phandle to the portals

Esben Haabendal (1):
      powerpc: Add machine_check cpu function for e300c3 cpus

Gavin Shan (8):
      powerpc/kernel: Avoid memory corruption at early stage
      powerpc/eeh: Fix missed PE#0 on P7IOC
      powerpc/eeh: Introduce flag EEH_PE_REMOVED
      powerpc/eeh: Allow to set maximal frozen times
      powerpc/powernv: Remove pnv_pci_probe_mode()
      powerpc/powernv: Separate function for OPAL IRQ setup
      powerpc/powernv: Don't alloc IRQ map if necessary
      powerpc/kernel: Avoid initializing device-tree pointer twice

Geoff Levand (5):
      powerpc/ps3: Add empty repository highmem routines
      powerpc/ps3: Add ps3_mm_set_repository_highmem
      powerpc/ps3: Write highmem info to repository
      powerpc/ps3: Fix vuart sparse warnings
      powerpc/ps3: Fix sys-manager-core sparse warnings

Ian Munsie (8):
      cxl: Fix leaking interrupts if attach process fails
      cxl: Early return from cxl_handle_fault for a shut down context
      cxl: Disable AFU debug flag
      cxl: Disable SPAP register when freeing SPA
      cxl: Add tracepoints
      cxl: Export optional AFU configuration record in sysfs
      cxl: Fail AFU initialisation if an invalid configuration record is fo=
und
      cxl: Add missing return statement after handling AFU errror

Joel Stanley (1):
      powerpc/powernv: Add OPAL soft-poweroff routine

Kim Phillips (2):
      powerpc/mm: fix undefined reference to `.__kernel_map_pages' on FSL P=
PC64
      powerpc/fsl_pci: Fix pci stack build bug with FRAME_WARN

Kumar Gala (2):
      powerpc/mpc85xx: Create dts components for the FSL QorIQ DPAA BMan
      powerpc/mpc85xx: Create dts components for the FSL QorIQ DPAA QMan

LEROY Christophe (9):
      powerpc32: adds handling of _PAGE_RO
      powerpc/8xx: use _PAGE_RO instead of _PAGE_RW
      powerpc/8xx: reduce pressure on TLB due to context switches
      powerpc/8xx: remove remaining unnecessary code in FixupDAR
      powerpc/8xx: remove tests on PGDIR entry validity
      powerpc32: Use kmem_cache memory for PGDIR
      powerpc/8xx: Take benefit of aligned PGDIR
      powerpc/8xx: Optimise access to swapper_pg_dir
      powerpc/8xx: Remove duplicated code in set_context()

Markus Elfring (1):
      PowerPC-83xx: Deletion of an unnecessary check before the function ca=
ll "of_node_put"

Michael Ellerman (13):
      powerpc/kvm: Create proper names for the kvm_host_state PMU fields
      powerpc: Update all configs using savedefconfig
      powerpc: Update G5 defconfig
      powerpc/ps3: Enable CONFIG_PS3_REPOSITORY_WRITE in ps3_defconfig
      powerpc: Remove unused CPU_FTR_IABR
      powerpc: Rename _TIF_SYSCALL_T_OR_A to _TIF_SYSCALL_DOTRACE
      powerpc/lib: Makefile, consolidate obj-y sections
      powerpc/lib: Makefile, use obj64-y to consolidate 64-bit rules
      powerpc: Remove some unused functions
      powerpc/powernv: Remove "opal" prefix from pr_xxx()s
      powerpc/kernel: Make syscall_exit a local label
      powerpc: Remove old compile time disabled syscall tracing code
      Merge branch 'next' of git://git.kernel.org/.../scottwood/linux into =
next

Michael Neuling (1):
      powerpc: Enable NUMA balancing in pseries[_le]_defconfig

Naveen N. Rao (1):
      powerpc/kprobes: Fix kallsyms lookup across powerpc ABIv1 and ABIv2

Paul Bolle (1):
      powerpc/44x/Akebono: Remove select of IBM_EMAC_RGMII_WOL

Paul Mackerras (1):
      selftests/powerpc: Add subpage protection self test.

Philippe Bergheaud (1):
      cxl: Update CXL ABI documentation

Pranith Kumar (1):
      powerpc/powernv: Skip registering log region when CONFIG_PRINTK=3Dn

Rickard Strandqvist (1):
      powerpc/qe: Use strlcpy()

Ryan Grimm (5):
      cxl: Use image state defaults for reloading FPGA
      cxl: Add image control to sysfs
      cxl: Enable CAPP recovery
      cxl: Add ability to reset the card
      cxl: Fix device_node reference counting

Scott Wood (2):
      powerpc/mpc85xx: Add ranges to etsec2 nodes
      memory/fsl-corenet-cf: Add t1040 support

Shaohui Xie (1):
      power/fsl: add MDIO dt binding for FMan

Thadeu Lima de Souza Cascardo (1):
      powernv/iommu: disable IOMMU bypass with param iommu=3Dnobypass

Tom Huynh (1):
      powerpc/perf: fix fsl_emb_pmu_start to write correct pmc value

Vincent Bernat (1):
      powerpc/xmon: use isspace/isxdigit/isalnum from linux/ctype.h

Wei Yang (2):
      powerpc/powernv: Print the M64 range information in bootup log
      powerpc/pci: remove the multi-init for pci_dn->phb

Wei Yongjun (1):
      powerpc/4xx: Fix return value check in hsta_msi_probe()

sukadev@linux.vnet.ibm.com (1):
      perf: define EVENT_DEFINE_RANGE_FORMAT_LITE helper

 .../testing/sysfs-bus-event_source-devices-hv_24x7 |  22 +
 Documentation/ABI/testing/sysfs-class-cxl          |  67 +-
 .../devicetree/bindings/powerpc/fsl/fman.txt       |  70 ++
 Documentation/devicetree/bindings/soc/fsl/bman.txt |  12 +-
 Documentation/devicetree/bindings/soc/fsl/qman.txt |  14 +-
 Documentation/kernel-parameters.txt                |   2 +
 arch/powerpc/Kconfig                               |   1 +
 arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi        |   1 +
 arch/powerpc/boot/dts/fsl/pq3-etsec2-1.dtsi        |   1 +
 arch/powerpc/boot/dts/fsl/pq3-etsec2-2.dtsi        |   1 +
 arch/powerpc/boot/dts/fsl/pq3-gpio-0.dtsi          |   6 +-
 arch/powerpc/boot/dts/fsl/qoriq-bman1-portals.dtsi |  90 +++
 arch/powerpc/boot/dts/fsl/qoriq-bman1.dtsi         |  41 ++
 arch/powerpc/boot/dts/fsl/qoriq-qman1-portals.dtsi | 101 +++
 arch/powerpc/boot/dts/fsl/qoriq-qman1.dtsi         |  41 ++
 arch/powerpc/boot/dts/fsl/qoriq-qman3.dtsi         |  41 ++
 arch/powerpc/boot/dts/mvme2500.dts                 | 280 ++++++++
 arch/powerpc/boot/dts/t4240emu.dts                 | 281 --------
 arch/powerpc/configs/40x/acadia_defconfig          |  21 +-
 arch/powerpc/configs/40x/ep405_defconfig           |  18 +-
 arch/powerpc/configs/40x/kilauea_defconfig         |  27 +-
 arch/powerpc/configs/40x/klondike_defconfig        |   4 -
 arch/powerpc/configs/40x/makalu_defconfig          |  20 +-
 arch/powerpc/configs/40x/obs600_defconfig          |  13 +-
 arch/powerpc/configs/40x/virtex_defconfig          |  21 +-
 arch/powerpc/configs/40x/walnut_defconfig          |  18 +-
 arch/powerpc/configs/44x/akebono_defconfig         |   7 -
 arch/powerpc/configs/44x/arches_defconfig          |  23 +-
 arch/powerpc/configs/44x/bamboo_defconfig          |  15 +-
 arch/powerpc/configs/44x/bluestone_defconfig       |  16 +-
 arch/powerpc/configs/44x/canyonlands_defconfig     |  26 +-
 arch/powerpc/configs/44x/currituck_defconfig       |  13 +-
 arch/powerpc/configs/44x/ebony_defconfig           |  17 +-
 arch/powerpc/configs/44x/eiger_defconfig           |  26 +-
 arch/powerpc/configs/44x/icon_defconfig            |  20 -
 arch/powerpc/configs/44x/iss476-smp_defconfig      |  16 +-
 arch/powerpc/configs/44x/katmai_defconfig          |  15 -
 arch/powerpc/configs/44x/rainier_defconfig         |  15 +-
 arch/powerpc/configs/44x/redwood_defconfig         |  26 +-
 arch/powerpc/configs/44x/sam440ep_defconfig        |  19 +-
 arch/powerpc/configs/44x/sequoia_defconfig         |  21 +-
 arch/powerpc/configs/44x/taishan_defconfig         |  16 +-
 arch/powerpc/configs/44x/virtex5_defconfig         |  21 +-
 arch/powerpc/configs/44x/warp_defconfig            |  23 +-
 arch/powerpc/configs/52xx/cm5200_defconfig         |  19 +-
 arch/powerpc/configs/52xx/lite5200b_defconfig      |  20 +-
 arch/powerpc/configs/52xx/motionpro_defconfig      |  22 +-
 arch/powerpc/configs/52xx/pcm030_defconfig         |  21 +-
 arch/powerpc/configs/52xx/tqm5200_defconfig        |  22 +-
 arch/powerpc/configs/83xx/asp8347_defconfig        |  22 +-
 arch/powerpc/configs/83xx/kmeter1_defconfig        |   4 -
 arch/powerpc/configs/83xx/mpc8313_rdb_defconfig    |  25 +-
 arch/powerpc/configs/83xx/mpc8315_rdb_defconfig    |  22 +-
 arch/powerpc/configs/83xx/mpc832x_mds_defconfig    |  21 +-
 arch/powerpc/configs/83xx/mpc832x_rdb_defconfig    |  23 +-
 arch/powerpc/configs/83xx/mpc834x_itx_defconfig    |  20 +-
 arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig  |  20 +-
 arch/powerpc/configs/83xx/mpc834x_mds_defconfig    |  23 +-
 arch/powerpc/configs/83xx/mpc836x_mds_defconfig    |  22 +-
 arch/powerpc/configs/83xx/mpc836x_rdk_defconfig    |  16 +-
 arch/powerpc/configs/83xx/mpc837x_mds_defconfig    |  15 +-
 arch/powerpc/configs/83xx/mpc837x_rdb_defconfig    |  17 +-
 arch/powerpc/configs/83xx/sbc834x_defconfig        |  16 +-
 arch/powerpc/configs/85xx/ge_imp3a_defconfig       |  16 +-
 arch/powerpc/configs/85xx/kmp204x_defconfig        |   3 -
 arch/powerpc/configs/85xx/ksi8560_defconfig        |  17 +-
 arch/powerpc/configs/85xx/mpc8540_ads_defconfig    |  19 +-
 arch/powerpc/configs/85xx/mpc8560_ads_defconfig    |  19 +-
 arch/powerpc/configs/85xx/mpc85xx_cds_defconfig    |  21 +-
 arch/powerpc/configs/85xx/ppa8548_defconfig        |  62 +-
 arch/powerpc/configs/85xx/sbc8548_defconfig        |  40 +-
 arch/powerpc/configs/85xx/socrates_defconfig       |  24 +-
 arch/powerpc/configs/85xx/stx_gp3_defconfig        |  15 +-
 arch/powerpc/configs/85xx/tqm8540_defconfig        |  17 +-
 arch/powerpc/configs/85xx/tqm8541_defconfig        |  17 +-
 arch/powerpc/configs/85xx/tqm8548_defconfig        |  22 +-
 arch/powerpc/configs/85xx/tqm8555_defconfig        |  17 +-
 arch/powerpc/configs/85xx/tqm8560_defconfig        |  17 +-
 arch/powerpc/configs/85xx/xes_mpc85xx_defconfig    |  34 +-
 arch/powerpc/configs/86xx/gef_ppc9a_defconfig      |  36 +-
 arch/powerpc/configs/86xx/gef_sbc310_defconfig     |  35 +-
 arch/powerpc/configs/86xx/gef_sbc610_defconfig     |  53 +-
 arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig   |  32 +-
 arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig   |  33 +-
 arch/powerpc/configs/86xx/sbc8641d_defconfig       |  54 +-
 arch/powerpc/configs/adder875_defconfig            |  27 +-
 arch/powerpc/configs/amigaone_defconfig            |  36 +-
 arch/powerpc/configs/c2k_defconfig                 |  82 +--
 arch/powerpc/configs/cell_defconfig                |  30 +-
 arch/powerpc/configs/celleb_defconfig              |  21 +-
 arch/powerpc/configs/chrp32_defconfig              |  37 +-
 arch/powerpc/configs/corenet32_smp_defconfig       |  21 +-
 arch/powerpc/configs/corenet64_smp_defconfig       |   6 +-
 arch/powerpc/configs/ep8248e_defconfig             |  17 +-
 arch/powerpc/configs/ep88xc_defconfig              |  29 +-
 arch/powerpc/configs/g5_defconfig                  |  63 +-
 arch/powerpc/configs/gamecube_defconfig            |  15 +-
 arch/powerpc/configs/holly_defconfig               |  15 +-
 arch/powerpc/configs/linkstation_defconfig         |  28 +-
 arch/powerpc/configs/maple_defconfig               |  26 +-
 arch/powerpc/configs/mgcoge_defconfig              |  12 +-
 arch/powerpc/configs/mpc512x_defconfig             |   2 -
 arch/powerpc/configs/mpc5200_defconfig             |  18 +-
 arch/powerpc/configs/mpc7448_hpc2_defconfig        |  18 +-
 arch/powerpc/configs/mpc8272_ads_defconfig         |  24 +-
 arch/powerpc/configs/mpc83xx_defconfig             |   7 -
 arch/powerpc/configs/mpc85xx_defconfig             |  72 +-
 arch/powerpc/configs/mpc85xx_smp_defconfig         |  63 +-
 arch/powerpc/configs/mpc866_ads_defconfig          |  22 +-
 arch/powerpc/configs/mpc86xx_defconfig             |  39 +-
 arch/powerpc/configs/mpc885_ads_defconfig          |  29 +-
 arch/powerpc/configs/mvme5100_defconfig            |   9 -
 arch/powerpc/configs/pasemi_defconfig              |   3 -
 arch/powerpc/configs/pmac32_defconfig              |  65 +-
 arch/powerpc/configs/ppc40x_defconfig              |  17 +-
 arch/powerpc/configs/ppc44x_defconfig              |  14 -
 arch/powerpc/configs/ppc64_defconfig               |  16 +-
 arch/powerpc/configs/ppc64e_defconfig              |   4 -
 arch/powerpc/configs/ppc6xx_defconfig              | 348 ++++-----
 arch/powerpc/configs/pq2fads_defconfig             |  28 +-
 arch/powerpc/configs/ps3_defconfig                 |  18 +-
 arch/powerpc/configs/pseries_defconfig             |  29 +-
 arch/powerpc/configs/pseries_le_defconfig          |  31 +-
 arch/powerpc/configs/storcenter_defconfig          |  12 +-
 arch/powerpc/configs/tqm8xx_defconfig              |  32 +-
 arch/powerpc/configs/wii_defconfig                 |  18 +-
 arch/powerpc/include/asm/cputable.h                |   2 +-
 arch/powerpc/include/asm/eeh.h                     |  13 +-
 arch/powerpc/include/asm/kprobes.h                 |  63 +-
 arch/powerpc/include/asm/opal.h                    |  10 +-
 arch/powerpc/include/asm/pci-bridge.h              |   4 +
 arch/powerpc/include/asm/pgtable-ppc32.h           |  23 +-
 arch/powerpc/include/asm/pgtable.h                 |   7 +-
 arch/powerpc/include/asm/pnv-pci.h                 |   4 +-
 arch/powerpc/include/asm/pte-8xx.h                 |   9 +-
 arch/powerpc/include/asm/pte-common.h              |  25 +-
 arch/powerpc/include/asm/rtas.h                    |   2 +-
 arch/powerpc/include/asm/smp.h                     |   1 -
 arch/powerpc/include/asm/thread_info.h             |   2 +-
 arch/powerpc/kernel/asm-offsets.c                  |  15 +-
 arch/powerpc/kernel/cputable.c                     |   1 +
 arch/powerpc/kernel/eeh.c                          |  24 +
 arch/powerpc/kernel/eeh_driver.c                   |   4 +-
 arch/powerpc/kernel/eeh_pe.c                       |  20 +-
 arch/powerpc/kernel/entry_32.S                     |  83 +--
 arch/powerpc/kernel/entry_64.S                     |  37 +-
 arch/powerpc/kernel/head_8xx.S                     | 123 ++--
 arch/powerpc/kernel/paca.c                         |   8 +
 arch/powerpc/kernel/pci_dn.c                       |   4 +-
 arch/powerpc/kernel/prom.c                         |   3 -
 arch/powerpc/kernel/rtas.c                         |  22 +-
 arch/powerpc/kernel/smp.c                          |  14 -
 arch/powerpc/kernel/syscalls.c                     |  14 -
 arch/powerpc/kernel/traps.c                        |  15 -
 arch/powerpc/kvm/book3s_hv_interrupts.S            |  26 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S            |  28 +-
 arch/powerpc/lib/Makefile                          |  27 +-
 arch/powerpc/lib/memcmp_64.S                       | 233 ++++++
 arch/powerpc/lib/string.S                          |   2 +
 arch/powerpc/mm/fsl_booke_mmu.c                    |   2 -
 arch/powerpc/mm/mmu_context_nohash.c               |  43 +-
 arch/powerpc/mm/pgtable_32.c                       |  19 +-
 arch/powerpc/mm/slice.c                            |  29 -
 arch/powerpc/mm/tlb_nohash.c                       |   9 +-
 arch/powerpc/perf/core-fsl-emb.c                   |  10 +-
 arch/powerpc/perf/hv-24x7-catalog.h                |  25 +
 arch/powerpc/perf/hv-24x7-domains.h                |  28 +
 arch/powerpc/perf/hv-24x7.c                        | 793 +++++++++++++++++=
+++-
 arch/powerpc/perf/hv-24x7.h                        |  12 +-
 arch/powerpc/perf/hv-common.c                      |  10 +-
 arch/powerpc/perf/hv-common.h                      |  10 +
 arch/powerpc/perf/hv-gpci-requests.h               | 261 +++++++
 arch/powerpc/perf/hv-gpci.c                        |  23 +
 arch/powerpc/perf/hv-gpci.h                        |  37 +-
 arch/powerpc/perf/req-gen/_begin.h                 |  13 +
 arch/powerpc/perf/req-gen/_clear.h                 |   5 +
 arch/powerpc/perf/req-gen/_end.h                   |   4 +
 arch/powerpc/perf/req-gen/_request-begin.h         |  15 +
 arch/powerpc/perf/req-gen/_request-end.h           |   8 +
 arch/powerpc/perf/req-gen/perf.h                   | 155 ++++
 arch/powerpc/platforms/44x/Kconfig                 |   1 -
 arch/powerpc/platforms/83xx/usb.c                  |   3 +-
 arch/powerpc/platforms/85xx/Kconfig                |   6 +
 arch/powerpc/platforms/85xx/Makefile               |   1 +
 arch/powerpc/platforms/85xx/mvme2500.c             |  74 ++
 arch/powerpc/platforms/cell/smp.c                  |   2 +-
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c  |  11 -
 arch/powerpc/platforms/powernv/Makefile            |   2 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c       |  11 +
 arch/powerpc/platforms/powernv/opal-power.c        |  65 ++
 arch/powerpc/platforms/powernv/opal.c              |  72 +-
 arch/powerpc/platforms/powernv/pci-ioda.c          |  41 +-
 arch/powerpc/platforms/powernv/pci.c               |  30 -
 arch/powerpc/platforms/ps3/mm.c                    |  77 +-
 arch/powerpc/platforms/ps3/platform.h              |  13 +
 arch/powerpc/platforms/pseries/Kconfig             |  20 +-
 arch/powerpc/platforms/pseries/hotplug-cpu.c       |   2 +-
 arch/powerpc/platforms/pseries/mobility.c          |  22 +-
 arch/powerpc/platforms/pseries/ras.c               |   2 +
 arch/powerpc/sysdev/fsl_pci.c                      |  11 +-
 arch/powerpc/sysdev/indirect_pci.c                 |  25 +-
 arch/powerpc/sysdev/mpic.c                         |   2 +-
 arch/powerpc/sysdev/ppc4xx_hsta_msi.c              |   2 +-
 arch/powerpc/sysdev/qe_lib/qe.c                    |   6 +-
 arch/powerpc/sysdev/xics/xics-common.c             |   2 +-
 arch/powerpc/xmon/xmon.c                           |  14 +-
 drivers/memory/fsl-corenet-cf.c                    |  36 +-
 drivers/misc/cxl/Makefile                          |   5 +-
 drivers/misc/cxl/cxl.h                             |  22 +
 drivers/misc/cxl/fault.c                           |  11 +
 drivers/misc/cxl/file.c                            |   7 +-
 drivers/misc/cxl/irq.c                             |   7 +-
 drivers/misc/cxl/main.c                            |   2 +
 drivers/misc/cxl/native.c                          |  39 +-
 drivers/misc/cxl/pci.c                             | 123 +++-
 drivers/misc/cxl/sysfs.c                           | 236 +++++-
 drivers/misc/cxl/trace.c                           |  13 +
 drivers/misc/cxl/trace.h                           | 459 ++++++++++++
 drivers/ps3/ps3-vuart.c                            |   5 -
 drivers/ps3/sys-manager-core.c                     |   6 +-
 drivers/ps3/vuart.h                                |  16 +
 include/linux/perf_event.h                         |  10 +
 kernel/events/core.c                               |  12 +
 tools/testing/selftests/powerpc/Makefile           |   2 +-
 .../testing/selftests/powerpc/copyloops/.gitignore |   4 +
 tools/testing/selftests/powerpc/mm/.gitignore      |   3 +
 tools/testing/selftests/powerpc/mm/Makefile        |   9 +-
 tools/testing/selftests/powerpc/mm/subpage_prot.c  | 220 ++++++
 tools/testing/selftests/powerpc/pmu/.gitignore     |   3 +
 tools/testing/selftests/powerpc/pmu/ebb/.gitignore |  22 +
 .../selftests/powerpc/primitives/.gitignore        |   1 +
 .../selftests/powerpc/stringloops/.gitignore       |   1 +
 .../testing/selftests/powerpc/stringloops/Makefile |  20 +
 .../selftests/powerpc/stringloops/asm/ppc_asm.h    |   7 +
 .../testing/selftests/powerpc/stringloops/memcmp.c | 103 +++
 .../selftests/powerpc/stringloops/memcmp_64.S      |   1 +
 tools/testing/selftests/powerpc/tm/.gitignore      |   1 +
 237 files changed, 5084 insertions(+), 3143 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-bman1-portals.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-bman1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-qman1-portals.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-qman1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-qman3.dtsi
 create mode 100644 arch/powerpc/boot/dts/mvme2500.dts
 delete mode 100644 arch/powerpc/boot/dts/t4240emu.dts
 create mode 100644 arch/powerpc/lib/memcmp_64.S
 create mode 100644 arch/powerpc/perf/hv-24x7-domains.h
 create mode 100644 arch/powerpc/perf/hv-gpci-requests.h
 create mode 100644 arch/powerpc/perf/req-gen/_begin.h
 create mode 100644 arch/powerpc/perf/req-gen/_clear.h
 create mode 100644 arch/powerpc/perf/req-gen/_end.h
 create mode 100644 arch/powerpc/perf/req-gen/_request-begin.h
 create mode 100644 arch/powerpc/perf/req-gen/_request-end.h
 create mode 100644 arch/powerpc/perf/req-gen/perf.h
 create mode 100644 arch/powerpc/platforms/85xx/mvme2500.c
 create mode 100644 arch/powerpc/platforms/powernv/opal-power.c
 create mode 100644 drivers/misc/cxl/trace.c
 create mode 100644 drivers/misc/cxl/trace.h
 create mode 100644 tools/testing/selftests/powerpc/copyloops/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/mm/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/mm/subpage_prot.c
 create mode 100644 tools/testing/selftests/powerpc/pmu/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/primitives/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/stringloops/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/stringloops/Makefile
 create mode 100644 tools/testing/selftests/powerpc/stringloops/asm/ppc_asm=
.h
 create mode 100644 tools/testing/selftests/powerpc/stringloops/memcmp.c
 create mode 120000 tools/testing/selftests/powerpc/stringloops/memcmp_64.S
 create mode 100644 tools/testing/selftests/powerpc/tm/.gitignore



--=-cqLy/Pm/bIXOlWPJjzwK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABAgAGBQJU2/ToAAoJEFHr6jzI4aWAiMkP/23rw4k2KJw6v6HAXhUfrxho
w0+xnzbR5YWN/4oSV8Zcha2heADyVFoGdk6rDGw9ewmXFOO3LYKllua14G6KMu1/
qoIq+244Y9ei2NP9BaguaOt7vHaz2+YqooIa68gl7DP5EmJalQwKVtw1NgMGVRah
o6nclwOBjo0zv7FfLU8F1WXfuiZpx/ymDy0thzRdtOff2TFcP7CwF5ZkgI4LxxM/
/ODWoPOCtL2zzj9T6THkJXPfCuYi45ZRitl4mlAuaoCfJEr//wP+3u0fG97lziSY
imoODtBKuo2ep/ioxoPwA1VujUFX6Zl56MKqPncXIL0maMx6iK4xALZ0RvDPK1Uv
B0QPxenN7irvcoHiqjuSYRzRNPNu/Og8zSTr8bp1KZKceiEge4phUMrKBTvTyMQ7
NSo81VLlsliQl30jj2Oe7i//nZ3mWn3I6LPnci3pxTx+s2HE9Rq6QcKbE3+nov+q
V3yoXDB8GNbmk70HtM18SQs6IhJknNxK0enZVKciB0j+PtKs1Jx56/PE/zLKoC2B
DAOmML4AIMHAc4eq0O4c6s39yIHMbNvQeQo2Y/Z2YrzuZxSE1ITb/E0q3AU7cicR
4qYuxOqcPXoBVZKPGzOxx5h60gLC7yUQMDZKDSLJgOBjeVGQO0zgtFJbvbtFrRwp
IeHPm6177S4PFLxPlKvF
=vPAB
-----END PGP SIGNATURE-----

--=-cqLy/Pm/bIXOlWPJjzwK--
