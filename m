Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 310841A0D2A
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2015 17:40:41 +1100 (AEDT)
Message-ID: <1446792040.25265.10.camel@ellerman.id.au>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.4-1 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: B48286@freescale.com, Igal.Liberman@freescale.com, Sudeep.Holla@arm.com,
 aaro.koskinen@iki.fi, afleming@gmail.com, agust@denx.de,
 alex.popov@linux.com,  andrew.donnellan@au1.ibm.com,
 andriy.shevchenko@linux.intel.com,  aneesh.kumar@linux.vnet.ibm.com,
 boqun.feng@gmail.com,  chenhui.zhao@freescale.com,
 christophe.jaillet@wanadoo.fr,  christophe.leroy@c-s.fr,
 colin.king@canonical.com, geoff@infradead.org,  gwshan@linux.vnet.ibm.com,
 haokexin@gmail.com, himangi774@gmail.com,  hongtao.jia@freescale.com,
 julia.lawall@lip6.fr, kda@linux-powerpc.org,  khandual@linux.vnet.ibm.com,
 linus.walleij@linaro.org,  linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,  luis@debethencourt.com, mikey@neuling.org,
 mmarek@suse.com,  nfont@linux.vnet.ibm.com, paul.gortmaker@windriver.com,
 poonam.aggrwal@freescale.com, qiang.zhao@freescale.com,
 rudhresh.jk@gmail.com,  sam.bobroff@au1.ibm.com, sam.mj@au1.ibm.com,
 sboyd@codeaurora.org,  scottwood@freescale.com, sfr@canb.auug.org.au,
 tiejun.chen@windriver.com,  u.kleine-koenig@pengutronix.de,
 yangbo.lu@freescale.com
Date: Fri, 06 Nov 2015 17:40:40 +1100
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-qgjJE1OYEwzx7sdYurUt"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-qgjJE1OYEwzx7sdYurUt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull powerpc updates for 4.4:

The following changes since commit 9ffecb10283508260936b96022d4ee43a7798b4c=
:

  Linux 4.3-rc3 (2015-09-27 07:50:08 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powe=
rpc-4.4-1

for you to fetch changes up to 8bdf2023e238ce2262d0cf1aca78785dc46e15db:

  Merge branch 'next' of git://git.denx.de/linux-denx-agust into next (2015=
-11-05 19:35:12 +1100)

----------------------------------------------------------------
powerpc updates for 4.4

 - Kconfig: remove BE-only platforms from LE kernel build from Boqun Feng
 - Refresh ps3_defconfig from Geoff Levand
 - Emit GNU & SysV hashes for the vdso from Michael Ellerman
 - Define an enum for the bolted SLB indexes from Anshuman Khandual
 - Use a local to avoid multiple calls to get_slb_shadow() from Michael Ell=
erman
 - Add gettimeofday() benchmark from Michael Neuling
 - Avoid link stack corruption in __get_datapage() from Michael Neuling
 - Add virt_to_pfn and use this instead of opencoding from Aneesh Kumar K.V
 - Add ppc64le_defconfig from Michael Ellerman
 - pseries: extract of_helpers module from Andy Shevchenko
 - Correct string length in pseries_of_derive_parent() from Nathan Fontenot
 - Free the MSI bitmap if it was slab allocated from Denis Kirjanov
 - Shorten irq_chip name for the SIU from Christophe Leroy
 - Wait 1s for secondaries to enter OPAL during kexec from Samuel Mendoza-J=
onas
 - Fix _ALIGN_* errors due to type difference. from Aneesh Kumar K.V
 - powerpc/pseries/hvcserver: don't memset pi_buff if it is null from Colin=
 Ian King
 - Disable hugepd for 64K page size. from Aneesh Kumar K.V
 - Differentiate between hugetlb and THP during page walk from Aneesh Kumar=
 K.V
 - Make PCI non-optional for pseries from Michael Ellerman
 - Individual System V IPC system calls from Sam bobroff
 - Add selftest of unmuxed IPC calls from Michael Ellerman
 - discard .exit.data at runtime from Stephen Rothwell
 - Delete old orphaned PrPMC 280/2800 DTS and boot file. from Paul Gortmake=
r
 - Use of_get_next_parent to simplify code from Christophe Jaillet
 - Paginate some xmon output from Sam bobroff
 - Add some more elements to the xmon PACA dump from Michael Ellerman
 - Allow the tm-syscall selftest to build with old headers from Michael Ell=
erman
 - Run EBB selftests only on POWER8 from Denis Kirjanov
 - Drop CONFIG_TUNE_CELL in favour of CONFIG_CELL_CPU from Michael Ellerman
 - Avoid reference to potentially freed memory in prom.c from Christophe Ja=
illet
 - Quieten boot wrapper output with run_cmd from Geoff Levand
 - EEH fixes and cleanups from Gavin Shan
 - Fix recursive fenced PHB on Broadcom shiner adapter from Gavin Shan
 - Use of_get_next_parent() in of_get_ibm_chip_id() from Michael Ellerman
 - Fix section mismatch warning in msi_bitmap_alloc() from Denis Kirjanov
 - Fix ps3-lpm white space from Rudhresh Kumar J
 - Fix ps3-vuart null dereference from Colin King
 - nvram: Add missing kfree in error path from Christophe Jaillet
 - nvram: Fix function name in some errors messages. from Christophe Jaille=
t
 - drivers/macintosh: adb: fix misleading Kconfig help text from Aaro Koski=
nen
 - agp/uninorth: fix a memleak in create_gatt_table from Denis Kirjanov
 - cxl: Free virtual PHB when removing from Andrew Donnellan
 - scripts/kconfig/Makefile: Allow KBUILD_DEFCONFIG to be a target from Mic=
hael Ellerman
 - scripts/kconfig/Makefile: Fix KBUILD_DEFCONFIG check when building with =
O=3D from Michael Ellerman

 - Freescale updates from Scott: Highlights include 64-bit book3e kexec/kdu=
mp
   support, a rework of the qoriq clock driver, device tree changes includi=
ng
   qoriq fman nodes, support for a new 85xx board, and some fixes.

 - MPC5xxx updates from Anatolij: Highlights include a driver for MPC512x
   LocalPlus Bus FIFO with its device tree binding documentation, mpc512x
   device tree updates and some minor fixes.

----------------------------------------------------------------
Aaro Koskinen (1):
      drivers/macintosh: adb: fix misleading Kconfig help text

Alexander Popov (2):
      powerpc/512x: add LocalPlus Bus FIFO device driver
      powerpc/512x: add a device tree binding for LocalPlus Bus FIFO

Andrew Donnellan (2):
      powerpc/pci: export pcibios_free_controller()
      cxl: Free virtual PHB when removing

Andy Fleming (1):
      powerpc/85xx: Add support for Varisys Cyrus board

Andy Shevchenko (5):
      powerpc/pseries: extract of_helpers module
      powerpc/pseries: fix a potential memory leak
      powerpc/pseries: replace kmalloc + strlcpy
      powerpc/pseries: handle nodes without '/'
      powerpc/pseries: re-use code from of_helpers module

Aneesh Kumar K.V (4):
      powerpc/mm: Add virt_to_pfn and use this instead of opencoding
      powerpc: Fix _ALIGN_* errors due to type difference.
      powerpc/mm: Disable hugepd for 64K page size.
      powerpc/mm: Differentiate between hugetlb and THP during page walk

Anshuman Khandual (1):
      powerpc/slb: Define an enum for the bolted indexes

Boqun Feng (1):
      powerpc: Kconfig: remove BE-only platforms from LE kernel build

Christophe Jaillet (5):
      powerpc/nvram: Add missing kfree in error path
      powerpc/nvram: Fix function name in some errors messages.
      powerpc/numa: Use of_get_next_parent to simplify code
      powerpc/mpc5xxx: Use of_get_next_parent to simplify code
      powerpc/prom: Avoid reference to potentially freed memory

Christophe Leroy (2):
      powerpc/8xx: Shorten irq_chip name for the SIU
      powerpc: handle error case in cpm_muram_alloc()

Colin Ian King (1):
      powerpc/pseries/hvcserver: don't memset pi_buff if it is null

Colin King (1):
      drivers/ps3: Fix ps3-vuart null dereference

Denis Kirjanov (4):
      agp/uninorth: fix a memleak in create_gatt_table
      powerpc/msi: Free the bitmap if it was slab allocated
      selftests/powerpc: Run EBB tests only on POWER8
      powerpc/msi: Fix section mismatch warning in msi_bitmap_alloc()

Gavin Shan (10):
      powerpc/eeh: atomic_dec_if_positive() to update passthru count
      powerpc/eeh: Don't unfreeze PHB PE after reset
      powerpc/eeh: More relaxed hotplug criterion
      powerpc/eeh: Force reset on fenced PHB
      powerpc/eeh: More relaxed condition for enabled IO path
      powerpc/pseries: Cleanup on pseries_eeh_get_state()
      powerpc/powernv: Cleanup on EEH comments
      powerpc/powernv: Remove pnv_eeh_cap_start()
      powerpc/powernv: Simplify pnv_eeh_set_option()
      powerpc/eeh: Fix recursive fenced PHB on Broadcom shiner adapter

Geoff Levand (2):
      powerpc/ps3: Refresh ps3_defconfig
      powerpc/ps3: Quieten boot wrapper output with run_cmd

Himangi Saraogi (1):
      powerpc: Introduce the use of the managed version of kzalloc

Hongtao Jia (1):
      powerpc/fsl: Move Freescale device tree files into fsl folder

Hou Zhiqiang (1):
      clk: qoriq: Add ls1043a support.

Igal Liberman (2):
      powerpc/mpc85xx: Create dts components for the FSL QorIQ DPAA FMan
      powerpc/mpc85xx: Add FSL QorIQ DPAA FMan support to the SoC device tr=
ee(s)

Kevin Hao (1):
      powerpc/e6500: hw tablewalk: make sure we invalidate and write to the=
 same tlb entry

Luis de Bethencourt (1):
      powerpc: platforms: mpc52xx_lpbfifo: Fix module autoload for OF platf=
orm driver

Michael Ellerman (17):
      powerpc/vdso: Emit GNU & SysV hashes
      powerpc/slb: Use a local to avoid multiple calls to get_slb_shadow()
      scripts/kconfig/Makefile: Allow KBUILD_DEFCONFIG to be a target
      powerpc: Add ppc64le_defconfig
      scripts/kconfig/Makefile: Fix KBUILD_DEFCONFIG check when building wi=
th O=3D
      powerpc/pseries: Make PCI non-optional
      powerpc/pseries: Remove use of CONFIG_PCI
      powerpc/pseries: Move PCI objects to obj-y
      powerpc/pseries: Drop always true CONFIG_PSERIES_MSI
      powerpc/xmon: Add some more elements to the existing PACA dump list
      selftests/powerpc: Add tests of unmuxed IPC calls
      selftests/powerpc: Sort the list of SUB_DIRS to build
      selftests/powerpc: Allow the tm-syscall test to build with old header=
s
      powerpc/cell: Drop CONFIG_TUNE_CELL in favour of CONFIG_CELL_CPU
      powerpc/prom: Use of_get_next_parent() in of_get_ibm_chip_id()
      Merge branch 'next' of git://git.kernel.org/.../scottwood/linux into =
next
      Merge branch 'next' of git://git.denx.de/linux-denx-agust into next

Michael Neuling (2):
      powerpc/selftest: Add gettimeofday() benchmark
      powerpc/vdso: Avoid link stack corruption in __get_datapage()

Nathan Fontenot (1):
      powerpc/pseries: Correct string length in pseries_of_derive_parent()

Paul Gortmaker (1):
      powerpc: Delete old orphaned PrPMC 280/2800 DTS and boot file.

Rudhresh Kumar J (1):
      drivers/ps3: Fix ps3-lpm white space

Sam bobroff (3):
      powerpc: Individual System V IPC system calls
      powerpc/xmon: Paged output for paca display
      powerpc/xmon: Paginate kernel log buffer display

Samuel Mendoza-Jonas (1):
      powerpc/kexec: Wait 1s for secondaries to enter OPAL

Scott Wood (19):
      powerpc/fsl_pci: Check for get_user/probe_kernel_address failure
      powerpc/fsl-booke-64: Allow booting from the secondary thread
      powerpc/fsl-corenet: Disable coreint if kexec is enabled
      powerpc/85xx: Don't use generic timebase sync on 64-bit
      powerpc/fsl_pci: Don't set up inbound windows in kdump crash kernel
      powerpc/fsl: Move fsl_guts.h out of arch/powerpc
      clk: qoriq: Move chip-specific knowledge into driver
      clk: qoriq: Add ls2080a support.
      powerpc/85xx: Load all early TLB entries at once
      clk: qoriq: Fix wrong data in p2041_cmux_grp2
      powerpc/fsl-booke-64: Don't limit ppc64_rma_size to one TLB entry
      powerpc/e6500: kexec: Handle hardware threads
      powerpc/book3e/kdump: Enable crash_kexec_wait_realmode
      powerpc/book3e-64: Don't limit paca to 256 MiB
      powerpc/book3e-64/kexec: Enable SMP release
      powerpc/booke: Only use VIRT_PHYS_OFFSET on booke32
      powerpc/book3e-64/kexec: Set "r4 =3D 0" when entering spinloop
      Merge branch 'clock' into HEAD
      powerpc/fsl: Add #clock-cells and clockgen label to clockgen nodes

Stephen Rothwell (1):
      powerpc: discard .exit.data at runtime

Sudeep Holla (1):
      powerpc: mpic: use IRQCHIP_SKIP_SET_WAKE instead of redundant mpic_ir=
q_set_wake

Tiejun Chen (6):
      powerpc/85xx: Implement 64-bit kexec support
      powerpc/book3e-64: rename interrupt_end_book3e with __end_interrupts
      powerpc/booke64: Fix args to copy_and_flush
      powerpc/book3e: support CONFIG_RELOCATABLE
      powerpc/book3e-64/kexec: create an identity TLB mapping
      powerpc/book3e-64: Enable kexec

Uwe Kleine-K=C3=B6nig (2):
      powerpc/dts: don't fall back to fsl,pq3-gpio for fsl,mpc8572-gpio
      powerpc: mpc512x: drop bogus and unused psc register bit definitions

Yangbo Lu (1):
      powerpc/dts: Add and fix 1588 timer node for eTSEC

Zhao Qiang (1):
      powerpc/t104xd4rdb: add DS26522 nodes to device tree

chenhui zhao (1):
      powerpc/corenet: use the mixed mode of MPIC when enabling CPU hotplug

poonam aggrwal (2):
      powerpc/b4860: Removed LIODN register from sRIO node
      powerpc/b4860: Renamed the L2 caches

 Documentation/devicetree/bindings/chosen.txt       |    8 +
 .../devicetree/bindings/clock/qoriq-clock.txt      |   61 +-
 .../devicetree/bindings/net/maxim,ds26522.txt      |   13 +
 .../bindings/powerpc/fsl/mpc512x_lpbfifo.txt       |   21 +
 arch/powerpc/Kconfig                               |    2 +-
 arch/powerpc/Makefile                              |    6 +-
 arch/powerpc/boot/Makefile                         |    3 +
 arch/powerpc/boot/dts/{ =3D> fsl}/b4420qds.dts       |    4 +-
 arch/powerpc/boot/dts/fsl/b4420si-post.dtsi        |    4 +-
 arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi         |   13 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/b4860qds.dts       |    4 +-
 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi        |   26 +-
 arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi         |   20 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/b4qds.dtsi         |    2 +-
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi           |   33 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/bsc9131rdb.dts     |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/bsc9131rdb.dtsi    |   12 +
 arch/powerpc/boot/dts/{ =3D> fsl}/bsc9132qds.dts     |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/bsc9132qds.dtsi    |   12 +
 arch/powerpc/boot/dts/{ =3D> fsl}/c293pcie.dts       |    4 +-
 arch/powerpc/boot/dts/fsl/cyrus_p5020.dts          |  155 +++
 arch/powerpc/boot/dts/{ =3D> fsl}/ge_imp3a.dts       |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/kmcoge4.dts        |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/mpc8536ds.dts      |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/mpc8536ds.dtsi     |    0
 arch/powerpc/boot/dts/{ =3D> fsl}/mpc8536ds_36b.dts  |    4 +-
 arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi      |    2 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/mpc8540ads.dts     |    2 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/mpc8541cds.dts     |    2 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/mpc8544ds.dts      |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/mpc8544ds.dtsi     |    0
 arch/powerpc/boot/dts/{ =3D> fsl}/mpc8548cds.dtsi    |    0
 arch/powerpc/boot/dts/{ =3D> fsl}/mpc8548cds_32b.dts |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/mpc8548cds_36b.dts |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/mpc8555cds.dts     |    2 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/mpc8560ads.dts     |    2 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/mpc8568mds.dts     |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/mpc8569mds.dts     |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/mpc8572ds.dts      |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/mpc8572ds.dtsi     |    0
 arch/powerpc/boot/dts/{ =3D> fsl}/mpc8572ds_36b.dts  |    4 +-
 .../boot/dts/{ =3D> fsl}/mpc8572ds_camp_core0.dts    |    0
 .../boot/dts/{ =3D> fsl}/mpc8572ds_camp_core1.dts    |    0
 arch/powerpc/boot/dts/fsl/mpc8572si-post.dtsi      |    2 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/mvme2500.dts       |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/oca4080.dts        |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/p1010rdb-pa.dts    |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/p1010rdb-pa.dtsi   |    0
 .../powerpc/boot/dts/{ =3D> fsl}/p1010rdb-pa_36b.dts |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/p1010rdb-pb.dts    |    4 +-
 .../powerpc/boot/dts/{ =3D> fsl}/p1010rdb-pb_36b.dts |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/p1010rdb.dtsi      |   12 +
 arch/powerpc/boot/dts/{ =3D> fsl}/p1010rdb_32b.dtsi  |    0
 arch/powerpc/boot/dts/{ =3D> fsl}/p1010rdb_36b.dtsi  |    0
 arch/powerpc/boot/dts/{ =3D> fsl}/p1020mbg-pc.dtsi   |    0
 .../powerpc/boot/dts/{ =3D> fsl}/p1020mbg-pc_32b.dts |    4 +-
 .../powerpc/boot/dts/{ =3D> fsl}/p1020mbg-pc_36b.dts |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/p1020rdb-pc.dtsi   |    0
 .../powerpc/boot/dts/{ =3D> fsl}/p1020rdb-pc_32b.dts |    4 +-
 .../powerpc/boot/dts/{ =3D> fsl}/p1020rdb-pc_36b.dts |    4 +-
 .../boot/dts/{ =3D> fsl}/p1020rdb-pc_camp_core0.dts  |    0
 .../boot/dts/{ =3D> fsl}/p1020rdb-pc_camp_core1.dts  |    0
 arch/powerpc/boot/dts/{ =3D> fsl}/p1020rdb-pd.dts    |   16 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/p1020rdb.dts       |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/p1020rdb.dtsi      |    0
 arch/powerpc/boot/dts/{ =3D> fsl}/p1020rdb_36b.dts   |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/p1020utm-pc.dtsi   |    0
 .../powerpc/boot/dts/{ =3D> fsl}/p1020utm-pc_32b.dts |    4 +-
 .../powerpc/boot/dts/{ =3D> fsl}/p1020utm-pc_36b.dts |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/p1021mds.dts       |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/p1021rdb-pc.dtsi   |   12 +
 .../powerpc/boot/dts/{ =3D> fsl}/p1021rdb-pc_32b.dts |    4 +-
 .../powerpc/boot/dts/{ =3D> fsl}/p1021rdb-pc_36b.dts |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/p1022ds.dtsi       |   12 +
 arch/powerpc/boot/dts/{ =3D> fsl}/p1022ds_32b.dts    |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/p1022ds_36b.dts    |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/p1022rdk.dts       |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/p1023rdb.dts       |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/p1024rdb.dtsi      |    0
 arch/powerpc/boot/dts/{ =3D> fsl}/p1024rdb_32b.dts   |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/p1024rdb_36b.dts   |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/p1025rdb.dtsi      |    0
 arch/powerpc/boot/dts/{ =3D> fsl}/p1025rdb_32b.dts   |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/p1025rdb_36b.dts   |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/p1025twr.dts       |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/p1025twr.dtsi      |   12 +
 arch/powerpc/boot/dts/{ =3D> fsl}/p2020ds.dts        |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/p2020ds.dtsi       |    0
 arch/powerpc/boot/dts/{ =3D> fsl}/p2020rdb-pc.dtsi   |   12 +-
 .../powerpc/boot/dts/{ =3D> fsl}/p2020rdb-pc_32b.dts |    4 +-
 .../powerpc/boot/dts/{ =3D> fsl}/p2020rdb-pc_36b.dts |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/p2020rdb.dts       |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/p2041rdb.dts       |    4 +-
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi        |   29 +-
 arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi         |   10 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/p3041ds.dts        |    4 +-
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi        |   29 +-
 arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi         |   10 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/p4080ds.dts        |    4 +-
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi        |   48 +-
 arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi         |   15 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/p5020ds.dts        |    4 +-
 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi        |   29 +-
 arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi         |   10 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/p5040ds.dts        |    4 +-
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi        |   56 +-
 arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi         |   17 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/ppa8548.dts        |    4 +-
 arch/powerpc/boot/dts/fsl/qoriq-clockgen1.dtsi     |    3 +-
 arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi     |    3 +-
 arch/powerpc/boot/dts/fsl/qoriq-fman-0-10g-0.dtsi  |   62 +
 arch/powerpc/boot/dts/fsl/qoriq-fman-0-1g-0.dtsi   |   69 +
 arch/powerpc/boot/dts/fsl/qoriq-fman-0-1g-1.dtsi   |   68 +
 arch/powerpc/boot/dts/fsl/qoriq-fman-0-1g-2.dtsi   |   68 +
 arch/powerpc/boot/dts/fsl/qoriq-fman-0-1g-3.dtsi   |   68 +
 arch/powerpc/boot/dts/fsl/qoriq-fman-0-1g-4.dtsi   |   68 +
 arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi        |  101 ++
 arch/powerpc/boot/dts/fsl/qoriq-fman-1-10g-0.dtsi  |   61 +
 arch/powerpc/boot/dts/fsl/qoriq-fman-1-1g-0.dtsi   |   68 +
 arch/powerpc/boot/dts/fsl/qoriq-fman-1-1g-1.dtsi   |   68 +
 arch/powerpc/boot/dts/fsl/qoriq-fman-1-1g-2.dtsi   |   68 +
 arch/powerpc/boot/dts/fsl/qoriq-fman-1-1g-3.dtsi   |   68 +
 arch/powerpc/boot/dts/fsl/qoriq-fman-1-1g-4.dtsi   |   68 +
 arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi        |  101 ++
 .../dts/fsl/qoriq-fman3-0-10g-0-best-effort.dtsi   |   66 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-0.dtsi |   63 +
 .../dts/fsl/qoriq-fman3-0-10g-1-best-effort.dtsi   |   66 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-1.dtsi |   63 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-0.dtsi  |   62 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-1.dtsi  |   62 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-2.dtsi  |   62 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-3.dtsi  |   62 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-4.dtsi  |   62 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-5.dtsi  |   62 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi       |  106 ++
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-10g-0.dtsi |   63 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-10g-1.dtsi |   63 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-0.dtsi  |   62 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-1.dtsi  |   62 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-2.dtsi  |   62 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-3.dtsi  |   62 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-4.dtsi  |   62 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-5.dtsi  |   62 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi       |  106 ++
 arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi      |   94 ++
 arch/powerpc/boot/dts/{ =3D> fsl}/t1023rdb.dts       |    4 +-
 arch/powerpc/boot/dts/fsl/t1023si-post.dtsi        |   19 +
 arch/powerpc/boot/dts/{ =3D> fsl}/t1024qds.dts       |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/t1024rdb.dts       |    4 +-
 arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi         |    6 +
 arch/powerpc/boot/dts/{ =3D> fsl}/t1040d4rdb.dts     |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/t1040qds.dts       |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/t1040rdb.dts       |    4 +-
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi        |   31 +
 arch/powerpc/boot/dts/{ =3D> fsl}/t1042d4rdb.dts     |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/t1042qds.dts       |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/t1042rdb.dts       |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/t1042rdb_pi.dts    |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/t104xd4rdb.dtsi    |   10 +
 arch/powerpc/boot/dts/{ =3D> fsl}/t104xqds.dtsi      |    0
 arch/powerpc/boot/dts/{ =3D> fsl}/t104xrdb.dtsi      |    0
 arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi         |    9 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/t2080qds.dts       |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/t2080rdb.dts       |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/t2081qds.dts       |    4 +-
 arch/powerpc/boot/dts/fsl/t2081si-post.dtsi        |   43 +
 arch/powerpc/boot/dts/{ =3D> fsl}/t208xqds.dtsi      |    0
 arch/powerpc/boot/dts/{ =3D> fsl}/t208xrdb.dtsi      |    0
 arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi         |   11 +
 arch/powerpc/boot/dts/{ =3D> fsl}/t4240qds.dts       |    4 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/t4240rdb.dts       |    4 +-
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi        |   88 +-
 arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi         |   22 +-
 arch/powerpc/boot/dts/mpc5121.dtsi                 |   11 +-
 arch/powerpc/boot/dts/mpc5125twr.dts               |   11 +-
 arch/powerpc/boot/dts/prpmc2800.dts                |  297 -----
 arch/powerpc/boot/page.h                           |    4 +-
 arch/powerpc/boot/prpmc2800.c                      |  571 ---------
 arch/powerpc/boot/wrapper                          |   25 +-
 arch/powerpc/configs/cell_defconfig                |    2 +-
 arch/powerpc/configs/mpc512x_defconfig             |    1 +
 arch/powerpc/configs/ps3_defconfig                 |    7 +-
 arch/powerpc/include/asm/exception-64e.h           |   15 +-
 arch/powerpc/include/asm/mmu-hash64.h              |    1 +
 arch/powerpc/include/asm/mpc5121.h                 |   59 +
 arch/powerpc/include/asm/mpc52xx_psc.h             |    2 -
 arch/powerpc/include/asm/msi_bitmap.h              |    1 +
 arch/powerpc/include/asm/page.h                    |   32 +-
 arch/powerpc/include/asm/pgtable-ppc64.h           |   10 +-
 arch/powerpc/include/asm/pgtable.h                 |    6 +-
 arch/powerpc/include/asm/systbl.h                  |   12 +
 arch/powerpc/include/asm/unistd.h                  |    2 +-
 arch/powerpc/include/uapi/asm/unistd.h             |   12 +
 arch/powerpc/kernel/crash.c                        |    6 +-
 arch/powerpc/kernel/eeh.c                          |    8 +-
 arch/powerpc/kernel/eeh_driver.c                   |   27 +-
 arch/powerpc/kernel/exceptions-64e.S               |   17 +-
 arch/powerpc/kernel/head_64.S                      |   43 +-
 arch/powerpc/kernel/io-workarounds.c               |    2 +-
 arch/powerpc/kernel/machine_kexec_64.c             |   18 +
 arch/powerpc/kernel/misc_64.S                      |   60 +-
 arch/powerpc/kernel/nvram_64.c                     |   15 +-
 arch/powerpc/kernel/paca.c                         |    9 +-
 arch/powerpc/kernel/pci-common.c                   |    1 +
 arch/powerpc/kernel/prom.c                         |   18 +-
 arch/powerpc/kernel/setup_64.c                     |   25 +-
 arch/powerpc/kernel/vdso32/Makefile                |    2 +-
 arch/powerpc/kernel/vdso32/datapage.S              |   12 +-
 arch/powerpc/kernel/vdso64/Makefile                |    2 +-
 arch/powerpc/kernel/vdso64/datapage.S              |   12 +-
 arch/powerpc/kernel/vmlinux.lds.S                  |    6 +
 arch/powerpc/kvm/book3s_64_mmu_hv.c                |    2 +-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c                |    8 +-
 arch/powerpc/kvm/e500_mmu_host.c                   |    2 +-
 arch/powerpc/mm/fsl_booke_mmu.c                    |   26 +-
 arch/powerpc/mm/hash_utils_64.c                    |    7 +-
 arch/powerpc/mm/hugetlbpage.c                      |   40 +-
 arch/powerpc/mm/mmu_decl.h                         |    4 +-
 arch/powerpc/mm/numa.c                             |    5 +-
 arch/powerpc/mm/slb.c                              |   49 +-
 arch/powerpc/mm/tlb_hash64.c                       |    9 +-
 arch/powerpc/mm/tlb_low_64e.S                      |   25 +-
 arch/powerpc/mm/tlb_nohash.c                       |   41 +-
 arch/powerpc/mm/tlb_nohash_low.S                   |   63 +
 arch/powerpc/perf/callchain.c                      |    2 +-
 arch/powerpc/platforms/512x/Kconfig                |    6 +
 arch/powerpc/platforms/512x/Makefile               |    1 +
 arch/powerpc/platforms/512x/mpc512x_lpbfifo.c      |  540 ++++++++
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c          |    6 +-
 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c      |    1 +
 arch/powerpc/platforms/85xx/corenet_generic.c      |   11 +
 arch/powerpc/platforms/85xx/mpc85xx_mds.c          |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c          |    2 +-
 arch/powerpc/platforms/85xx/p1022_ds.c             |    2 +-
 arch/powerpc/platforms/85xx/p1022_rdk.c            |    2 +-
 arch/powerpc/platforms/85xx/smp.c                  |   88 +-
 arch/powerpc/platforms/85xx/twr_p102x.c            |    2 +-
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c         |    2 +-
 arch/powerpc/platforms/Kconfig.cputype             |   11 -
 arch/powerpc/platforms/cell/Kconfig                |    4 +-
 arch/powerpc/platforms/maple/Kconfig               |    2 +-
 arch/powerpc/platforms/pasemi/Kconfig              |    2 +-
 arch/powerpc/platforms/powermac/Kconfig            |    2 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c       |   86 +-
 arch/powerpc/platforms/powernv/setup.c             |   21 +-
 arch/powerpc/platforms/ps3/Kconfig                 |    2 +-
 arch/powerpc/platforms/pseries/Kconfig             |    7 +-
 arch/powerpc/platforms/pseries/Makefile            |    7 +-
 arch/powerpc/platforms/pseries/dlpar.c             |   31 +-
 arch/powerpc/platforms/pseries/eeh_pseries.c       |   60 +-
 arch/powerpc/platforms/pseries/hvcserver.c         |    2 +-
 arch/powerpc/platforms/pseries/iommu.c             |   10 -
 arch/powerpc/platforms/pseries/of_helpers.c        |   38 +
 arch/powerpc/platforms/pseries/of_helpers.h        |    8 +
 arch/powerpc/platforms/pseries/reconfig.c          |   34 +-
 arch/powerpc/platforms/pseries/setup.c             |    4 -
 arch/powerpc/sysdev/cpm_common.c                   |    3 +-
 arch/powerpc/sysdev/fsl_pci.c                      |   86 +-
 arch/powerpc/sysdev/mpc5xxx_clocks.c               |    5 +-
 arch/powerpc/sysdev/mpc8xx_pic.c                   |    2 +-
 arch/powerpc/sysdev/mpic.c                         |   23 +-
 arch/powerpc/sysdev/msi_bitmap.c                   |   18 +-
 arch/powerpc/xmon/nonstdio.c                       |   64 +-
 arch/powerpc/xmon/nonstdio.h                       |    3 +
 arch/powerpc/xmon/xmon.c                           |   79 +-
 drivers/char/agp/uninorth-agp.c                    |   16 +-
 drivers/clk/Kconfig                                |    2 +-
 drivers/clk/clk-qoriq.c                            | 1354 ++++++++++++++++=
----
 drivers/iommu/fsl_pamu.c                           |    2 +-
 drivers/macintosh/Kconfig                          |    5 +-
 drivers/misc/cxl/vphb.c                            |    2 +
 drivers/ps3/ps3-lpm.c                              |    2 +-
 drivers/ps3/ps3-vuart.c                            |    3 +-
 .../asm/fsl_guts.h =3D> include/linux/fsl/guts.h     |    8 +-
 scripts/kconfig/Makefile                           |    5 +-
 sound/soc/fsl/mpc8610_hpcd.c                       |    2 +-
 sound/soc/fsl/p1022_ds.c                           |    2 +-
 sound/soc/fsl/p1022_rdk.c                          |    2 +-
 tools/testing/selftests/powerpc/Makefile           |   12 +-
 .../selftests/powerpc/benchmarks/.gitignore        |    1 +
 .../testing/selftests/powerpc/benchmarks/Makefile  |   12 +
 .../selftests/powerpc/benchmarks/gettimeofday.c    |   31 +
 .../powerpc/pmu/ebb/back_to_back_ebbs_test.c       |    2 +
 .../powerpc/pmu/ebb/close_clears_pmcc_test.c       |    2 +
 .../powerpc/pmu/ebb/cpu_event_pinned_vs_ebb_test.c |    2 +
 .../powerpc/pmu/ebb/cpu_event_vs_ebb_test.c        |    2 +
 .../selftests/powerpc/pmu/ebb/cycles_test.c        |    2 +
 .../powerpc/pmu/ebb/cycles_with_freeze_test.c      |    2 +
 .../powerpc/pmu/ebb/cycles_with_mmcr2_test.c       |    2 +
 tools/testing/selftests/powerpc/pmu/ebb/ebb.c      |   11 +
 tools/testing/selftests/powerpc/pmu/ebb/ebb.h      |    1 +
 .../selftests/powerpc/pmu/ebb/ebb_on_child_test.c  |    2 +
 .../powerpc/pmu/ebb/ebb_on_willing_child_test.c    |    2 +
 .../powerpc/pmu/ebb/ebb_vs_cpu_event_test.c        |    2 +
 .../powerpc/pmu/ebb/event_attributes_test.c        |    2 +
 .../selftests/powerpc/pmu/ebb/fork_cleanup_test.c  |    2 +
 .../powerpc/pmu/ebb/instruction_count_test.c       |    2 +
 .../powerpc/pmu/ebb/lost_exception_test.c          |    2 +
 .../selftests/powerpc/pmu/ebb/multi_counter_test.c |    2 +
 .../powerpc/pmu/ebb/multi_ebb_procs_test.c         |    2 +
 .../selftests/powerpc/pmu/ebb/no_handler_test.c    |    2 +
 .../selftests/powerpc/pmu/ebb/pmae_handling_test.c |    2 +
 .../powerpc/pmu/ebb/pmc56_overflow_test.c          |    2 +
 .../selftests/powerpc/pmu/ebb/reg_access_test.c    |    2 +
 .../pmu/ebb/task_event_pinned_vs_ebb_test.c        |    2 +
 .../powerpc/pmu/ebb/task_event_vs_ebb_test.c       |    2 +
 .../testing/selftests/powerpc/syscalls/.gitignore  |    1 +
 tools/testing/selftests/powerpc/syscalls/Makefile  |   12 +
 tools/testing/selftests/powerpc/syscalls/ipc.h     |   47 +
 .../selftests/powerpc/syscalls/ipc_unmuxed.c       |   61 +
 tools/testing/selftests/powerpc/tm/tm-syscall.c    |   14 +-
 311 files changed, 6522 insertions(+), 1741 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/maxim,ds26522.txt
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/mpc512x_l=
pbfifo.txt
 rename arch/powerpc/boot/dts/{ =3D> fsl}/b4420qds.dts (96%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/b4860qds.dts (97%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/b4qds.dtsi (99%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/bsc9131rdb.dts (91%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/bsc9131rdb.dtsi (90%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/bsc9132qds.dts (91%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/bsc9132qds.dtsi (91%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/c293pcie.dts (98%)
 create mode 100644 arch/powerpc/boot/dts/fsl/cyrus_p5020.dts
 rename arch/powerpc/boot/dts/{ =3D> fsl}/ge_imp3a.dts (98%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/kmcoge4.dts (98%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/mpc8536ds.dts (97%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/mpc8536ds.dtsi (100%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/mpc8536ds_36b.dts (97%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/mpc8540ads.dts (99%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/mpc8541cds.dts (99%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/mpc8544ds.dts (97%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/mpc8544ds.dtsi (100%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/mpc8548cds.dtsi (100%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/mpc8548cds_32b.dts (96%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/mpc8548cds_36b.dts (96%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/mpc8555cds.dts (99%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/mpc8560ads.dts (99%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/mpc8568mds.dts (99%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/mpc8569mds.dts (99%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/mpc8572ds.dts (96%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/mpc8572ds.dtsi (100%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/mpc8572ds_36b.dts (96%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/mpc8572ds_camp_core0.dts (100%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/mpc8572ds_camp_core1.dts (100%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/mvme2500.dts (98%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/oca4080.dts (98%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1010rdb-pa.dts (88%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1010rdb-pa.dtsi (100%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1010rdb-pa_36b.dts (96%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1010rdb-pb.dts (89%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1010rdb-pb_36b.dts (96%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1010rdb.dtsi (94%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1010rdb_32b.dtsi (100%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1010rdb_36b.dtsi (100%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1020mbg-pc.dtsi (100%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1020mbg-pc_32b.dts (97%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1020mbg-pc_36b.dts (97%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1020rdb-pc.dtsi (100%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1020rdb-pc_32b.dts (97%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1020rdb-pc_36b.dts (97%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1020rdb-pc_camp_core0.dts (100%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1020rdb-pc_camp_core1.dts (100%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1020rdb-pd.dts (95%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1020rdb.dts (95%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1020rdb.dtsi (100%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1020rdb_36b.dts (95%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1020utm-pc.dtsi (100%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1020utm-pc_32b.dts (97%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1020utm-pc_36b.dts (97%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1021mds.dts (99%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1021rdb-pc.dtsi (95%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1021rdb-pc_32b.dts (97%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1021rdb-pc_36b.dts (97%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1022ds.dtsi (94%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1022ds_32b.dts (98%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1022ds_36b.dts (98%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1022rdk.dts (98%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1023rdb.dts (99%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1024rdb.dtsi (100%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1024rdb_32b.dts (97%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1024rdb_36b.dts (97%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1025rdb.dtsi (100%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1025rdb_32b.dts (98%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1025rdb_36b.dts (97%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1025twr.dts (97%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p1025twr.dtsi (96%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p2020ds.dts (96%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p2020ds.dtsi (100%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p2020rdb-pc.dtsi (97%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p2020rdb-pc_32b.dts (97%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p2020rdb-pc_36b.dts (97%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p2020rdb.dts (98%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p2041rdb.dts (98%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p3041ds.dts (99%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p4080ds.dts (98%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p5020ds.dts (99%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/p5040ds.dts (98%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/ppa8548.dts (97%)
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman-0-10g-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman-0-1g-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman-0-1g-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman-0-1g-2.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman-0-1g-3.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman-0-1g-4.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman-1-10g-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman-1-1g-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman-1-1g-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman-1-1g-2.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman-1-1g-3.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman-1-1g-4.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-0-best-effo=
rt.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-1-best-effo=
rt.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-2.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-3.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-4.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-5.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-10g-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-10g-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-2.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-3.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-4.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-5.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi
 rename arch/powerpc/boot/dts/{ =3D> fsl}/t1023rdb.dts (98%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/t1024qds.dts (98%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/t1024rdb.dts (98%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/t1040d4rdb.dts (96%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/t1040qds.dts (96%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/t1040rdb.dts (96%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/t1042d4rdb.dts (96%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/t1042qds.dts (96%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/t1042rdb.dts (96%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/t1042rdb_pi.dts (96%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/t104xd4rdb.dtsi (95%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/t104xqds.dtsi (100%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/t104xrdb.dtsi (100%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/t2080qds.dts (96%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/t2080rdb.dts (97%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/t2081qds.dts (96%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/t208xqds.dtsi (100%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/t208xrdb.dtsi (100%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/t4240qds.dts (99%)
 rename arch/powerpc/boot/dts/{ =3D> fsl}/t4240rdb.dts (98%)
 delete mode 100644 arch/powerpc/boot/dts/prpmc2800.dts
 delete mode 100644 arch/powerpc/boot/prpmc2800.c
 create mode 100644 arch/powerpc/platforms/512x/mpc512x_lpbfifo.c
 create mode 100644 arch/powerpc/platforms/pseries/of_helpers.c
 create mode 100644 arch/powerpc/platforms/pseries/of_helpers.h
 rename arch/powerpc/include/asm/fsl_guts.h =3D> include/linux/fsl/guts.h (=
98%)
 create mode 100644 tools/testing/selftests/powerpc/benchmarks/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/benchmarks/Makefile
 create mode 100644 tools/testing/selftests/powerpc/benchmarks/gettimeofday=
.c
 create mode 100644 tools/testing/selftests/powerpc/syscalls/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/syscalls/Makefile
 create mode 100644 tools/testing/selftests/powerpc/syscalls/ipc.h
 create mode 100644 tools/testing/selftests/powerpc/syscalls/ipc_unmuxed.c

--=-qgjJE1OYEwzx7sdYurUt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJWPEtoAAoJEFHr6jzI4aWA1PwP/iGZ+MooGDU88DAqosE2uR/K
DckQhl20ILEjti2pcIMvptQiyuvpC5T5XCTMd0DNhzBXOZksECL4E+qWqIXkY2qP
CQ6AxfJifALnfZhY9aLEN88jAuKd03lZ3eugAbN7SnKeBppVXkTgdI4hkdCsre/x
YZjZ6apqpoe0pmsy5nv0UDQhMEd5XOr4MlnFFEUnHqQ/OX8VBviIUSFtfJQNBNMz
Yeyc19OULS9/T4b8BzwAQpO2Xu8cWsbWGBKDlTukfL/Up0WDzYDxhk1hSjpL3bZn
pv7rhcGJhMSsU3rdkIUs8SLexAixAmvc5wZsYLl/F7N5110JgGzZ2yFzEvyyD6sZ
Fa0bFZyNrW96C1j7QQy+ij18EFf0281WlNNYEY1lsKnAW+e8cZGssvP8s9vr09xt
BbruTyGz6KGX1sCoZsy2VIR5HIhteFFvump0YDkuoFoi/7JrrfsSYJUu0Qusgifl
ndeSr0rCrBvRSKqypN8R7pWEtvv4E/X/1KKuIx0yLfgLQAIQtCo9RzvxP2kdP3nJ
sRckTIG5oQvtA3ZtztINYGSC+8mJTKGNoMkvSI3BkEgmkbsDExk+8IRqtq/V5Y5y
xUp+sU4E/E4d6E+/TMCf2TW92nEZ6U6RSaj9Rva7b883+P+bKCwkeHK27NUx2Yhc
dErRCoFysGjHqD8qEXkq
=GZfI
-----END PGP SIGNATURE-----

--=-qgjJE1OYEwzx7sdYurUt--
