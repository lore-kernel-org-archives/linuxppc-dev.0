Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18337.8955.539106.868486@cargo.ozlabs.ibm.com>
Date: Thu, 31 Jan 2008 12:23:07 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: Please pull powerpc.git for-2.6.25 branch
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

Please do

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git for-2.6.25

to get a powerpc update for 2.6.25.

Thanks,
Paul.

 Documentation/kernel-parameters.txt                |    1 
 Documentation/powerpc/00-INDEX                     |    3 
 Documentation/powerpc/booting-without-of.txt       |  367 +++
 Documentation/powerpc/qe_firmware.txt              |  295 +++
 arch/powerpc/Kconfig                               |   17 
 arch/powerpc/Kconfig.debug                         |   26 
 arch/powerpc/Makefile                              |    3 
 arch/powerpc/boot/.gitignore                       |    2 
 arch/powerpc/boot/4xx.c                            |  476 ++++
 arch/powerpc/boot/4xx.h                            |   14 
 arch/powerpc/boot/Makefile                         |  118 +
 arch/powerpc/boot/bamboo.c                         |    6 
 arch/powerpc/boot/cuboot-52xx.c                    |    2 
 arch/powerpc/boot/cuboot-824x.c                    |   53 
 arch/powerpc/boot/cuboot-83xx.c                    |    5 
 arch/powerpc/boot/cuboot-85xx-cpm2.c               |   66 +
 arch/powerpc/boot/cuboot-85xx.c                    |    7 
 arch/powerpc/boot/cuboot-8xx.c                     |    2 
 arch/powerpc/boot/cuboot-hpc2.c                    |    2 
 arch/powerpc/boot/cuboot-katmai.c                  |   56 +
 arch/powerpc/boot/cuboot-pq2.c                     |    2 
 arch/powerpc/boot/cuboot-rainier.c                 |   56 +
 arch/powerpc/boot/cuboot-sequoia.c                 |    4 
 arch/powerpc/boot/cuboot-taishan.c                 |   54 
 arch/powerpc/boot/cuboot-warp.c                    |   39 
 arch/powerpc/boot/dcr.h                            |   59 +
 arch/powerpc/boot/devtree.c                        |   14 
 arch/powerpc/boot/dtc-src/.gitignore               |    3 
 arch/powerpc/boot/dtc-src/Makefile.dtc             |   25 
 arch/powerpc/boot/dtc-src/checks.c                 |  750 +++++++
 arch/powerpc/boot/dtc-src/data.c                   |  321 +++
 arch/powerpc/boot/dtc-src/dtc-lexer.l              |  328 +++
 arch/powerpc/boot/dtc-src/dtc-lexer.lex.c_shipped  | 2174 ++++++++++++++++++++
 arch/powerpc/boot/dtc-src/dtc-parser.tab.c_shipped | 1983 ++++++++++++++++++
 arch/powerpc/boot/dtc-src/dtc-parser.tab.h_shipped |  111 +
 arch/powerpc/boot/dtc-src/dtc-parser.y             |  336 +++
 arch/powerpc/boot/dtc-src/dtc.c                    |  231 ++
 arch/powerpc/boot/dtc-src/dtc.h                    |  269 ++
 arch/powerpc/boot/dtc-src/flattree.c               |  968 +++++++++
 arch/powerpc/boot/dtc-src/fstree.c                 |   94 +
 arch/powerpc/boot/dtc-src/livetree.c               |  305 +++
 arch/powerpc/boot/dtc-src/srcpos.c                 |  105 +
 arch/powerpc/boot/dtc-src/srcpos.h                 |   75 +
 arch/powerpc/boot/dtc-src/treesource.c             |  275 +++
 arch/powerpc/boot/dtc-src/version_gen.h            |    1 
 arch/powerpc/boot/dts/adder875-redboot.dts         |  184 ++
 arch/powerpc/boot/dts/adder875-uboot.dts           |  183 ++
 arch/powerpc/boot/dts/bamboo.dts                   |   62 +
 arch/powerpc/boot/dts/cm5200.dts                   |  234 ++
 arch/powerpc/boot/dts/ebony.dts                    |   58 -
 arch/powerpc/boot/dts/ep405.dts                    |  228 ++
 arch/powerpc/boot/dts/ep8248e.dts                  |  207 ++
 arch/powerpc/boot/dts/haleakala.dts                |  274 +++
 arch/powerpc/boot/dts/katmai.dts                   |  400 ++++
 arch/powerpc/boot/dts/kilauea.dts                  |   99 +
 arch/powerpc/boot/dts/kuroboxHD.dts                |   16 
 arch/powerpc/boot/dts/kuroboxHG.dts                |   16 
 arch/powerpc/boot/dts/lite5200.dts                 |  104 -
 arch/powerpc/boot/dts/lite5200b.dts                |  101 -
 arch/powerpc/boot/dts/makalu.dts                   |  347 +++
 arch/powerpc/boot/dts/motionpro.dts                |  301 +++
 arch/powerpc/boot/dts/mpc8313erdb.dts              |  217 +-
 arch/powerpc/boot/dts/mpc8315erdb.dts              |  287 +++
 arch/powerpc/boot/dts/mpc832x_mds.dts              |  352 ++-
 arch/powerpc/boot/dts/mpc832x_rdb.dts              |  224 +-
 arch/powerpc/boot/dts/mpc8349emitx.dts             |  231 +-
 arch/powerpc/boot/dts/mpc8349emitxgp.dts           |  144 +
 arch/powerpc/boot/dts/mpc834x_mds.dts              |  311 +--
 arch/powerpc/boot/dts/mpc836x_mds.dts              |  335 ++-
 arch/powerpc/boot/dts/mpc8377_mds.dts              |  280 +++
 arch/powerpc/boot/dts/mpc8377_rdb.dts              |  296 +++
 arch/powerpc/boot/dts/mpc8378_mds.dts              |  266 ++
 arch/powerpc/boot/dts/mpc8378_rdb.dts              |  282 +++
 arch/powerpc/boot/dts/mpc8379_mds.dts              |  294 +++
 arch/powerpc/boot/dts/mpc8379_rdb.dts              |  310 +++
 arch/powerpc/boot/dts/mpc8540ads.dts               |   59 -
 arch/powerpc/boot/dts/mpc8541cds.dts               |   41 
 arch/powerpc/boot/dts/mpc8544ds.dts                |   65 -
 arch/powerpc/boot/dts/mpc8548cds.dts               |   68 -
 arch/powerpc/boot/dts/mpc8555cds.dts               |   41 
 arch/powerpc/boot/dts/mpc8560ads.dts               |   59 -
 arch/powerpc/boot/dts/mpc8568mds.dts               |  104 -
 arch/powerpc/boot/dts/mpc8572ds.dts                |   66 -
 arch/powerpc/boot/dts/mpc8610_hpcd.dts             |  256 ++
 arch/powerpc/boot/dts/mpc8641_hpcn.dts             |  433 ++--
 arch/powerpc/boot/dts/mpc866ads.dts                |  156 +
 arch/powerpc/boot/dts/rainier.dts                  |  353 +++
 arch/powerpc/boot/dts/sbc8349.dts                  |  244 ++
 arch/powerpc/boot/dts/sbc8548.dts                  |  244 ++
 arch/powerpc/boot/dts/sbc8560.dts                  |  330 +++
 arch/powerpc/boot/dts/sequoia.dts                  |   49 
 arch/powerpc/boot/dts/storcenter.dts               |  141 +
 arch/powerpc/boot/dts/stx_gp3_8560.dts             |  228 ++
 arch/powerpc/boot/dts/taishan.dts                  |  383 ++++
 arch/powerpc/boot/dts/tqm5200.dts                  |  177 ++
 arch/powerpc/boot/dts/tqm8540.dts                  |  204 ++
 arch/powerpc/boot/dts/tqm8541.dts                  |  228 ++
 arch/powerpc/boot/dts/tqm8555.dts                  |  228 ++
 arch/powerpc/boot/dts/tqm8560.dts                  |  245 ++
 arch/powerpc/boot/dts/walnut.dts                   |   55 -
 arch/powerpc/boot/dts/warp.dts                     |  239 ++
 arch/powerpc/boot/ebony.c                          |   64 -
 arch/powerpc/boot/ep405.c                          |   74 +
 arch/powerpc/boot/ep8248e.c                        |   55 +
 arch/powerpc/boot/ep88xc.c                         |    2 
 arch/powerpc/boot/flatdevtree.c                    | 1036 ----------
 arch/powerpc/boot/flatdevtree.h                    |  113 -
 arch/powerpc/boot/flatdevtree_misc.c               |   79 -
 arch/powerpc/boot/holly.c                          |    2 
 arch/powerpc/boot/libfdt-wrapper.c                 |  193 ++
 arch/powerpc/boot/libfdt/Makefile.libfdt           |   14 
 arch/powerpc/boot/libfdt/fdt.c                     |  156 +
 arch/powerpc/boot/libfdt/fdt.h                     |   60 +
 arch/powerpc/boot/libfdt/fdt_ro.c                  |  583 +++++
 arch/powerpc/boot/libfdt/fdt_rw.c                  |  447 ++++
 arch/powerpc/boot/libfdt/fdt_strerror.c            |   96 +
 arch/powerpc/boot/libfdt/fdt_sw.c                  |  258 ++
 arch/powerpc/boot/libfdt/fdt_wip.c                 |  144 +
 arch/powerpc/boot/libfdt/libfdt.h                  |  721 +++++++
 arch/powerpc/boot/libfdt/libfdt_internal.h         |   89 +
 arch/powerpc/boot/libfdt_env.h                     |   17 
 arch/powerpc/boot/main.c                           |    1 
 arch/powerpc/boot/ops.h                            |   27 
 arch/powerpc/boot/prpmc2800.c                      |    3 
 arch/powerpc/boot/ps3.c                            |    2 
 arch/powerpc/boot/redboot-8xx.c                    |   58 +
 arch/powerpc/boot/redboot.h                        |   56 +
 arch/powerpc/boot/reg.h                            |    8 
 arch/powerpc/boot/serial.c                         |    5 
 arch/powerpc/boot/treeboot-walnut.c                |   53 
 arch/powerpc/boot/wrapper                          |   21 
 arch/powerpc/configs/adder875-redboot_defconfig    |  629 +++---
 arch/powerpc/configs/adder875-uboot_defconfig      |  629 +++---
 arch/powerpc/configs/bamboo_defconfig              |   26 
 arch/powerpc/configs/celleb_defconfig              |   38 
 arch/powerpc/configs/ebony_defconfig               |    8 
 arch/powerpc/configs/ep405_defconfig               |  543 +++--
 arch/powerpc/configs/ep8248e_defconfig             |  660 +++---
 arch/powerpc/configs/katmai_defconfig              |  389 ++--
 arch/powerpc/configs/kilauea_defconfig             |   74 +
 arch/powerpc/configs/makalu_defconfig              |  495 ++---
 arch/powerpc/configs/mpc5200_defconfig             | 1286 ++++++++++++
 arch/powerpc/configs/mpc8313_rdb_defconfig         |   48 
 arch/powerpc/configs/mpc8315_rdb_defconfig         | 1417 +++++++++++++
 arch/powerpc/configs/mpc834x_itx_defconfig         |    3 
 arch/powerpc/configs/mpc837x_mds_defconfig         |  573 +++--
 arch/powerpc/configs/mpc837x_rdb_defconfig         |  550 +++--
 arch/powerpc/configs/mpc83xx_defconfig             |  530 +++--
 arch/powerpc/configs/mpc85xx_defconfig             | 1523 ++++++++++++++
 arch/powerpc/configs/mpc8610_hpcd_defconfig        |  171 ++
 arch/powerpc/configs/pasemi_defconfig              |   32 
 arch/powerpc/configs/ppc64_defconfig               |    8 
 arch/powerpc/configs/ps3_defconfig                 |   49 
 arch/powerpc/configs/rainier_defconfig             |  474 ++--
 arch/powerpc/configs/sbc834x_defconfig             |  555 ++---
 arch/powerpc/configs/sbc8548_defconfig             |  412 +---
 arch/powerpc/configs/sbc8560_defconfig             |  487 ++--
 arch/powerpc/configs/sequoia_defconfig             |   34 
 arch/powerpc/configs/storcenter_defconfig          |  713 +++++--
 arch/powerpc/configs/stx_gp3_defconfig             |  990 +++++----
 arch/powerpc/configs/taishan_defconfig             |  389 ++--
 arch/powerpc/configs/tqm8540_defconfig             |  587 +++--
 arch/powerpc/configs/tqm8541_defconfig             |  602 +++---
 arch/powerpc/configs/tqm8555_defconfig             |  602 +++---
 arch/powerpc/configs/tqm8560_defconfig             |  598 +++---
 arch/powerpc/configs/walnut_defconfig              |   94 +
 arch/powerpc/configs/warp_defconfig                | 1057 ++++++++++
 arch/powerpc/kernel/Makefile                       |   13 
 arch/powerpc/kernel/btext.c                        |    2 
 arch/powerpc/kernel/cpu_setup_44x.S                |   15 
 arch/powerpc/kernel/cputable.c                     |  149 +
 arch/powerpc/kernel/crash.c                        |  101 +
 arch/powerpc/kernel/dma_64.c                       |   19 
 arch/powerpc/kernel/head_44x.S                     |   14 
 arch/powerpc/kernel/head_64.S                      |    1 
 arch/powerpc/kernel/head_booke.h                   |    2 
 arch/powerpc/kernel/head_fsl_booke.S               |   20 
 arch/powerpc/kernel/ibmebus.c                      |   12 
 arch/powerpc/kernel/iommu.c                        |    8 
 arch/powerpc/kernel/isa-bridge.c                   |    6 
 arch/powerpc/kernel/legacy_serial.c                |   51 
 arch/powerpc/kernel/lparcfg.c                      |   12 
 arch/powerpc/kernel/misc.S                         |   73 +
 arch/powerpc/kernel/misc_32.S                      |   56 -
 arch/powerpc/kernel/misc_64.S                      |    7 
 arch/powerpc/kernel/module_32.c                    |   77 +
 arch/powerpc/kernel/module_64.c                    |   81 +
 arch/powerpc/kernel/of_device.c                    |    2 
 arch/powerpc/kernel/of_platform.c                  |   33 
 arch/powerpc/kernel/pci-common.c                   |  774 +++++++
 arch/powerpc/kernel/pci_32.c                       |  969 ---------
 arch/powerpc/kernel/pci_64.c                       |  444 +---
 arch/powerpc/kernel/pci_dn.c                       |    7 
 arch/powerpc/kernel/ppc_ksyms.c                    |    1 
 arch/powerpc/kernel/prom.c                         |   52 
 arch/powerpc/kernel/prom_init.c                    |  149 +
 arch/powerpc/kernel/prom_parse.c                   |   22 
 arch/powerpc/kernel/rio.c                          |    0 
 arch/powerpc/kernel/rtas_pci.c                     |   13 
 arch/powerpc/kernel/setup-common.c                 |   78 +
 arch/powerpc/kernel/signal_32.c                    |    3 
 arch/powerpc/kernel/smp.c                          |   49 
 arch/powerpc/kernel/systbl_chk.c                   |   58 +
 arch/powerpc/kernel/systbl_chk.sh                  |   33 
 arch/powerpc/kernel/time.c                         |   91 +
 arch/powerpc/kernel/traps.c                        |   87 +
 arch/powerpc/kernel/udbg.c                         |    7 
 arch/powerpc/kernel/udbg_16550.c                   |   43 
 arch/powerpc/math-emu/op-4.h                       |   40 
 arch/powerpc/mm/Makefile                           |    1 
 arch/powerpc/mm/fault.c                            |    8 
 arch/powerpc/mm/fsl_booke_mmu.c                    |    6 
 arch/powerpc/mm/hash_low_64.S                      |   16 
 arch/powerpc/mm/hash_utils_64.c                    |  107 +
 arch/powerpc/mm/hugetlbpage.c                      |  119 +
 arch/powerpc/mm/lmb.c                              |   13 
 arch/powerpc/mm/mem.c                              |   21 
 arch/powerpc/mm/slb.c                              |    3 
 arch/powerpc/mm/slb_low.S                          |    5 
 arch/powerpc/mm/subpage-prot.c                     |  213 ++
 arch/powerpc/oprofile/op_model_cell.c              |   20 
 arch/powerpc/platforms/40x/Kconfig                 |   40 
 arch/powerpc/platforms/40x/Makefile                |    2 
 arch/powerpc/platforms/40x/ep405.c                 |  123 +
 arch/powerpc/platforms/40x/kilauea.c               |   10 
 arch/powerpc/platforms/40x/makalu.c                |   58 +
 arch/powerpc/platforms/40x/virtex.c                |   17 
 arch/powerpc/platforms/40x/walnut.c                |   12 
 arch/powerpc/platforms/44x/Kconfig                 |   61 +
 arch/powerpc/platforms/44x/Makefile                |    7 
 arch/powerpc/platforms/44x/bamboo.c                |   11 
 arch/powerpc/platforms/44x/ebony.c                 |   12 
 arch/powerpc/platforms/44x/katmai.c                |   63 +
 arch/powerpc/platforms/44x/rainier.c               |   62 +
 arch/powerpc/platforms/44x/sequoia.c               |   11 
 arch/powerpc/platforms/44x/taishan.c               |   73 +
 arch/powerpc/platforms/44x/warp-nand.c             |  105 +
 arch/powerpc/platforms/44x/warp.c                  |  153 +
 arch/powerpc/platforms/52xx/Kconfig                |   50 
 arch/powerpc/platforms/52xx/Makefile               |    1 
 arch/powerpc/platforms/52xx/efika.c                |    3 
 arch/powerpc/platforms/52xx/lite5200.c             |   46 
 arch/powerpc/platforms/52xx/lite5200_pm.c          |   13 
 arch/powerpc/platforms/52xx/mpc5200_simple.c       |   85 +
 arch/powerpc/platforms/52xx/mpc52xx_common.c       |  154 +
 arch/powerpc/platforms/52xx/mpc52xx_pci.c          |   20 
 arch/powerpc/platforms/52xx/mpc52xx_pic.c          |   22 
 arch/powerpc/platforms/52xx/mpc52xx_pm.c           |   15 
 arch/powerpc/platforms/82xx/Kconfig                |   13 
 arch/powerpc/platforms/82xx/Makefile               |    1 
 arch/powerpc/platforms/82xx/ep8248e.c              |  324 +++
 arch/powerpc/platforms/82xx/mpc8272_ads.c          |    5 
 arch/powerpc/platforms/82xx/pq2.c                  |    4 
 arch/powerpc/platforms/82xx/pq2fads.c              |    7 
 arch/powerpc/platforms/83xx/Kconfig                |   63 -
 arch/powerpc/platforms/83xx/Makefile               |    5 
 arch/powerpc/platforms/83xx/mpc831x_rdb.c          |   51 
 arch/powerpc/platforms/83xx/mpc832x_mds.c          |   20 
 arch/powerpc/platforms/83xx/mpc832x_rdb.c          |   23 
 arch/powerpc/platforms/83xx/mpc834x_itx.c          |   12 
 arch/powerpc/platforms/83xx/mpc834x_mds.c          |   18 
 arch/powerpc/platforms/83xx/mpc836x_mds.c          |   20 
 arch/powerpc/platforms/83xx/mpc837x_mds.c          |  147 +
 arch/powerpc/platforms/83xx/mpc837x_rdb.c          |   99 +
 arch/powerpc/platforms/83xx/mpc83xx.h              |    3 
 arch/powerpc/platforms/83xx/pci.c                  |    2 
 arch/powerpc/platforms/83xx/sbc834x.c              |  115 +
 arch/powerpc/platforms/83xx/usb.c                  |   50 
 arch/powerpc/platforms/85xx/Kconfig                |   87 +
 arch/powerpc/platforms/85xx/Makefile               |    4 
 arch/powerpc/platforms/85xx/mpc85xx_ads.c          |   18 
 arch/powerpc/platforms/85xx/mpc85xx_cds.c          |    6 
 arch/powerpc/platforms/85xx/mpc85xx_ds.c           |    2 
 arch/powerpc/platforms/85xx/mpc85xx_mds.c          |   43 
 arch/powerpc/platforms/85xx/sbc8548.c              |  167 ++
 arch/powerpc/platforms/85xx/sbc8560.c              |  283 +++
 arch/powerpc/platforms/85xx/stx_gp3.c              |  183 ++
 arch/powerpc/platforms/85xx/tqm85xx.c              |  187 ++
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c         |   17 
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c         |   16 
 arch/powerpc/platforms/8xx/Kconfig                 |   10 
 arch/powerpc/platforms/8xx/Makefile                |    1 
 arch/powerpc/platforms/8xx/adder875.c              |  118 +
 arch/powerpc/platforms/8xx/ep88xc.c                |   10 
 arch/powerpc/platforms/8xx/m8xx_setup.c            |   13 
 arch/powerpc/platforms/8xx/mpc86xads.h             |   44 
 arch/powerpc/platforms/8xx/mpc86xads_setup.c       |  294 +--
 arch/powerpc/platforms/8xx/mpc885ads_setup.c       |   12 
 arch/powerpc/platforms/8xx/mpc8xx.h                |   21 
 arch/powerpc/platforms/Kconfig                     |   18 
 arch/powerpc/platforms/Kconfig.cputype             |   11 
 arch/powerpc/platforms/cell/Makefile               |    2 
 arch/powerpc/platforms/cell/cbe_cpufreq.c          |    3 
 arch/powerpc/platforms/cell/cbe_cpufreq_pmi.c      |    3 
 arch/powerpc/platforms/cell/cbe_regs.c             |    5 
 arch/powerpc/platforms/cell/io-workarounds.c       |    9 
 arch/powerpc/platforms/cell/iommu.c                |  398 +++-
 arch/powerpc/platforms/cell/pmu.c                  |    7 
 arch/powerpc/platforms/cell/setup.c                |    7 
 arch/powerpc/platforms/cell/smp.c                  |    3 
 arch/powerpc/platforms/cell/spu_base.c             |  224 +-
 arch/powerpc/platforms/cell/spu_fault.c            |   98 +
 arch/powerpc/platforms/cell/spu_manage.c           |   28 
 arch/powerpc/platforms/cell/spufs/Makefile         |    2 
 arch/powerpc/platforms/cell/spufs/backing_ops.c    |   31 
 arch/powerpc/platforms/cell/spufs/context.c        |   53 
 arch/powerpc/platforms/cell/spufs/coredump.c       |    8 
 arch/powerpc/platforms/cell/spufs/fault.c          |  187 +-
 arch/powerpc/platforms/cell/spufs/file.c           |  429 +++-
 arch/powerpc/platforms/cell/spufs/hw_ops.c         |   33 
 arch/powerpc/platforms/cell/spufs/lscsa_alloc.c    |    4 
 arch/powerpc/platforms/cell/spufs/run.c            |  190 +-
 arch/powerpc/platforms/cell/spufs/sched.c          |  361 ++-
 arch/powerpc/platforms/cell/spufs/spufs.h          |   64 -
 arch/powerpc/platforms/cell/spufs/switch.c         |   73 -
 arch/powerpc/platforms/celleb/Kconfig              |    2 
 arch/powerpc/platforms/celleb/io-workarounds.c     |    7 
 arch/powerpc/platforms/celleb/iommu.c              |   26 
 arch/powerpc/platforms/celleb/pci.c                |   14 
 arch/powerpc/platforms/celleb/scc_epci.c           |    2 
 arch/powerpc/platforms/celleb/scc_uhc.c            |    3 
 arch/powerpc/platforms/celleb/setup.c              |  147 +
 arch/powerpc/platforms/chrp/pci.c                  |    6 
 arch/powerpc/platforms/chrp/setup.c                |   65 +
 arch/powerpc/platforms/embedded6xx/Kconfig         |   23 
 arch/powerpc/platforms/embedded6xx/Makefile        |    1 
 arch/powerpc/platforms/embedded6xx/holly.c         |    3 
 arch/powerpc/platforms/embedded6xx/ls_uart.c       |    5 
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c  |    2 
 arch/powerpc/platforms/embedded6xx/storcenter.c    |  192 ++
 arch/powerpc/platforms/iseries/Makefile            |    2 
 arch/powerpc/platforms/iseries/iommu.c             |    4 
 arch/powerpc/platforms/iseries/lpevents.c          |    2 
 arch/powerpc/platforms/iseries/pci.c               |  670 ++++--
 arch/powerpc/platforms/iseries/pci.h               |   27 
 arch/powerpc/platforms/iseries/setup.c             |   61 -
 arch/powerpc/platforms/iseries/setup.h             |    1 
 arch/powerpc/platforms/iseries/vpdinfo.c           |  275 ---
 arch/powerpc/platforms/maple/Kconfig               |    1 
 arch/powerpc/platforms/maple/pci.c                 |    2 
 arch/powerpc/platforms/maple/setup.c               |    2 
 arch/powerpc/platforms/pasemi/Kconfig              |   12 
 arch/powerpc/platforms/pasemi/Makefile             |    1 
 arch/powerpc/platforms/pasemi/cpufreq.c            |   19 
 arch/powerpc/platforms/pasemi/electra_ide.c        |   96 -
 arch/powerpc/platforms/pasemi/gpio_mdio.c          |   96 +
 arch/powerpc/platforms/pasemi/idle.c               |    5 
 arch/powerpc/platforms/pasemi/pasemi.h             |    6 
 arch/powerpc/platforms/pasemi/powersave.S          |   11 
 arch/powerpc/platforms/pasemi/setup.c              |   61 -
 arch/powerpc/platforms/powermac/low_i2c.c          |   10 
 arch/powerpc/platforms/powermac/pci.c              |  248 +-
 arch/powerpc/platforms/powermac/pfunc_base.c       |    3 
 arch/powerpc/platforms/powermac/pic.c              |    3 
 arch/powerpc/platforms/powermac/pmac.h             |    2 
 arch/powerpc/platforms/powermac/setup.c            |   21 
 arch/powerpc/platforms/powermac/time.c             |    2 
 arch/powerpc/platforms/ps3/Kconfig                 |   24 
 arch/powerpc/platforms/ps3/device-init.c           |  531 +++--
 arch/powerpc/platforms/ps3/mm.c                    |   24 
 arch/powerpc/platforms/ps3/platform.h              |   34 
 arch/powerpc/platforms/ps3/repository.c            |  320 ++-
 arch/powerpc/platforms/ps3/spu.c                   |   27 
 arch/powerpc/platforms/ps3/system-bus.c            |   19 
 arch/powerpc/platforms/pseries/eeh.c               |   46 
 arch/powerpc/platforms/pseries/eeh_driver.c        |   19 
 arch/powerpc/platforms/pseries/iommu.c             |   28 
 arch/powerpc/platforms/pseries/pci_dlpar.c         |   14 
 arch/powerpc/platforms/pseries/plpar_wrappers.h    |    5 
 arch/powerpc/platforms/pseries/smp.c               |    3 
 arch/powerpc/platforms/pseries/xics.c              |   59 -
 arch/powerpc/platforms/pseries/xics.h              |    3 
 arch/powerpc/sysdev/Kconfig                        |    8 
 arch/powerpc/sysdev/Makefile                       |   13 
 arch/powerpc/sysdev/axonram.c                      |    5 
 arch/powerpc/sysdev/bestcomm/bestcomm.c            |   16 
 arch/powerpc/sysdev/bestcomm/bestcomm.h            |    2 
 arch/powerpc/sysdev/commproc.h                     |   12 
 arch/powerpc/sysdev/cpm1.c                         |   71 -
 arch/powerpc/sysdev/cpm2.c                         |   28 
 arch/powerpc/sysdev/fsl_pci.c                      |  154 +
 arch/powerpc/sysdev/fsl_rio.c                      |    0 
 arch/powerpc/sysdev/fsl_rio.h                      |    0 
 arch/powerpc/sysdev/fsl_soc.c                      |  232 ++
 arch/powerpc/sysdev/grackle.c                      |    2 
 arch/powerpc/sysdev/ipic.c                         |  287 ++-
 arch/powerpc/sysdev/ipic.h                         |   13 
 arch/powerpc/sysdev/micropatch.c                   |    2 
 arch/powerpc/sysdev/mmio_nvram.c                   |    2 
 arch/powerpc/sysdev/mpc8xx_pic.c                   |    1 
 arch/powerpc/sysdev/mpic.c                         |   70 +
 arch/powerpc/sysdev/mpic.h                         |   10 
 arch/powerpc/sysdev/mpic_pasemi_msi.c              |  172 ++
 arch/powerpc/sysdev/mv64x60_dev.c                  |   24 
 arch/powerpc/sysdev/mv64x60_pci.c                  |    4 
 arch/powerpc/sysdev/mv64x60_udbg.c                 |    4 
 arch/powerpc/sysdev/of_rtc.c                       |   59 +
 arch/powerpc/sysdev/pmi.c                          |    4 
 arch/powerpc/sysdev/ppc4xx_pci.c                   | 1528 ++++++++++++++
 arch/powerpc/sysdev/ppc4xx_pci.h                   |  369 +++
 arch/powerpc/sysdev/qe_lib/Kconfig                 |    2 
 arch/powerpc/sysdev/qe_lib/qe.c                    |  356 +++
 arch/powerpc/sysdev/qe_lib/ucc_slow.c              |   10 
 arch/powerpc/sysdev/tsi108_dev.c                   |    9 
 arch/powerpc/sysdev/uic.c                          |  132 -
 arch/powerpc/sysdev/xilinx_intc.c                  |    8 
 arch/powerpc/xmon/setjmp.S                         |   61 -
 arch/powerpc/xmon/xmon.c                           |   75 +
 arch/ppc/8260_io/enet.c                            |    2 
 arch/ppc/8xx_io/commproc.c                         |   40 
 arch/ppc/8xx_io/enet.c                             |    6 
 arch/ppc/8xx_io/fec.c                              |    2 
 arch/ppc/8xx_io/micropatch.c                       |    2 
 arch/ppc/Kconfig                                   |   91 -
 arch/ppc/Makefile                                  |    9 
 arch/ppc/boot/simple/iic.c                         |    2 
 arch/ppc/boot/simple/m8xx_tty.c                    |    2 
 arch/ppc/configs/TQM8541_defconfig                 |  986 ---------
 arch/ppc/configs/TQM8555_defconfig                 |  983 ---------
 arch/ppc/configs/mpc834x_sys_defconfig             |  844 --------
 arch/ppc/configs/mpc8540_ads_defconfig             |  706 ------
 arch/ppc/configs/mpc8548_cds_defconfig             |  658 ------
 arch/ppc/configs/mpc8555_cds_defconfig             |  784 -------
 arch/ppc/configs/mpc8560_ads_defconfig             |  769 -------
 arch/ppc/kernel/Makefile                           |    2 
 arch/ppc/kernel/asm-offsets.c                      |    6 
 arch/ppc/kernel/entry.S                            |   12 
 arch/ppc/kernel/head_44x.S                         |    2 
 arch/ppc/kernel/head_booke.h                       |   55 -
 arch/ppc/kernel/head_fsl_booke.S                   | 1065 ----------
 arch/ppc/kernel/misc.S                             |   46 
 arch/ppc/kernel/ppc_ksyms.c                        |   11 
 arch/ppc/kernel/setup.c                            |    4 
 arch/ppc/kernel/traps.c                            |  185 --
 arch/ppc/mm/44x_mmu.c                              |   51 
 arch/ppc/mm/Makefile                               |    1 
 arch/ppc/mm/fsl_booke_mmu.c                        |  236 --
 arch/ppc/mm/init.c                                 |    6 
 arch/ppc/mm/mmu_context.c                          |    2 
 arch/ppc/mm/mmu_decl.h                             |    6 
 arch/ppc/mm/pgtable.c                              |   28 
 arch/ppc/mm/ppc_mmu.c                              |    2 
 arch/ppc/platforms/83xx/Makefile                   |    4 
 arch/ppc/platforms/83xx/mpc834x_sys.c              |  326 ---
 arch/ppc/platforms/83xx/mpc834x_sys.h              |   54 
 arch/ppc/platforms/85xx/Kconfig                    |  106 -
 arch/ppc/platforms/85xx/Makefile                   |   13 
 arch/ppc/platforms/85xx/mpc8540_ads.c              |  226 --
 arch/ppc/platforms/85xx/mpc8540_ads.h              |   22 
 arch/ppc/platforms/85xx/mpc8555_cds.h              |   23 
 arch/ppc/platforms/85xx/mpc8560_ads.c              |  303 ---
 arch/ppc/platforms/85xx/mpc8560_ads.h              |   24 
 arch/ppc/platforms/85xx/mpc85xx_ads_common.c       |  198 --
 arch/ppc/platforms/85xx/mpc85xx_ads_common.h       |   67 -
 arch/ppc/platforms/85xx/mpc85xx_cds_common.c       |  601 ------
 arch/ppc/platforms/85xx/mpc85xx_cds_common.h       |   80 -
 arch/ppc/platforms/85xx/sbc8560.c                  |  234 --
 arch/ppc/platforms/85xx/sbc8560.h                  |   47 
 arch/ppc/platforms/85xx/sbc85xx.c                  |  166 --
 arch/ppc/platforms/85xx/sbc85xx.h                  |   70 -
 arch/ppc/platforms/85xx/stx_gp3.c                  |  340 ---
 arch/ppc/platforms/85xx/stx_gp3.h                  |   69 -
 arch/ppc/platforms/85xx/tqm85xx.c                  |  391 ----
 arch/ppc/platforms/85xx/tqm85xx.h                  |   53 
 arch/ppc/platforms/ev64260.c                       |    4 
 arch/ppc/platforms/mpc866ads_setup.c               |    2 
 arch/ppc/platforms/mpc885ads_setup.c               |    2 
 arch/ppc/platforms/prep_pci.c                      |    1 
 arch/ppc/syslib/Makefile                           |   14 
 arch/ppc/syslib/gt64260_pic.c                      |    1 
 arch/ppc/syslib/ipic.c                             |  646 ------
 arch/ppc/syslib/ipic.h                             |   47 
 arch/ppc/syslib/mpc52xx_pic.c                      |    1 
 arch/ppc/syslib/mpc52xx_setup.c                    |   36 
 arch/ppc/syslib/mpc83xx_devices.c                  |  251 --
 arch/ppc/syslib/mpc83xx_sys.c                      |  122 -
 arch/ppc/syslib/mpc85xx_devices.c                  |  826 --------
 arch/ppc/syslib/mpc85xx_sys.c                      |  233 --
 arch/ppc/syslib/mpc8xx_devices.c                   |    2 
 arch/ppc/syslib/mv64360_pic.c                      |    1 
 arch/ppc/syslib/ocp.c                              |    4 
 arch/ppc/syslib/open_pic.c                         |    2 
 arch/ppc/syslib/ppc83xx_pci.h                      |  151 -
 arch/ppc/syslib/ppc83xx_setup.c                    |  411 ----
 arch/ppc/syslib/ppc83xx_setup.h                    |   55 -
 arch/ppc/syslib/ppc85xx_common.c                   |   38 
 arch/ppc/syslib/ppc85xx_common.h                   |   22 
 arch/ppc/syslib/ppc85xx_setup.c                    |  367 ---
 arch/ppc/syslib/ppc85xx_setup.h                    |   56 -
 arch/ppc/syslib/ppc8xx_pic.c                       |    2 
 arch/ppc/syslib/ppc8xx_pic.h                       |    1 
 arch/ppc/syslib/ppc_sys.c                          |    2 
 arch/ppc/xmon/start.c                              |    1 
 arch/ppc/xmon/start_8xx.c                          |    2 
 drivers/ata/Kconfig                                |   14 
 drivers/ata/Makefile                               |    1 
 drivers/ata/pata_mpc52xx.c                         |    6 
 drivers/ata/pata_of_platform.c                     |  114 +
 drivers/ata/pata_platform.c                        |  144 +
 drivers/char/hw_random/Kconfig                     |    2 
 drivers/char/hw_random/pasemi-rng.c                |    7 
 drivers/edac/pasemi_edac.c                         |    4 
 drivers/macintosh/adb.c                            |  174 +-
 drivers/macintosh/mediabay.c                       |   14 
 drivers/macintosh/therm_adt746x.c                  |   24 
 drivers/macintosh/therm_pm72.c                     |   64 -
 drivers/macintosh/therm_windtunnel.c               |   42 
 drivers/macintosh/via-pmu-backlight.c              |   48 
 drivers/macintosh/via-pmu.c                        |  664 ++----
 drivers/net/Kconfig                                |    2 
 drivers/net/fec_8xx/fec_8xx-netta.c                |    2 
 drivers/net/fec_8xx/fec_main.c                     |    2 
 drivers/net/fec_8xx/fec_mii.c                      |    2 
 drivers/net/fec_mpc52xx.c                          |    6 
 drivers/net/fec_mpc52xx_phy.c                      |    8 
 drivers/net/fs_enet/fs_enet-main.c                 |    9 
 drivers/net/fs_enet/fs_enet.h                      |    2 
 drivers/net/fs_enet/mac-fcc.c                      |   10 
 drivers/net/fs_enet/mac-fec.c                      |    2 
 drivers/net/fs_enet/mac-scc.c                      |   13 
 drivers/net/ibm_newemac/core.c                     |    1 
 drivers/net/phy/Kconfig                            |   32 
 drivers/net/phy/fixed.c                            |  445 ++--
 drivers/net/ps3_gelic_net.c                        |    4 
 drivers/net/ucc_geth.c                             |   55 -
 drivers/net/ucc_geth_mii.c                         |    3 
 drivers/of/base.c                                  |   58 +
 drivers/of/device.c                                |   29 
 drivers/pci/Makefile                               |    2 
 drivers/pci/hotplug/rpadlpar_core.c                |    2 
 drivers/ps3/Makefile                               |    1 
 drivers/ps3/ps3-lpm.c                              | 1248 +++++++++++
 drivers/ps3/ps3-sys-manager.c                      |   14 
 drivers/ps3/ps3-vuart.c                            |   38 
 drivers/rapidio/rio.c                              |    5 
 drivers/serial/Kconfig                             |   10 
 drivers/serial/Makefile                            |    1 
 drivers/serial/cpm_uart/cpm_uart_cpm1.c            |    6 
 drivers/serial/cpm_uart/cpm_uart_cpm1.h            |    2 
 drivers/serial/cpm_uart/cpm_uart_cpm2.c            |   10 
 drivers/serial/mpc52xx_uart.c                      |  217 +-
 drivers/serial/uartlite.c                          |    6 
 drivers/serial/ucc_uart.c                          | 1514 ++++++++++++++
 drivers/spi/mpc52xx_psc_spi.c                      |   77 -
 drivers/spi/spi_mpc83xx.c                          |    6 
 drivers/usb/host/ohci-ppc-of.c                     |    2 
 include/asm-powerpc/8xx_immap.h                    |    2 
 include/asm-powerpc/cpm.h                          |   74 +
 include/asm-powerpc/cpm1.h                         |   79 -
 include/asm-powerpc/cpm2.h                         |   64 -
 include/asm-powerpc/cputable.h                     |   13 
 include/asm-powerpc/cputhreads.h                   |   71 +
 include/asm-powerpc/dcr-native.h                   |   30 
 include/asm-powerpc/dcr-regs.h                     |   71 +
 include/asm-powerpc/dma-mapping.h                  |   10 
 include/asm-powerpc/firmware.h                     |    2 
 include/asm-powerpc/immap_86xx.h                   |   25 
 include/asm-powerpc/immap_qe.h                     |   34 
 include/asm-powerpc/io.h                           |    5 
 include/asm-powerpc/iommu.h                        |    3 
 include/asm-powerpc/ipic.h                         |   12 
 include/asm-powerpc/irq.h                          |  212 --
 include/asm-powerpc/iseries/hv_lp_event.h          |    2 
 include/asm-powerpc/kexec.h                        |    3 
 include/asm-powerpc/lmb.h                          |    1 
 include/asm-powerpc/machdep.h                      |   58 -
 include/asm-powerpc/mmu-hash64.h                   |    7 
 include/asm-powerpc/mpc52xx.h                      |   16 
 include/asm-powerpc/mpc52xx_psc.h                  |    3 
 include/asm-powerpc/mpc8260.h                      |    1 
 include/asm-powerpc/mpc8xx.h                       |   20 
 include/asm-powerpc/mpic.h                         |   20 
 include/asm-powerpc/nvram.h                        |   11 
 include/asm-powerpc/of_platform.h                  |   14 
 include/asm-powerpc/pci-bridge.h                   |  199 +-
 include/asm-powerpc/pci.h                          |   29 
 include/asm-powerpc/pgalloc-64.h                   |    5 
 include/asm-powerpc/pgtable-64k.h                  |   39 
 include/asm-powerpc/ppc-pci.h                      |    4 
 include/asm-powerpc/prom.h                         |    4 
 include/asm-powerpc/ps3.h                          |   74 +
 include/asm-powerpc/ptrace.h                       |    3 
 include/asm-powerpc/qe.h                           |  156 +
 include/asm-powerpc/reg.h                          |    7 
 include/asm-powerpc/reg_booke.h                    |   18 
 include/asm-powerpc/setjmp.h                       |   18 
 include/asm-powerpc/smu.h                          |  142 +
 include/asm-powerpc/sparsemem.h                    |    5 
 include/asm-powerpc/spu.h                          |   28 
 include/asm-powerpc/spu_csa.h                      |   13 
 include/asm-powerpc/spu_priv1.h                    |   15 
 include/asm-powerpc/systbl.h                       |    1 
 include/asm-powerpc/system.h                       |    2 
 include/asm-powerpc/udbg.h                         |    1 
 include/asm-powerpc/unistd.h                       |    3 
 include/asm-ppc/8xx_immap.h                        |    2 
 include/asm-ppc/cpm1.h                             |   14 
 include/asm-ppc/cpm2.h                             |    2 
 include/asm-ppc/immap_85xx.h                       |  126 -
 include/asm-ppc/mmu.h                              |    6 
 include/asm-ppc/mmu_context.h                      |    5 
 include/asm-ppc/mpc52xx_psc.h                      |    3 
 include/asm-ppc/mpc83xx.h                          |  107 -
 include/asm-ppc/mpc85xx.h                          |  192 --
 include/asm-ppc/pgtable.h                          |   46 
 include/asm-ppc/ppc_sys.h                          |    4 
 include/asm-ppc/ppcboot.h                          |    8 
 include/asm-ppc/reg_booke.h                        |   30 
 include/asm-ppc/serial.h                           |    4 
 include/linux/of.h                                 |   12 
 include/linux/of_device.h                          |    2 
 include/linux/pata_platform.h                      |    9 
 include/linux/phy_fixed.h                          |   51 
 include/linux/pmu.h                                |   36 
 kernel/sys_ni.c                                    |    1 
 615 files changed, 51820 insertions(+), 30363 deletions(-)
 create mode 100644 Documentation/powerpc/qe_firmware.txt
 create mode 100644 arch/powerpc/boot/cuboot-824x.c
 create mode 100644 arch/powerpc/boot/cuboot-85xx-cpm2.c
 create mode 100644 arch/powerpc/boot/cuboot-katmai.c
 create mode 100644 arch/powerpc/boot/cuboot-rainier.c
 create mode 100644 arch/powerpc/boot/cuboot-taishan.c
 create mode 100644 arch/powerpc/boot/cuboot-warp.c
 create mode 100644 arch/powerpc/boot/dtc-src/.gitignore
 create mode 100644 arch/powerpc/boot/dtc-src/Makefile.dtc
 create mode 100644 arch/powerpc/boot/dtc-src/checks.c
 create mode 100644 arch/powerpc/boot/dtc-src/data.c
 create mode 100644 arch/powerpc/boot/dtc-src/dtc-lexer.l
 create mode 100644 arch/powerpc/boot/dtc-src/dtc-lexer.lex.c_shipped
 create mode 100644 arch/powerpc/boot/dtc-src/dtc-parser.tab.c_shipped
 create mode 100644 arch/powerpc/boot/dtc-src/dtc-parser.tab.h_shipped
 create mode 100644 arch/powerpc/boot/dtc-src/dtc-parser.y
 create mode 100644 arch/powerpc/boot/dtc-src/dtc.c
 create mode 100644 arch/powerpc/boot/dtc-src/dtc.h
 create mode 100644 arch/powerpc/boot/dtc-src/flattree.c
 create mode 100644 arch/powerpc/boot/dtc-src/fstree.c
 create mode 100644 arch/powerpc/boot/dtc-src/livetree.c
 create mode 100644 arch/powerpc/boot/dtc-src/srcpos.c
 create mode 100644 arch/powerpc/boot/dtc-src/srcpos.h
 create mode 100644 arch/powerpc/boot/dtc-src/treesource.c
 create mode 100644 arch/powerpc/boot/dtc-src/version_gen.h
 create mode 100644 arch/powerpc/boot/dts/adder875-redboot.dts
 create mode 100644 arch/powerpc/boot/dts/adder875-uboot.dts
 create mode 100644 arch/powerpc/boot/dts/cm5200.dts
 create mode 100644 arch/powerpc/boot/dts/ep405.dts
 create mode 100644 arch/powerpc/boot/dts/ep8248e.dts
 create mode 100644 arch/powerpc/boot/dts/haleakala.dts
 create mode 100644 arch/powerpc/boot/dts/katmai.dts
 create mode 100644 arch/powerpc/boot/dts/makalu.dts
 create mode 100644 arch/powerpc/boot/dts/motionpro.dts
 create mode 100644 arch/powerpc/boot/dts/mpc8315erdb.dts
 create mode 100644 arch/powerpc/boot/dts/mpc8377_mds.dts
 create mode 100644 arch/powerpc/boot/dts/mpc8377_rdb.dts
 create mode 100644 arch/powerpc/boot/dts/mpc8378_mds.dts
 create mode 100644 arch/powerpc/boot/dts/mpc8378_rdb.dts
 create mode 100644 arch/powerpc/boot/dts/mpc8379_mds.dts
 create mode 100644 arch/powerpc/boot/dts/mpc8379_rdb.dts
 create mode 100644 arch/powerpc/boot/dts/rainier.dts
 create mode 100644 arch/powerpc/boot/dts/sbc8349.dts
 create mode 100644 arch/powerpc/boot/dts/sbc8548.dts
 create mode 100644 arch/powerpc/boot/dts/sbc8560.dts
 create mode 100644 arch/powerpc/boot/dts/storcenter.dts
 create mode 100644 arch/powerpc/boot/dts/stx_gp3_8560.dts
 create mode 100644 arch/powerpc/boot/dts/taishan.dts
 create mode 100644 arch/powerpc/boot/dts/tqm5200.dts
 create mode 100644 arch/powerpc/boot/dts/tqm8540.dts
 create mode 100644 arch/powerpc/boot/dts/tqm8541.dts
 create mode 100644 arch/powerpc/boot/dts/tqm8555.dts
 create mode 100644 arch/powerpc/boot/dts/tqm8560.dts
 create mode 100644 arch/powerpc/boot/dts/warp.dts
 create mode 100644 arch/powerpc/boot/ep405.c
 create mode 100644 arch/powerpc/boot/ep8248e.c
 delete mode 100644 arch/powerpc/boot/flatdevtree.c
 delete mode 100644 arch/powerpc/boot/flatdevtree.h
 delete mode 100644 arch/powerpc/boot/flatdevtree_misc.c
 create mode 100644 arch/powerpc/boot/libfdt-wrapper.c
 create mode 100644 arch/powerpc/boot/libfdt/Makefile.libfdt
 create mode 100644 arch/powerpc/boot/libfdt/fdt.c
 create mode 100644 arch/powerpc/boot/libfdt/fdt.h
 create mode 100644 arch/powerpc/boot/libfdt/fdt_ro.c
 create mode 100644 arch/powerpc/boot/libfdt/fdt_rw.c
 create mode 100644 arch/powerpc/boot/libfdt/fdt_strerror.c
 create mode 100644 arch/powerpc/boot/libfdt/fdt_sw.c
 create mode 100644 arch/powerpc/boot/libfdt/fdt_wip.c
 create mode 100644 arch/powerpc/boot/libfdt/libfdt.h
 create mode 100644 arch/powerpc/boot/libfdt/libfdt_internal.h
 create mode 100644 arch/powerpc/boot/libfdt_env.h
 create mode 100644 arch/powerpc/boot/redboot-8xx.c
 create mode 100644 arch/powerpc/boot/redboot.h
 copy arch/powerpc/configs/{lite5200_defconfig => adder875-redboot_defconfig} (54%)
 copy arch/powerpc/configs/{lite5200_defconfig => adder875-uboot_defconfig} (54%)
 copy arch/powerpc/configs/{lite5200_defconfig => ep405_defconfig} (63%)
 copy arch/powerpc/configs/{lite5200_defconfig => ep8248e_defconfig} (52%)
 copy arch/powerpc/configs/{lite5200_defconfig => katmai_defconfig} (68%)
 copy arch/powerpc/configs/{lite5200_defconfig => makalu_defconfig} (63%)
 create mode 100644 arch/powerpc/configs/mpc5200_defconfig
 create mode 100644 arch/powerpc/configs/mpc8315_rdb_defconfig
 copy arch/powerpc/configs/{lite5200_defconfig => mpc837x_mds_defconfig} (61%)
 copy arch/powerpc/configs/{lite5200_defconfig => mpc837x_rdb_defconfig} (60%)
 copy arch/powerpc/configs/{lite5200_defconfig => mpc83xx_defconfig} (62%)
 create mode 100644 arch/powerpc/configs/mpc85xx_defconfig
 copy arch/powerpc/configs/{lite5200_defconfig => rainier_defconfig} (67%)
 copy arch/powerpc/configs/{lite5200_defconfig => sbc834x_defconfig} (58%)
 copy arch/powerpc/configs/{lite5200_defconfig => sbc8548_defconfig} (63%)
 copy arch/powerpc/configs/{lite5200_defconfig => sbc8560_defconfig} (60%)
 copy arch/powerpc/configs/{lite5200_defconfig => storcenter_defconfig} (51%)
 rename arch/{ppc/configs/stx_gp3_defconfig => powerpc/configs/stx_gp3_defconfig} (54%)
 rename arch/powerpc/configs/{lite5200_defconfig => taishan_defconfig} (68%)
 rename arch/{ppc/configs/TQM8540_defconfig => powerpc/configs/tqm8540_defconfig} (66%)
 copy arch/{ppc/configs/TQM8560_defconfig => powerpc/configs/tqm8541_defconfig} (66%)
 copy arch/{ppc/configs/TQM8560_defconfig => powerpc/configs/tqm8555_defconfig} (66%)
 rename arch/{ppc/configs/TQM8560_defconfig => powerpc/configs/tqm8560_defconfig} (66%)
 create mode 100644 arch/powerpc/configs/warp_defconfig
 rename arch/{ppc/kernel/rio.c => powerpc/kernel/rio.c} (100%)
 create mode 100644 arch/powerpc/kernel/systbl_chk.c
 create mode 100644 arch/powerpc/kernel/systbl_chk.sh
 create mode 100644 arch/powerpc/mm/subpage-prot.c
 create mode 100644 arch/powerpc/platforms/40x/ep405.c
 create mode 100644 arch/powerpc/platforms/40x/makalu.c
 create mode 100644 arch/powerpc/platforms/44x/katmai.c
 create mode 100644 arch/powerpc/platforms/44x/rainier.c
 create mode 100644 arch/powerpc/platforms/44x/taishan.c
 create mode 100644 arch/powerpc/platforms/44x/warp-nand.c
 create mode 100644 arch/powerpc/platforms/44x/warp.c
 create mode 100644 arch/powerpc/platforms/52xx/mpc5200_simple.c
 create mode 100644 arch/powerpc/platforms/82xx/ep8248e.c
 rename arch/powerpc/platforms/83xx/{mpc8313_rdb.c => mpc831x_rdb.c} (58%)
 create mode 100644 arch/powerpc/platforms/83xx/mpc837x_mds.c
 create mode 100644 arch/powerpc/platforms/83xx/mpc837x_rdb.c
 create mode 100644 arch/powerpc/platforms/83xx/sbc834x.c
 create mode 100644 arch/powerpc/platforms/85xx/sbc8548.c
 create mode 100644 arch/powerpc/platforms/85xx/sbc8560.c
 create mode 100644 arch/powerpc/platforms/85xx/stx_gp3.c
 create mode 100644 arch/powerpc/platforms/85xx/tqm85xx.c
 create mode 100644 arch/powerpc/platforms/8xx/adder875.c
 create mode 100644 arch/powerpc/platforms/8xx/mpc8xx.h
 create mode 100644 arch/powerpc/platforms/cell/spu_fault.c
 create mode 100644 arch/powerpc/platforms/embedded6xx/storcenter.c
 delete mode 100644 arch/powerpc/platforms/iseries/vpdinfo.c
 delete mode 100644 arch/powerpc/platforms/pasemi/electra_ide.c
 create mode 100644 arch/powerpc/sysdev/Kconfig
 delete mode 100644 arch/powerpc/sysdev/commproc.h
 rename arch/powerpc/sysdev/{commproc.c => cpm1.c} (92%)
 rename arch/powerpc/sysdev/{cpm2_common.c => cpm2.c} (95%)
 rename arch/{ppc/syslib/ppc85xx_rio.c => powerpc/sysdev/fsl_rio.c} (100%)
 rename arch/{ppc/syslib/ppc85xx_rio.h => powerpc/sysdev/fsl_rio.h} (100%)
 create mode 100644 arch/powerpc/sysdev/mpic_pasemi_msi.c
 create mode 100644 arch/powerpc/sysdev/of_rtc.c
 create mode 100644 arch/powerpc/sysdev/ppc4xx_pci.c
 create mode 100644 arch/powerpc/sysdev/ppc4xx_pci.h
 delete mode 100644 arch/ppc/configs/TQM8541_defconfig
 delete mode 100644 arch/ppc/configs/TQM8555_defconfig
 delete mode 100644 arch/ppc/configs/mpc834x_sys_defconfig
 delete mode 100644 arch/ppc/configs/mpc8540_ads_defconfig
 delete mode 100644 arch/ppc/configs/mpc8548_cds_defconfig
 delete mode 100644 arch/ppc/configs/mpc8555_cds_defconfig
 delete mode 100644 arch/ppc/configs/mpc8560_ads_defconfig
 delete mode 100644 arch/ppc/kernel/head_fsl_booke.S
 delete mode 100644 arch/ppc/mm/fsl_booke_mmu.c
 delete mode 100644 arch/ppc/platforms/83xx/Makefile
 delete mode 100644 arch/ppc/platforms/83xx/mpc834x_sys.c
 delete mode 100644 arch/ppc/platforms/83xx/mpc834x_sys.h
 delete mode 100644 arch/ppc/platforms/85xx/Kconfig
 delete mode 100644 arch/ppc/platforms/85xx/Makefile
 delete mode 100644 arch/ppc/platforms/85xx/mpc8540_ads.c
 delete mode 100644 arch/ppc/platforms/85xx/mpc8540_ads.h
 delete mode 100644 arch/ppc/platforms/85xx/mpc8555_cds.h
 delete mode 100644 arch/ppc/platforms/85xx/mpc8560_ads.c
 delete mode 100644 arch/ppc/platforms/85xx/mpc8560_ads.h
 delete mode 100644 arch/ppc/platforms/85xx/mpc85xx_ads_common.c
 delete mode 100644 arch/ppc/platforms/85xx/mpc85xx_ads_common.h
 delete mode 100644 arch/ppc/platforms/85xx/mpc85xx_cds_common.c
 delete mode 100644 arch/ppc/platforms/85xx/mpc85xx_cds_common.h
 delete mode 100644 arch/ppc/platforms/85xx/sbc8560.c
 delete mode 100644 arch/ppc/platforms/85xx/sbc8560.h
 delete mode 100644 arch/ppc/platforms/85xx/sbc85xx.c
 delete mode 100644 arch/ppc/platforms/85xx/sbc85xx.h
 delete mode 100644 arch/ppc/platforms/85xx/stx_gp3.c
 delete mode 100644 arch/ppc/platforms/85xx/stx_gp3.h
 delete mode 100644 arch/ppc/platforms/85xx/tqm85xx.c
 delete mode 100644 arch/ppc/platforms/85xx/tqm85xx.h
 delete mode 100644 arch/ppc/syslib/ipic.c
 delete mode 100644 arch/ppc/syslib/ipic.h
 delete mode 100644 arch/ppc/syslib/mpc83xx_devices.c
 delete mode 100644 arch/ppc/syslib/mpc83xx_sys.c
 delete mode 100644 arch/ppc/syslib/mpc85xx_devices.c
 delete mode 100644 arch/ppc/syslib/mpc85xx_sys.c
 delete mode 100644 arch/ppc/syslib/ppc83xx_pci.h
 delete mode 100644 arch/ppc/syslib/ppc83xx_setup.c
 delete mode 100644 arch/ppc/syslib/ppc83xx_setup.h
 delete mode 100644 arch/ppc/syslib/ppc85xx_common.c
 delete mode 100644 arch/ppc/syslib/ppc85xx_common.h
 delete mode 100644 arch/ppc/syslib/ppc85xx_setup.c
 delete mode 100644 arch/ppc/syslib/ppc85xx_setup.h
 create mode 100644 drivers/ata/pata_of_platform.c
 create mode 100644 drivers/ps3/ps3-lpm.c
 create mode 100644 drivers/serial/ucc_uart.c
 rename include/asm-powerpc/{commproc.h => cpm1.h} (89%)
 create mode 100644 include/asm-powerpc/cputhreads.h
 create mode 100644 include/asm-powerpc/dcr-regs.h
 create mode 100644 include/asm-powerpc/setjmp.h
 rename include/asm-ppc/{commproc.h => cpm1.h} (98%)
 delete mode 100644 include/asm-ppc/immap_85xx.h
 delete mode 100644 include/asm-ppc/mpc83xx.h
 delete mode 100644 include/asm-ppc/mpc85xx.h

Aegis Lin (1):
      [POWERPC] spufs: Use separate timer for /proc/spu_loadavg calculation

Andre Detsch (2):
      [POWERPC] cell: safer of_has_vicinity routine
      [POWERPC] spufs: DMA Restart after SIGSEGV

Anton Vorontsov (8):
      libata: pata_platform: make probe and remove functions device type neutral
      libata: pata_of_platform: OF-Platform PATA device driver
      [POWERPC] booting-without-of: localbus should not include board name
      [POWERPC] MPC8349E-mITX: introduce localbus and pata nodes
      [POWERPC] QE: get rid of most device_types and model
      ucc_geth: get rid of device_type for mdio
      spi_mpc83xx: use brg-frequency for SPI in QE
      [POWERPC] fsl_spi: stop using device_type = "spi"

Arnd Bergmann (1):
      [POWERPC] spufs: block fault handlers in spu_acquire_runnable

Balbir Singh (1):
      [POWERPC] Fake NUMA emulation for PowerPC

Becky Bruce (1):
      [POWERPC] Fixup use of phys_addr_t in mpic code

Benjamin Herrenschmidt (51):
      [POWERPC] Cleanup SMT thread handling
      [POWERPC] Add xmon function to dump 44x TLB
      [POWERPC] Make isa_mem_base common to 32 and 64 bits
      [POWERPC] Merge pci_process_bridge_OF_ranges()
      [POWERPC] Fix powerpc 32-bit resource fixup for 64-bit resources
      [POWERPC] Change 32-bit PCI message about resource allocation
      [POWERPC] Remove useless volatiles in udbg_16550.c
      [POWERPC] Add of_translate_dma_address
      [POWERPC] Early debug forces console log level to max
      [POWERPC] pci32: Remove bogus alignment message
      [POWERPC] pci32: Use generic pci_assign_unassign_resources
      [POWERPC] pci32: Remove PowerMac P2P bridge IO hack
      [POWERPC] pci32: Add flags modifying the PCI code behaviour
      [POWERPC] pci32: Remove obsolete PowerMac bus number hack
      [POWERPC] pci32: Add platform option to enable /proc PCI domains
      [POWERPC] Merge pcibios_resource_to_bus/bus_to_resource
      [POWERPC] Merge PCI resource fixups
      [POWERPC] Merge PCI resource allocation & assignment
      [POWERPC] fix iSeries PCI resource management
      [POWERPC] Updates/fixes to 32 bits pcibios_enable_device()
      [POWERPC] Merge 32 and 64 bits pcibios_enable_device
      [POWERPC] Fixup powermac enable device hook
      [POWERPC] Clear pci_probe_only on 64 bits PowerMac
      [POWERPC] Various fixes to pcibios_enable_device()
      [POWERPC] Enable self-view of the HT host bridge on PowerMac G5
      [POWERPC] Improve resource setup of PowerMac G5 HT bridge
      [POWERPC] Fixup skipping of PowerMac PCI<->PCI bridge "closed" resources
      [POWERPC] Disable PCI IO/Mem on a device when resources can't be allocated
      [POWERPC] Fix PCI IRQ fallback code to not map IRQ 0
      [POWERPC] Fix for via-pmu based backlight control
      [POWERPC] Fix possible NULL deref in ppc32 PCI
      [POWERPC] Reworking machine check handling and Fix 440/440A
      [POWERPC] 4xx: Improve support for 4xx indirect DCRs
      [POWERPC] 4xx: PLB to PCI-X support
      [POWERPC] 4xx: PLB to PCI 2.x support
      [POWERPC] 4xx: PLB to PCI Express support
      [POWERPC] 4xx: PCI support for Ebony board
      [POWERPC] 4xx: Add early udbg support for 40x processors
      [POWERPC] 4xx: EP405 boards support for arch/powerpc
      [POWERPC] 4xx: Add PCI to Walnut platform
      [POWERPC] 4xx: Wire up PCI on Bamboo board
      [POWERPC] 4xx: Wire up 440EP USB controller support to Bamboo board
      [POWERPC] 4xx: Adds decoding of 440SPE memory size to boot wrapper library
      [POWERPC] 4xx: Add mfspr/mtspr inline macros to 4xx bootwrapper
      [POWERPC] 4xx: Add CPR0 accessors to boot wrapper
      [POWERPC] 4xx: Rework clock probing in boot wrapper
      [POWERPC] 4xx: Base support for 440SPe "Katmai" eval board
      [POWERPC] 4xx: remove bogus "ranges" property in Bamboo EBC node
      [POWERPC] 4xx: PCI-E Link setup improvements
      [POWERPC] pci32: 4xx embedded platforms want to reassign all PCI resources
      [POWERPC] Always hookup PHB IO resource even when empty

Bob Nelson (1):
      [POWERPC] OProfile: fix cbe pm signal routing problem

Christoph Hellwig (2):
      [POWERPC] spufs: add enchanced simple attr macros
      [POWERPC] spufs: make state_mutex interruptible

Cyrill Gorcunov (5):
      [POWERPC] CELLEB: Fix possible NULL pointer dereference
      [POWERPC] CHRP: Fix possible NULL pointer dereference
      [POWERPC] Use for_each macros in arch/powerpc/sysdev
      [POWERPC] Use for_each macros in arch/powerpc/kernel
      [POWERPC] Use for_each macros in arch/powerpc/platforms/powermac

Dale Farnsworth (1):
      [POWERPC] 85xx: Respect KERNELBASE, PAGE_OFFSET, and PHYSICAL_START on e500

David Gibson (6):
      [POWERPC] Merge libfdt upstream source
      [POWERPC] Use embedded libfdt in the bootwrapper
      [POWERPC] Kill flatdevtree.c
      [POWERPC] Merge dtc upstream source
      [POWERPC] Use embedded dtc in kernel builds
      [POWERPC] Enable RTC for Ebony and Walnut (v2)

David Woodhouse (4):
      [POWERPC] Create otheros.bld next to specified output file, not in $object directory
      [POWERPC] Find device-tree source file in default directory
      [POWERPC] Allow for bootwrapper utilities being in different directory to objects
      [POWERPC] Implement 'make bootwrapper_install'

Emil Medve (1):
      [POWERPC] Optimize counting distinct entries in the relocation sections

Geert Uytterhoeven (10):
      [POWERPC] Kill sparse warning in HPTE_V_COMPARE()
      [POWERPC] PS3: Make bus_id and dev_id u64
      [POWERPC] PS3: Add ps3_repository_find_device_by_id()
      [POWERPC] PS3: Use the HVs storage device notification mechanism properly
      [POWERPC] PS3: Add repository polling loop to work around timing bug
      [POWERPC] PS3: Kill unused ps3_repository_bump_device()
      [POWERPC] PS3: Refactor ps3_repository_find_device()
      [POWERPC] PS3: Checkpatch cleanups for drivers/ps3/ps3-sys-manager.c
      [POWERPC] PS3: Checkpatch cleanups for drivers/ps3/ps3-vuart.c
      [POWERPC] PS3: Checkpatch cleanups for arch/powerpc/platforms/ps3/repository.c

Geoff Levand (5):
      [POWERPC] Add definition of Cell bookmark SPR
      [POWERPC] PS3: Add logical performance monitor device support
      [POWERPC] PS3: Vuart: change semaphore to mutex
      [POWERPC] PS3: Remove lpar address workaround
      [POWERPC] PS3: Update ps3_defconfig

Grant Likely (16):
      [POWERPC] Add machine initcall macros
      [POWERPC] 4xx: typo in calling machine_device_initcall() for Sequoia board
      [POWERPC] pasemi: Use machine_*_initcall() hooks in platform code
      [POWERPC] Add of_find_matching_node() helper function
      [POWERPC] powermac: Use machine_*_initcall() hooks in platform code
      [POWERPC] cell: Use machine_*_initcall() hooks in platform code
      [POWERPC] mpc5200: eliminate mpc52xx_*_map_*() functions.
      [POWERPC] mpc5200: merge defconfigs for all mpc5200 boards
      [POWERPC] 8xx: Use machine_*_initcall() hooks in platform code
      [POWERPC] mpc52xx: clean up Kconfig
      [POWERPC] mpc5200: normalize compatible property bindings
      [POWERPC] mpc5200: make dts files conform to generic names recommended practice
      [POWERPC] Efika: prune fixups and make them more carefull
      [POWERPC] Add common clock setting routine mpc52xx_psc_set_clkdiv()
      [POWERPC] mpc52xx_psc_spi device driver must not touch port_config and cdm
      [POWERPC] 82xx and embedded6xx: Use machine_*_initcall() hooks in platform code

Hollis Blanchard (1):
      [POWERPC] 4xx: enable built-in networking for Sequoia defconfig

Hugh Blemings (1):
      [POWERPC] 4xx: Base support for 440GX Taishan eval board

Ishizaki Kou (6):
      [POWERPC] cell: Fix undefined reference to mmio_nvram_init
      [POWERPC] celleb: Add support for native CBE
      [POWERPC] Update celleb_defconfig to add support for native CBE
      [POWERPC] cell: add missing '\n'
      [POWERPC] Cleanup calling mmio_nvram_init
      [POWERPC] celleb: Split machine definition

Jeremy Kerr (11):
      [POWERPC] cell: export force_sig_info()
      [POWERPC] cell: handle kernel SLB setup in spu_base.c
      [POWERPC] cell: use spu_load_slb for SLB setup
      [POWERPC] cell: add spu_64k_pages_available() check
      [POWERPC] cell: handle SPE kernel mappings that cross segment boundaries
      [POWERPC] cell: catch errors from sysfs_create_group()
      [POWERPC] spufs: move fault, lscsa_alloc and switch code to spufs module
      [POWERPC] spufs: fix incorrect interrupt status clearing in backing mbox stat poll
      [POWERPC] spufs: use #defines for SPU class [012] exception status
      [POWERPC] spufs: rework class 0 and 1 interrupt handling
      [POWERPC] spufs: Don't leak kernel stack through an empty {i,m}box_info read

Jochen Friedrich (11):
      [POWERPC] Add support for PORTA and PORTB odr registers
      [POWERPC] Move CPM command handling into the cpm drivers
      [POWERPC] Update .gitignore files
      fs_enet: Add fixed-phy support for fs_enet
      [POWERPC] 8xx: Remove unused m8xx_cpm_hostalloc/free/dump()
      [POWERPC] 8xx: Rename m8xx_pic_init to mpc8xx_pics_init
      [POWERPC] 8xx: Remove unneeded and misspelled prototype m8xx_calibrate_decr
      [POWERPC] 8xx: Remove sysdev/commproc.h
      [POWERPC] 8xx: Get rid of conditional includes of board specific setup
      [POWERPC] CPM: Rename commproc to cpm1 and cpm2_common.c to cpm2.c
      [POWERPC] CPM: Move definition of buffer descriptor to cpm.h

Johannes Berg (6):
      [POWERPC] powermac: Fix warning in time.c
      [POWERPC] PMU: Don't lock_kernel()
      [POWERPC] PMU: Remove dead code
      [POWERPC] adb: Replace sleep notifier with platform driver suspend/resume hooks
      [POWERPC] via-pmu: Kill sleep notifiers completely
      [POWERPC] powermac: Use generic suspend code

John Rigby (4):
      [POWERPC] Separate MPC52xx PSC FIFO registers from rest of PSC
      [POWERPC] mpc5200: Cleanup checkpatch.pl problems in mpc52xx_uart.c
      [POWERPC] Add support for mpc512x interrupts to ipic
      [POWERPC] Add IPIC Kconfig option

Jon Loeliger (12):
      [POWERPC] Clean out asm/of_{platform, device}.h
      [POWERPC] Clean out asm/of_{platform, device}.h from sysdev/
      [POWERPC] 8xxx: Convert #include of asm/of_{platform, device}.h into linux/of_{platform, device}.h.
      [POWERPC] 86xx: Add aliases node to 8641hpcn DTS file.
      [POWERPC] cell: Convert #include of asm/of_{platform, device}.h into linux/of_{platform, device}.h.
      [POWERPC] Use <linux/of_{platform, device}.h> and not <asm/...> variants.
      [POWERPC] Add _nmask_and_or_msr() declartion to asm-powerpc/system.h
      [POWERPC] Add StorCenter DTS first draft.
      [POWERPC] Add initial iomega StorCenter board port.
      [POWERPC] Add initial storcenter config file.
      [POWERPC] 86xx: Convert all 86xx DTS files to /dts-v1/ format.
      [POWERPC] Convert StorCenter DTS file to /dts-v1/ format.

Jon Tollefson (1):
      [POWERPC] Add hugepagesz boot-time parameter

Joseph Fannin (1):
      [POWERPC] Export copy_page() on 32bit

Josh Boyer (11):
      [POWERPC] 4xx: Fix 440grx setup function to call 440A fixup
      [POWERPC] 4xx: Include missing header
      [POWERPC] 4xx: libfdt and pci fixes for Rainier
      [POWERPC] 4xx: Rename CPU nodes to avoid dtc incompatibility
      [POWERPC] 4xx: Update Kilauea, Rainier, and Walnut defconfigs
      [POWERPC] 4xx: Mark of_bus structures as __initdata
      [POWERPC] Conditionally compile e200 and e500 platforms in cputable
      [POWERPC] Remove unneeded variable declarations from mpc837x_mds
      [POWERPC] 4xx: Use machine_device_initcall for bus probe
      [POWERPC] 4xx: Minor coding style cleanups for 4xx bootwrapper
      [POWERPC] 4xx: Update defconfigs

Julia Lawall (3):
      [POWERPC] arch/ppc: Remove an unnecessary pci_dev_put
      [POWERPC] arch/powerpc: Add missing of_node_put
      [POWERPC] cell/cbe_regs.c: Add missing of_node_put

Julio M. Merino Vidal (1):
      [POWERPC] spufs: fix typos in sched.c comments

Kevin Corry (1):
      [POWERPC] perfmon2: make pm_interval register read/write

Kim Phillips (10):
      [POWERPC] 83xx: fold the mpc8313 platform into the mpc831x platform
      [POWERPC] 83xx: add base platform support for the mpc8315 rdb board
      [POWERPC] 83xx: Add the MPC8315E RDB dts
      [POWERPC] 83xx: enable FSL SATA driver config for Freescale SoCs
      [POWERPC] 83xx: ipic: add interrupt vector 94
      [POWERPC] 83xx: add the mpc8315 rdb defconfig
      [POWERPC] 83xx: add MPC837x RDB platform support
      [POWERPC] 83xx: add the mpc837[789]_rdb dts files
      [POWERPC] 83xx: add the mpc837x rdb defconfig
      [POWERPC] 83xx: Fix typo in mpc837x compatible entries

Kumar Gala (31):
      [POWERPC] Add SPRN for Embedded registers specified in PowerISA 2.04
      [POWERPC] Emulate isel (Integer Select) instruction
      [POWERPC] FSL: I2C device tree cleanups
      [POWERPC] FSL: enet device tree cleanups
      [POWERPC] FSL: Added aliases node to device trees
      [POWERPC] Fix handling of memreserve if the range lands in highmem
      [POWERPC] Ensure we only handle PowerMac PCI bus fixup for memory resources
      [POWERPC] Fixup transparent P2P resources
      [POWERPC] FSL: Rework PCI/PCIe support for 85xx/86xx
      [POWERPC] Remove update_bridge_resource
      [POWERPC] 85xx: convert boards to use machine_device_initcall
      [POWERPC] 83xx: convert boards to use machine_device_initcall
      [POWERPC] bootwrapper: Add find_node_by_alias and dt_fixup_mac_address_by_alias
      [POWERPC] bootwrapper: convert cuboot-8{3,5}xx to dt_fixup_mac_address_by_alias
      [POWERPC] Fix incorrect interrupt map on FSL reference boards
      [RAPIDIO] Fix compile error and warning
      [POWERPC] Move RapidIO support code from arch/ppc
      [POWERPC] Fix compile error if CONFIG_STX_GP3 is defined
      [POWERPC] Always build setup-bus.c on powerpc
      [POWERPC] bootwrapper: Add find_node_by_compatible
      [POWERPC] Add a cuboot wrapper for 85xx with CPM2
      [POWERPC] 85xx: Port STX GP3 board over from arch/ppc
      [POWERPC] 85xx: Port TQM85xx boards over from arch/ppc
      [POWERPC] 85xx: some minor cleanups for stx_gp3 and tqm85xx
      [PPC] Remove 83xx from arch/ppc
      [PPC] Remove 85xx from arch/ppc
      [POWERPC] 86xx: Remove unused IRQ defines
      [POWERPC] 85xx: rework platform Kconfig
      [POWERPC] 83xx: rework platform Kconfig
      [POWERPC] 85xx: convert sbc85* boards to use machine_device_initcall
      [POWERPC] 85xx: Only invalidate TLB0 and TLB1

Li Yang (9):
      [POWERPC] add e300c4 entry to cputable
      [POWERPC] ipic: add new interrupts introduced by new chip
      [POWERPC] 83xx: Add platform support for MPC837x MDS board
      [POWERPC] 83xx: Add MPC837x MDS default kernel configuration
      [POWERPC] ipic: ack only for edge interrupts
      [POWERPC] 83xx: add device trees for MPC837x MDS board
      [POWERPC] 83xx: Add MPC837x USB platform support
      [POWERPC] 83xx: USB device tree cleanups
      [POWERPC] Add docs for Freescale PowerQUICC SATA device tree nodes

Li Zefan (1):
      [POWERPC] Don't cast a struct pointer to list_head pointer

Linas Vepstas (3):
      [POWERPC] EEH: Work with device endpoint, always
      [POWERPC] EEH: Be careful when identifying "empty" slots.
      [POWERPC] EEH: Report errors as soon as possible

Liu Yu (1):
      [POWERPC] Fix carry bug in 128-bit unsigned integer adding

Lucas Woods (2):
      [POWERPC] arch/powerpc: Remove duplicate includes
      [POWERPC] arch/ppc: Remove duplicate includes

Luke Browning (4):
      [POWERPC] spufs: add backing ops for privcntl register
      [POWERPC] spufs: reorganize spu_run_init
      [POWERPC] spufs: spu_find_victim may choose wrong victim
      [POWERPC] spufs: decouple spu scheduler from spufs_spu_run (asynchronous scheduling)

Marian Balakowicz (6):
      [POWERPC] mpc5200: Add 'fsl,lpb' bus type for localplus bus
      [POWERPC] mpc5200: Add common mpc52xx_setup_pci() routine
      [POWERPC] mpc5200: Add TQM5200 DTS
      [POWERPC] mpc5200: add CM5200 DTS
      [POWERPC] mpc5200: Add Promess Motion-PRO DTS
      [POWERPC] mpc5200: Add generic support for simple MPC5200 based boards

Mark A. Greer (1):
      [POWERPC] #address-cells & #size-cells properties are not inherited

Masato Noguchi (2):
      [POWERPC] cell: wrap master run control bit
      [POWERPC] spufs: don't set reserved bits in spu interrupt status

Matthias Fuchs (1):
      [POWERPC] 4xx: Add 405GPr and 405EP support in boot wrapper

Michael Ellerman (18):
      [POWERPC] Add for_each_child_of_node() helper for iterating over child nodes
      [POWERPC] Implement pci_set_dma_mask() in terms of the dma_ops
      [POWERPC] Set archdata.dma_data for direct DMA in cell_dma_dev_setup()
      [POWERPC] Add celleb_dma_dev_setup()
      [POWERPC] Use archdata.dma_data in dma_direct_ops and add the offset
      [POWERPC] Have cell use its own dma_direct_offset variable
      [POWERPC] Have celleb use its own dma_direct_offset variable
      [POWERPC] Remove the global dma_direct_offset
      [POWERPC] Remove bogus comment in dma_direct_alloc_coherent()
      [POWERPC] Make IOMMU code safe for > 132 GB of memory
      [POWERPC] Add set_dma_ops() to match get_dma_ops()
      [POWERPC] Allocate the hash table under 1G on cell
      [POWERPC] Split out the logic that allocates struct iommus
      [POWERPC] Split cell_iommu_setup_hardware() into two parts
      [POWERPC] Split out the IOMMU logic from cell_dma_dev_setup()
      [POWERPC] Add support to cell_iommu_setup_page_tables() for multiple windows
      [POWERPC] Split out the ioid fetching/checking logic
      [POWERPC] Cell IOMMU fixed mapping support

Michael Hanselmann (1):
      [POWERPC] Update smu command definitions

Michael Neuling (3):
      [POWERPC] Use SLB size from the device tree
      [POWERPC] Make setjmp/longjmp code usable outside of xmon
      [POWERPC] kdump shutdown hook support

Milton Miller (6):
      [POWERPC] Push down or eliminate smp_processor_id calls in xics code
      [POWERPC] init_decrementer_clockevent can be static __init
      [POWERPC] Use __get_cpu_var in time.c
      [POWERPC] Timer interrupt: use a struct for two per_cpu varables
      [POWERPC] Depend on ->initialized in calc_steal_time
      [POWERPC] Optimize account_system_vtime

Nathan Lynch (2):
      [POWERPC] Remove prod_processor()
      [POWERPC] lparcfg: Remove useless buffer allocation

Olaf Hering (2):
      [POWERPC] Revert chrp_pci_fixup_vt8231_ata devinit to fix libata on pegasos
      [POWERPC] Autodetect serial console on pegasos2

Olof Johansson (15):
      [POWERPC] pasemi: clean up mdio_gpio a bit
      [POWERPC] pasemi: Broaden specific references to 1682M
      [POWERPC] pasemi: Don't enter powersaving states from elevated astates
      [POWERPC] pasemi: Move cpus to hold loop before restart
      [POWERPC] pasemi: Fix module information for gpio-mdio
      [POWERPC] MPIC: Minor optimization of ipi handler
      [POWERPC] pasemi: Implement MSI support
      [POWERPC] holly.c: Remove unnecessary include of linux/ide.h
      [POWERPC] pasemi: Implement NMI support
      [POWERPC] pasemi: Distribute interrupts evenly across cpus
      [POWERPC] Enable CONFIG_PCI_MSI and CONFIG_MD in pasemi_defconfig
      [POWERPC] pasemi: Fix NMI handling check
      [POWERPC] pasemi: Move electra-ide to pata_of_platform
      [POWERPC] Make smp_call_function_map static
      [POWERPC] Make smp_send_stop() handle panic and xmon reboot

Paul Gortmaker (16):
      [POWERPC] 85xx: mpc85xx_ads: add in missing of_node_put()
      [POWERPC] mpc5200: add #address-cells and #size-cells to soc node.
      [POWERPC] Reduce code duplication in legacy_serial, add UART parent types
      [POWERPC] 85xx: Add support for Wind River SBC8560 in arch/powerpc
      [POWERPC] 85xx: Add v1 device tree source for Wind River SBC8560 board
      [POWERPC] CPM2: Make support for the CPM2 optional on 8560 based boards
      [POWERPC] 85xx: Add default .config file for Wind River SBC8560
      [POWERPC] 85xx: Add basic support for Wind River SBC8548 board
      [POWERPC] 85xx: Add v1 device tree source for Wind River SBC8548 board
      [POWERPC] 85xx: Add default .config file for Wind River SBC8548
      [POWERPC] 83xx: Add support for Wind River SBC834x boards
      [POWERPC] 83xx: Add device tree source for Wind River SBC834x board.
      [POWERPC] 83xx: Add default config file for Wind River SBC8349 board
      [POWERPC] 83xx: mpc834x_mds - Convert device tree source to dts-v1
      [POWERPC] QE: Explicitly set address-cells and size cells for muram
      [POWERPC] 83xx: Clean up / convert mpc83xx board DTS files to v1 format.

Paul Mackerras (8):
      [POWERPC] Convert media-bay.c to use the kthread API
      [POWERPC] Convert adb.c to use kthread API and not spin on ADB requests
      [POWERPC] Convert therm_pm72.c to use the kthread API
      [POWERPC] Convert therm_windtunnel.c to use the kthread API
      [POWERPC] Fix sleep on powerbook 3400
      Revert "[POWERPC] Disable PCI IO/Mem on a device when resources can't be allocated"
      [POWERPC] Provide a way to protect 4k subpages when using 64k pages
      Revert "[POWERPC] Fake NUMA emulation for PowerPC"

Roel Kluin (1):
      [POWERPC] 4xx: logical/bitand typo in powerpc/boot/4xx.c

Scott Wood (13):
      [POWERPC] 8xx: Convert mpc866ads to the new device binding.
      [POWERPC] 83xx: mpc834x_mds: Fix whitespace and call of_platform_bus_probe().
      [POWERPC] 83xx: mpc8313erdb: Fix whitespace.
      [POWERPC] wrapper: Rename offset in offset_devp()
      [POWERPC] wrapper: Treat NULL as root node in devp_offset; add devp_offset_find()
      [POWERPC] Implement arch disable/enable irq hooks.
      [POWERPC] fsl_soc: Fix get_immrbase() to use ranges, rather than reg.
      [POWERPC] 8xx: Analogue & Micro Adder875 board support.
      [POWERPC] 82xx: Embedded Planet EP8248E support
      [POWERPC] 83xx: MPC8313e RBD add NAND to device tree
      [POWERPC] 83xx: MPC8313e RDB - Add NOR flash to the device tree.
      [POWERPC] 83xx: Update MPC8313e RDB defconfig for MTD, NAND, JFFS2.
      [POWERPC] 8xx: adder875 - Fix flash bus-width and remove duplicate __initdata

Sean MacLennan (5):
      [POWERPC] 4xx: Add PowerPC 440EP Rev C
      [POWERPC] 4xx: PIKA Warp base platform
      [POWERPC] 4xx: PIKA Warp DTS
      [POWERPC] 4xx: PIKA Warp bootwrapper
      [POWERPC] 4xx: PIKA Warp defconfig

Stefan Roese (15):
      [POWERPC] 4xx: Add 440SPe revA runtime detection to PCIe
      [POWERPC] 4xx: Fix TLB 0 problem with CONFIG_SERIAL_TEXT_DEBUG
      [POWERPC] 4xx: Add 405EX CPU type needed for EMAC support on Kilauea
      [POWERPC] 4xx: Change Kilauea dts to support new EMAC device tree properties
      [POWERPC] 4xx: Add Kilauea PCIe support to dts and Kconfig
      [POWERPC] 4xx: Set ibpre for 405EX in 4xx PCIe driver
      [POWERPC] 4xx: Add aliases node to 4xx dts files
      [POWERPC] 4xx: Change Kilauea PCIe bus ranges in dts file
      [POWERPC] 4xx: Add AMCC Makalu board support to platforms/40x
      [POWERPC] 4xx: Makalu dts
      [POWERPC] 4xx: Makalu defconfig
      [POWERPC] 4xx: Add EMAC support to Kilauea defconfig
      [POWERPC] 4xx: PCIe: Increase max busses per port to 64
      [POWERPC] 4xx: Add 405EXr to cputable
      [POWERPC] 4xx: Add AMCC Haleakala (405EXr) dts

Stephen Neuendorffer (6):
      [POWERPC] Improved documentation of device tree 'ranges'
      [POWERPC] Xilinx: update compatible list for interrupt controller
      [POWERPC] Xilinx: Add correct compatible list for device tree bus bindings.
      [POWERPC] Xilinx: Update booting-without-of.
      [POWERPC] Xilinx: updated device tree compatibility to match uboot bsp generator.
      [POWERPC] Xilinx uartlite: Section type fixups

Stephen Rothwell (51):
      [POWERPC] Make global_phb_number static
      [POWERPC] iSeries: Mark two functions __init
      [POWERPC] iSeries: Declare iSeries_pci_final_fixup in pci.h
      [POWERPC] iSeries: Fix sparse warnings in setup.c
      [POWERPC] Remove redundant declaration of hose_list
      [POWERPC] Use of_register_driver to implement of_register_platform_driver
      [POWERPC] kernel_execve is identical in 32 and 64 bit
      [POWERPC] iommu_free_table doesn't need the device_node
      [POWERPC] pSeries: Remove dependency on pci_dn bussubno
      [POWERPC] Clean up pci-bridge.h
      [POWERPC] Consolidate pci_controller
      [POWERPC] iSeries: Move find_Device_Node to avoid a forward declaration
      [POWERPC] iSeries: Cleanup PCI retry code a little
      [POWERPC] iSeries: DeCamelCase pci.c
      [POWERPC] iSeries: Remove some dead code from pci.c
      [POWERPC] iSeries: Unindent and clean iSeries_pci_final_fixup
      [POWERPC] iSeries: Consoldiate PCI IO error check
      [POWERPC] iSeries: Remove one layer of IO routines
      [POWERPC] iSeries: Remove pci_dn dependency from iSeries_Device_Information
      [POWERPC] iSeries: iseries_ds_addr is only used in pci.c
      [POWERPC] iSeries: Reduce dependence on pci_dn bussubno
      [POWERPC] iSeries: Make pcibios_final_fixup not depend on pci_dn
      [POWERPC] Inline pci_setup_pci_controller as it has become trivial
      [POWERPC] iSeries: Call iSeries_pcibios_init from setup_arch
      [POWERPC] iSeries: hose->buid is always zero for iSeries
      [POWERPC] Remove some iSeries platform checks from the PCI code
      [POWERPC] Don't special case pci_domain_nr() for iSeries
      [POWERPC] pci_controller->arch_data really is a struct device_node *
      [POWERPC] iSeries: DeCamelCase vpdinfo.c
      [POWERPC] iSeries: Clean up and simplify vdpinfo.c
      [POWERPC] iSeries: Merge vpdinfo.c into pci.c
      [POWERPC] EEH: Avoid a possible NULL pointer dereference
      [POWERPC] iSeries: Fix unregistering HV event handlers
      [POWERPC] Stop the TOC overflowing for large builds
      [POWERPC] Add EHEA and EHCA as modules in the ppc64_defconfig
      [POWERPC] The builtin matches for ibmebus.c can be __initdata
      [POWERPC] Constify the of_device_id passed to of_platform_bus_probe
      [POWERPC] Pointers marked as __iomem do not need to be volatile
      [POWERPC] Make non-PCI build work again
      [POWERPC] The pci_dn class_code is only used by EEH
      [POWERPC] The pci_dn pcidev is only used by EEH
      [POWERPC] iSeries: eliminate pci_dn bussubno
      [POWERPC] eeh.c: Use for_each_child_of_node
      [POWERPC] pci_32.c: Use for_each_child_of_node
      [POWERPC] therm_pm72: Suppress some compile warnings
      [POWERPC] arch/powerpc/kernel: Use for_each_child_of_node
      [POWERPC] therm_windtunnel: Eliminate some build warnings
      [POWERPC] therm_adt746x: Eliminate some build warnings
      [POWERPC] Check that the syscall table matches the syscall numbers
      [POWERPC] Make ibmebus use of_(un)register_driver
      [POWERPC] Fix a couple of copyright symbols

Takashi Yamamoto (2):
      [POWERPC] PS3: Add logical performance monitor repository routines
      [POWERPC] PS3: Add logical performance monitor driver support

Timur Tabi (8):
      [POWERPC] 86xx: fix guts_set_dmacr() and add guts_set_pmuxcr_dma() to immap_86xx.h
      [POWERPC] QE: change qe_setbrg() to take an enum qe_clock instead of an integer
      [POWERPC] qe: add function qe_clock_source()
      [POWERPC] ucc_geth: use rx-clock-name and tx-clock-name device tree properties
      [POWERPC] QE: Add ability to upload QE firmware
      [POWERPC] QE: Add support for Freescale QUICCEngine UART
      [POWERPC] qe-uart: add support for Freescale QUICCEngine UART
      [POWERPC] Update MPC8610 HPCD to support audio drivers

Valentine Barshak (12):
      [POWERPC] 4xx: 440EPx Sequoia USB OHCI DTS entry
      [POWERPC] 4xx: 440GRx Rainier bootwrapper.
      [POWERPC] 4xx: 440GRx Rainier DTS.
      [POWERPC] 4xx: 440GRx Rainier board support.
      [POWERPC] 4xx: 440GRx Rainier default config
      [POWERPC] 4xx: make UIC use generic level irq handler
      [POWERPC] 4xx: rework UIC cascade irq handling
      [POWERPC] 4xx: Correct 440GRx machine_check callback
      [POWERPC] 4xx: Add PCI entry to 440EPx Sequoia DTS.
      [POWERPC] 44x: Sequoia and Rainier updates for 2.6.25
      [POWERPC] 4xx: update 440EP(x)/440GR(x) identical PVR issue workaround
      [POWERPC] 4xx: Add PCI entry to 440GRx Rainier DTS.

Vitaly Bordug (3):
      phy/fixed.c: rework to not duplicate PHY layer functionality
      [POWERPC] MPC8349E-mITX: Vitesse 7385 PHY is not connected to the MDIO bus
      [POWERPC] fsl_soc: add support to gianfar for fixed-link property

Wade Farnsworth (2):
      [POWERPC] 86xx: Add localbus and flash nodes to mpc8641_hpcn.dts
      [POWERPC] 86xx: MPC8641 HPCN - call of_platform_bus_probe()

Zhang Wei (1):
      [POWERPC] Add docs for Freescale DMA & DMA channel device tree nodes

joe@perches.com (6):
      [POWERPC] Add missing spaces in printk formats
      [POWERPC] Add missing spaces in printk formats in arch/ppc
      [POWERPC] arch/powerpc/: Spelling fixes
      [POWERPC] include/asm-powerpc/: Spelling fixes
      [POWERPC] arch/ppc/: Spelling fixes
      [POWERPC] include/asm-ppc/: Spelling fixes

will schmidt (1):
      [POWERPC] Update xmon slb code
