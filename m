Return-Path: <openspace.wang@gmail.com>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
 [209.85.215.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8BA75B6F62
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2012 10:22:24 +1000 (EST)
Received: by eaak11 with SMTP id k11so306777eaa.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2012 17:22:19 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 25 Apr 2012 08:22:19 +0800
Message-ID: <CAPxxNQmfkJLPHq0BvzxOnLFO-e0FRmaF1VqLhP-jMqF-ziM2tA@mail.gmail.com>
Subject: 3.4-rc3 compile failed on IBM Power6
From: Ryan Wang <openspace.wang@gmail.com>
To: Nishanth Aravamudan <nacc@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary=001517573d0047c94f04be75dd4a
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001517573d0047c94f04be75dd4a
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

# gcc --version
gcc (GCC) 4.4.6 20110731 (Red Hat 4.4.6-3)
Copyright (C) 2010 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

platform    : pSeries
model        : IBM,9117-MMA
machine        : CHRP IBM,9117-MMA



# make O=3D../build/3.4-rc4/
  GEN     /usr/src/kernels/build/3.4-rc4/Makefile
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf --silentoldconfig Kconfig
  Using /usr/src/kernels/linux as source for kernel
  GEN     /usr/src/kernels/build/3.4-rc4/Makefile
  WRAP    arch/powerpc/include/generated/asm/rwsem.h
  CHK     include/linux/version.h
  UPD     include/linux/version.h
  CHK     include/generated/utsrelease.h
  UPD     include/generated/utsrelease.h
  CC      kernel/bounds.s
  GEN     include/generated/bounds.h
  CC      arch/powerpc/kernel/asm-offsets.s
  GEN     include/generated/asm-offsets.h
  CALL    /usr/src/kernels/linux/scripts/checksyscalls.sh
  HOSTCC  scripts/dtc/checks.o
  HOSTCC  scripts/dtc/data.o
  SHIPPED scripts/dtc/dtc-lexer.lex.c
  SHIPPED scripts/dtc/dtc-parser.tab.h
  HOSTCC  scripts/dtc/dtc-lexer.lex.o
  SHIPPED scripts/dtc/dtc-parser.tab.c
  HOSTCC  scripts/dtc/dtc-parser.tab.o
  HOSTCC  scripts/dtc/dtc.o
  HOSTCC  scripts/dtc/flattree.o
  HOSTCC  scripts/dtc/fstree.o
  HOSTCC  scripts/dtc/livetree.o
  HOSTCC  scripts/dtc/srcpos.o
  HOSTCC  scripts/dtc/treesource.o
  HOSTCC  scripts/dtc/util.o
  HOSTLD  scripts/dtc/dtc
  HOSTCC  scripts/genksyms/genksyms.o
  SHIPPED scripts/genksyms/lex.lex.c
  SHIPPED scripts/genksyms/keywords.hash.c
  SHIPPED scripts/genksyms/parse.tab.h
  HOSTCC  scripts/genksyms/lex.lex.o
  SHIPPED scripts/genksyms/parse.tab.c
  HOSTCC  scripts/genksyms/parse.tab.o
  HOSTLD  scripts/genksyms/genksyms
  CC      scripts/mod/empty.o
  HOSTCC  scripts/mod/mk_elfconfig
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/file2alias.o
  HOSTCC  scripts/mod/modpost.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTLD  scripts/mod/modpost
  HOSTCC  scripts/selinux/genheaders/genheaders
  HOSTCC  scripts/selinux/mdp/mdp
  HOSTCC  scripts/kallsyms
  HOSTCC  scripts/pnmtologo
  HOSTCC  scripts/conmakehash
  HOSTCC  scripts/bin2c
  CC      init/main.o
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  CC      init/do_mounts.o
  CC      init/do_mounts_rd.o
  CC      init/do_mounts_initrd.o
  CC      init/do_mounts_md.o
  LD      init/mounts.o
  CC      init/initramfs.o
  LD      init/built-in.o
  HOSTCC  usr/gen_init_cpio
  GEN     usr/initramfs_data.cpio
  AS      usr/initramfs_data.o
  LD      usr/built-in.o
  CC      arch/powerpc/kernel/cputable.o
  CC      arch/powerpc/kernel/ptrace.o
  CC      arch/powerpc/kernel/syscalls.o
  CC      arch/powerpc/kernel/irq.o
  CC      arch/powerpc/kernel/align.o
  CC      arch/powerpc/kernel/signal_32.o
  CC      arch/powerpc/kernel/pmc.o
  CC      arch/powerpc/kernel/vdso.o
  CC      arch/powerpc/kernel/init_task.o
  CC      arch/powerpc/kernel/process.o
  CPP     arch/powerpc/kernel/systbl_chk.i
  CALL    /usr/src/kernels/linux/arch/powerpc/kernel/systbl_chk.sh
  AS      arch/powerpc/kernel/systbl.o
  CC      arch/powerpc/kernel/idle.o
  CC      arch/powerpc/kernel/signal.o
  CC      arch/powerpc/kernel/sysfs.o
  CC      arch/powerpc/kernel/cacheinfo.o
  CC      arch/powerpc/kernel/time.o
  CC      arch/powerpc/kernel/prom.o
  CC      arch/powerpc/kernel/traps.o
  CC      arch/powerpc/kernel/setup-common.o
  CC      arch/powerpc/kernel/udbg.o
  AS      arch/powerpc/kernel/misc.o
  CC      arch/powerpc/kernel/io.o
  CC      arch/powerpc/kernel/dma.o
  AS      arch/powerpc/kernel/misc_64.o
  LDS     arch/powerpc/kernel/vdso32/vdso32.lds
  VDSO32A arch/powerpc/kernel/vdso32/sigtramp.o
  VDSO32A arch/powerpc/kernel/vdso32/gettimeofday.o
  VDSO32A arch/powerpc/kernel/vdso32/datapage.o
  VDSO32A arch/powerpc/kernel/vdso32/cacheflush.o
  VDSO32A arch/powerpc/kernel/vdso32/note.o
  VDSO32L arch/powerpc/kernel/vdso32/vdso32.so.dbg
  OBJCOPY arch/powerpc/kernel/vdso32/vdso32.so
  AS      arch/powerpc/kernel/vdso32/vdso32_wrapper.o
  LD      arch/powerpc/kernel/vdso32/built-in.o
  LDS     arch/powerpc/kernel/vdso64/vdso64.lds
  VDSO64A arch/powerpc/kernel/vdso64/sigtramp.o
  VDSO64A arch/powerpc/kernel/vdso64/gettimeofday.o
  VDSO64A arch/powerpc/kernel/vdso64/datapage.o
  VDSO64A arch/powerpc/kernel/vdso64/cacheflush.o
  VDSO64A arch/powerpc/kernel/vdso64/note.o
  VDSO64L arch/powerpc/kernel/vdso64/vdso64.so.dbg
  OBJCOPY arch/powerpc/kernel/vdso64/vdso64.so
  AS      arch/powerpc/kernel/vdso64/vdso64_wrapper.o
  LD      arch/powerpc/kernel/vdso64/built-in.o
  CC      arch/powerpc/kernel/setup_64.o
  CC      arch/powerpc/kernel/sys_ppc32.o
  CC      arch/powerpc/kernel/signal_64.o
  CC      arch/powerpc/kernel/ptrace32.o
  CC      arch/powerpc/kernel/paca.o
  CC      arch/powerpc/kernel/nvram_64.o
  CC      arch/powerpc/kernel/firmware.o
  CC      arch/powerpc/kernel/hw_breakpoint.o
  AS      arch/powerpc/kernel/cpu_setup_ppc970.o
  AS      arch/powerpc/kernel/cpu_setup_pa6t.o
  AS      arch/powerpc/kernel/cpu_setup_power7.o
  CC      arch/powerpc/kernel/vecemu.o
  AS      arch/powerpc/kernel/idle_power7.o
  CC      arch/powerpc/kernel/of_platform.o
  CC      arch/powerpc/kernel/prom_parse.o
  CC      arch/powerpc/kernel/proc_powerpc.o
  CC      arch/powerpc/kernel/rtas.o
  CC      arch/powerpc/kernel/rtas-rtc.o
  CC      arch/powerpc/kernel/rtas_pci.o
  CC      arch/powerpc/kernel/rtasd.o
  CC      arch/powerpc/kernel/rtas_flash.o
  CC      arch/powerpc/kernel/rtas-proc.o
  CC      arch/powerpc/kernel/lparcfg.o
  CC      arch/powerpc/kernel/vio.o
  CC      arch/powerpc/kernel/ibmebus.o
  CC      arch/powerpc/kernel/crash_dump.o
  CC      arch/powerpc/kernel/module.o
  CC      arch/powerpc/kernel/module_64.o
  CC      arch/powerpc/kernel/dma-iommu.o
  CC      arch/powerpc/kernel/iommu.o
  CC      arch/powerpc/kernel/kgdb.o
  CC      arch/powerpc/kernel/prom_init.o
  CC      arch/powerpc/kernel/ppc_ksyms.o
  CC      arch/powerpc/kernel/btext.o
  CC      arch/powerpc/kernel/smp.o
  CC      arch/powerpc/kernel/kprobes.o
  CC      arch/powerpc/kernel/legacy_serial.o
  CC      arch/powerpc/kernel/udbg_16550.o
  CC      arch/powerpc/kernel/stacktrace.o
  CC      arch/powerpc/kernel/dma-swiotlb.o
  CC      arch/powerpc/kernel/pci_64.o
  CC      arch/powerpc/kernel/pci_dn.o
  CC      arch/powerpc/kernel/isa-bridge.o
  CC      arch/powerpc/kernel/pci-common.o
  CC      arch/powerpc/kernel/pci_of_scan.o
  CC      arch/powerpc/kernel/msi.o
  CC      arch/powerpc/kernel/machine_kexec.o
  CC      arch/powerpc/kernel/crash.o
  CC      arch/powerpc/kernel/machine_kexec_64.o
  CC      arch/powerpc/kernel/audit.o
  CC      arch/powerpc/kernel/io-workarounds.o
  AS      arch/powerpc/kernel/reloc_64.o
  CC      arch/powerpc/kernel/compat_audit.o
  AS      arch/powerpc/kernel/ppc_save_regs.o
  CALL    /usr/src/kernels/linux/arch/powerpc/kernel/prom_init_check.sh
  LD      arch/powerpc/kernel/built-in.o
WARNING: arch/powerpc/kernel/built-in.o(.text+0x2ab2c): Section mismatch in
reference from the function .prom_query_opal() to the function
.init.text:.call_prom()
The function .prom_query_opal() references
the function __init .call_prom().
This is often because .prom_query_opal lacks a __init
annotation or the annotation of .call_prom is wrong.

WARNING: arch/powerpc/kernel/built-in.o(.text+0x2ab54): Section mismatch in
reference from the function .prom_query_opal() to the function
.init.text:.call_prom()
The function .prom_query_opal() references
the function __init .call_prom().
This is often because .prom_query_opal lacks a __init
annotation or the annotation of .call_prom is wrong.

WARNING: arch/powerpc/kernel/built-in.o(.text+0x2ab64): Section mismatch in
reference from the function .prom_query_opal() to the function
.init.text:.prom_printf()
The function .prom_query_opal() references
the function __init .prom_printf().
This is often because .prom_query_opal lacks a __init
annotation or the annotation of .prom_printf is wrong.

WARNING: arch/powerpc/kernel/built-in.o(.text+0x2abbc): Section mismatch in
reference from the function .prom_query_opal() to the function
.init.text:.prom_printf()
The function .prom_query_opal() references
the function __init .prom_printf().
This is often because .prom_query_opal lacks a __init
annotation or the annotation of .prom_printf is wrong.

WARNING: arch/powerpc/kernel/built-in.o(.text+0x2ac2c): Section mismatch in
reference from the function .prom_query_opal() to the function
.init.text:.prom_printf()
The function .prom_query_opal() references
the function __init .prom_printf().
This is often because .prom_query_opal lacks a __init
annotation or the annotation of .prom_printf is wrong.

WARNING: arch/powerpc/kernel/built-in.o(.text+0x2ac4c): Section mismatch in
reference from the function .prom_query_opal() to the function
.init.text:.prom_printf()
The function .prom_query_opal() references
the function __init .prom_printf().
This is often because .prom_query_opal lacks a __init
annotation or the annotation of .prom_printf is wrong.

WARNING: arch/powerpc/kernel/built-in.o(.text+0x2af40): Section mismatch in
reference from the function .prom_opal_takeover() to the function
.init.text:.prom_printf()
The function .prom_opal_takeover() references
the function __init .prom_printf().
This is often because .prom_opal_takeover lacks a __init
annotation or the annotation of .prom_printf is wrong.

WARNING: arch/powerpc/kernel/built-in.o(.text+0x2af44): Section mismatch in
reference from the function .prom_opal_takeover() to the function
.init.text:.prom_close_stdin()
The function .prom_opal_takeover() references
the function __init .prom_close_stdin().
This is often because .prom_opal_takeover lacks a __init
annotation or the annotation of .prom_close_stdin is wrong.

  AS      arch/powerpc/kernel/head_64.o
  LDS     arch/powerpc/kernel/vmlinux.lds
  AS      arch/powerpc/kernel/fpu.o
  AS      arch/powerpc/kernel/vector.o
  AS      arch/powerpc/kernel/entry_64.o
  CC      arch/powerpc/mm/fault.o
  CC      arch/powerpc/mm/mem.o
  CC      arch/powerpc/mm/pgtable.o
  CC      arch/powerpc/mm/gup.o
  CC      arch/powerpc/mm/init_64.o
  CC      arch/powerpc/mm/pgtable_64.o
  CC      arch/powerpc/mm/mmap_64.o
  CC      arch/powerpc/mm/hash_utils_64.o
  AS      arch/powerpc/mm/slb_low.o
  CC      arch/powerpc/mm/slb.o
  CC      arch/powerpc/mm/stab.o
  CC      arch/powerpc/mm/hash_native_64.o
  AS      arch/powerpc/mm/hash_low_64.o
  CC      arch/powerpc/mm/tlb_hash64.o
  CC      arch/powerpc/mm/mmu_context_hash64.o
  CC      arch/powerpc/mm/numa.o
  CC      arch/powerpc/mm/slice.o
  CC      arch/powerpc/mm/hugetlbpage.o
  CC      arch/powerpc/mm/hugetlbpage-hash64.o
  CC      arch/powerpc/mm/subpage-prot.o
  LD      arch/powerpc/mm/built-in.o
  AS      arch/powerpc/lib/string.o
  CC      arch/powerpc/lib/alloc.o
  AS      arch/powerpc/lib/checksum_64.o
  AS      arch/powerpc/lib/crtsavres.o
  CC      arch/powerpc/lib/devres.o
  AS      arch/powerpc/lib/copypage_64.o
  AS      arch/powerpc/lib/copyuser_64.o
  AS      arch/powerpc/lib/memcpy_64.o
  CC      arch/powerpc/lib/usercopy_64.o
  AS      arch/powerpc/lib/mem_64.o
  CC      arch/powerpc/lib/checksum_wrappers_64.o
  AS      arch/powerpc/lib/hweight_64.o
  AS      arch/powerpc/lib/copyuser_power7.o
  CC      arch/powerpc/lib/sstep.o
  AS      arch/powerpc/lib/ldstfp.o
  CC      arch/powerpc/lib/locks.o
  CC      arch/powerpc/lib/copyuser_power7_vmx.o
  CC      arch/powerpc/lib/code-patching.o
  CC      arch/powerpc/lib/feature-fixups.o
  LD      arch/powerpc/lib/built-in.o
  CC      arch/powerpc/sysdev/mpic.o
  CC      arch/powerpc/sysdev/mpic_msi.o
  CC      arch/powerpc/sysdev/mpic_u3msi.o
  CC      arch/powerpc/sysdev/mpic_pasemi_msi.o
  CC      arch/powerpc/sysdev/msi_bitmap.o
  CC      arch/powerpc/sysdev/pmi.o
  CC      arch/powerpc/sysdev/mmio_nvram.o
  CC      arch/powerpc/sysdev/simple_gpio.o
  CC      arch/powerpc/sysdev/rtc_cmos_setup.o
  CC      arch/powerpc/sysdev/i8259.o
  CC      arch/powerpc/sysdev/dcr.o
  CC      arch/powerpc/sysdev/xics/xics-common.o
  CC      arch/powerpc/sysdev/xics/icp-native.o
  CC      arch/powerpc/sysdev/xics/icp-hv.o
  CC      arch/powerpc/sysdev/xics/ics-rtas.o
  CC      arch/powerpc/sysdev/xics/ics-opal.o
  LD      arch/powerpc/sysdev/xics/built-in.o
WARNING: arch/powerpc/sysdev/xics/built-in.o(.text+0x1624): Section
mismatch in reference from the function .ics_rtas_init() to the function
.init.text:.xics_register_ics()
The function .ics_rtas_init() references
the function __init .xics_register_ics().
This is often because .ics_rtas_init lacks a __init
annotation or the annotation of .xics_register_ics is wrong.

  LD      arch/powerpc/sysdev/built-in.o
WARNING: arch/powerpc/sysdev/built-in.o(.text+0x8de4): Section mismatch in
reference from the function .ics_rtas_init() to the function
.init.text:.xics_register_ics()
The function .ics_rtas_init() references
the function __init .xics_register_ics().
This is often because .ics_rtas_init lacks a __init
annotation or the annotation of .xics_register_ics is wrong.

  CC [M]  arch/powerpc/sysdev/axonram.o
  CC      arch/powerpc/platforms/cell/cbe_regs.o
  CC      arch/powerpc/platforms/cell/interrupt.o
  CC      arch/powerpc/platforms/cell/pervasive.o
  CC      arch/powerpc/platforms/cell/iommu.o
  CC      arch/powerpc/platforms/cell/setup.o
  CC      arch/powerpc/platforms/cell/spider-pic.o
  CC      arch/powerpc/platforms/cell/pmu.o
  CC      arch/powerpc/platforms/cell/spider-pci.o
  CC      arch/powerpc/platforms/cell/ras.o
  CC      arch/powerpc/platforms/cell/cbe_powerbutton.o
  CC      arch/powerpc/platforms/cell/smp.o
  CC      arch/powerpc/platforms/cell/spu_callbacks.o
  CC      arch/powerpc/platforms/cell/spu_base.o
  CC      arch/powerpc/platforms/cell/spu_notify.o
  CC      arch/powerpc/platforms/cell/spu_syscalls.o
  CC      arch/powerpc/platforms/cell/spu_fault.o
  CC      arch/powerpc/platforms/cell/spu_priv1_mmio.o
  CC      arch/powerpc/platforms/cell/spu_manage.o
  LD      arch/powerpc/platforms/cell/spufs/built-in.o
  CC [M]  arch/powerpc/platforms/cell/spufs/inode.o
  CC [M]  arch/powerpc/platforms/cell/spufs/file.o
  CC [M]  arch/powerpc/platforms/cell/spufs/context.o
  CC [M]  arch/powerpc/platforms/cell/spufs/syscalls.o
  CC [M]  arch/powerpc/platforms/cell/spufs/coredump.o
  CC [M]  arch/powerpc/platforms/cell/spufs/sched.o
  CC [M]  arch/powerpc/platforms/cell/spufs/backing_ops.o
  CC [M]  arch/powerpc/platforms/cell/spufs/hw_ops.o
  CC [M]  arch/powerpc/platforms/cell/spufs/run.o
  CC [M]  arch/powerpc/platforms/cell/spufs/gang.o
  SHIPPED arch/powerpc/platforms/cell/spufs/spu_save_dump.h
  SHIPPED arch/powerpc/platforms/cell/spufs/spu_restore_dump.h
  CC [M]  arch/powerpc/platforms/cell/spufs/switch.o
  CC [M]  arch/powerpc/platforms/cell/spufs/fault.o
  CC [M]  arch/powerpc/platforms/cell/spufs/lscsa_alloc.o
  LD [M]  arch/powerpc/platforms/cell/spufs/spufs.o
  CC      arch/powerpc/platforms/cell/axon_msi.o
  CC      arch/powerpc/platforms/cell/qpace_setup.o
  LD      arch/powerpc/platforms/cell/built-in.o
  CC [M]  arch/powerpc/platforms/cell/cbe_thermal.o
  CC [M]  arch/powerpc/platforms/cell/cbe_cpufreq_pervasive.o
  CC [M]  arch/powerpc/platforms/cell/cbe_cpufreq.o
  LD [M]  arch/powerpc/platforms/cell/cbe-cpufreq.o
  CC [M]  arch/powerpc/platforms/cell/cpufreq_spudemand.o
  CC      arch/powerpc/platforms/pasemi/setup.o
  CC      arch/powerpc/platforms/pasemi/pci.o
  CC      arch/powerpc/platforms/pasemi/time.o
  CC      arch/powerpc/platforms/pasemi/idle.o
  AS      arch/powerpc/platforms/pasemi/powersave.o
  CC      arch/powerpc/platforms/pasemi/iommu.o
  CC      arch/powerpc/platforms/pasemi/dma_lib.o
  CC      arch/powerpc/platforms/pasemi/misc.o
  CC      arch/powerpc/platforms/pasemi/cpufreq.o
  LD      arch/powerpc/platforms/pasemi/built-in.o
  CC [M]  arch/powerpc/platforms/pasemi/gpio_mdio.o
  CC      arch/powerpc/platforms/powernv/setup.o
  AS      arch/powerpc/platforms/powernv/opal-takeover.o
  AS      arch/powerpc/platforms/powernv/opal-wrappers.o
  CC      arch/powerpc/platforms/powernv/opal.o
  CC      arch/powerpc/platforms/powernv/opal-rtc.o
  CC      arch/powerpc/platforms/powernv/opal-nvram.o
  CC      arch/powerpc/platforms/powernv/smp.o
  CC      arch/powerpc/platforms/powernv/pci.o
  CC      arch/powerpc/platforms/powernv/pci-p5ioc2.o
  CC      arch/powerpc/platforms/powernv/pci-ioda.o
  LD      arch/powerpc/platforms/powernv/built-in.o
  CC      arch/powerpc/platforms/pseries/lpar.o
  AS      arch/powerpc/platforms/pseries/hvCall.o
  CC      arch/powerpc/platforms/pseries/nvram.o
  CC      arch/powerpc/platforms/pseries/reconfig.o
  CC      arch/powerpc/platforms/pseries/setup.o
  CC      arch/powerpc/platforms/pseries/iommu.o
/usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c: In function
=91query_ddw=92:
/usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:823: error:
implicit declaration of function =91pci_dev_to_eeh_dev=92
/usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:823: warning:
assignment makes pointer from integer without a cast
/usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:824: error:
dereferencing pointer to incomplete type
/usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:825: error:
dereferencing pointer to incomplete type
/usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:826: error:
dereferencing pointer to incomplete type
/usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:827: error:
dereferencing pointer to incomplete type
/usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c: In function
=91create_ddw=92:
/usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:852: warning:
assignment makes pointer from integer without a cast
/usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:853: error:
dereferencing pointer to incomplete type
/usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:854: error:
dereferencing pointer to incomplete type
/usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:855: error:
dereferencing pointer to incomplete type
/usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:856: error:
dereferencing pointer to incomplete type
make[3]: *** [arch/powerpc/platforms/pseries/iommu.o] Error 1
make[2]: *** [arch/powerpc/platforms/pseries] Error 2
make[1]: *** [arch/powerpc/platforms] Error 2
make: *** [sub-make] Error 2

--001517573d0047c94f04be75dd4a
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

# gcc --version<br>gcc (GCC) 4.4.6 20110731 (Red Hat 4.4.6-3)<br>Copyright =
(C) 2010 Free Software Foundation, Inc.<br>This is free software; see the s=
ource for copying conditions.=A0 There is NO<br>warranty; not even for MERC=
HANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.<br>
<br>platform=A0=A0=A0 : pSeries<br>model=A0=A0=A0 =A0=A0=A0 : IBM,9117-MMA<=
br>machine=A0=A0=A0 =A0=A0=A0 : CHRP IBM,9117-MMA<br><br><br><br># make O=
=3D../build/3.4-rc4/ <br>=A0 GEN=A0=A0=A0=A0 /usr/src/kernels/build/3.4-rc4=
/Makefile<br>=A0 HOSTLD=A0 scripts/kconfig/conf<br>
scripts/kconfig/conf --silentoldconfig Kconfig<br>=A0 Using /usr/src/kernel=
s/linux as source for kernel<br>=A0 GEN=A0=A0=A0=A0 /usr/src/kernels/build/=
3.4-rc4/Makefile<br>=A0 WRAP=A0=A0=A0 arch/powerpc/include/generated/asm/rw=
sem.h<br>=A0 CHK=A0=A0=A0=A0 include/linux/version.h<br>
=A0 UPD=A0=A0=A0=A0 include/linux/version.h<br>=A0 CHK=A0=A0=A0=A0 include/=
generated/utsrelease.h<br>=A0 UPD=A0=A0=A0=A0 include/generated/utsrelease.=
h<br>=A0 CC=A0=A0=A0=A0=A0 kernel/bounds.s<br>=A0 GEN=A0=A0=A0=A0 include/g=
enerated/bounds.h<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kernel/asm-offsets.=
s<br>
=A0 GEN=A0=A0=A0=A0 include/generated/asm-offsets.h<br>=A0 CALL=A0=A0=A0 /u=
sr/src/kernels/linux/scripts/checksyscalls.sh<br>=A0 HOSTCC=A0 scripts/dtc/=
checks.o<br>=A0 HOSTCC=A0 scripts/dtc/data.o<br>=A0 SHIPPED scripts/dtc/dtc=
-lexer.lex.c<br>=A0 SHIPPED scripts/dtc/dtc-parser.tab.h<br>
=A0 HOSTCC=A0 scripts/dtc/dtc-lexer.lex.o<br>=A0 SHIPPED scripts/dtc/dtc-pa=
rser.tab.c<br>=A0 HOSTCC=A0 scripts/dtc/dtc-parser.tab.o<br>=A0 HOSTCC=A0 s=
cripts/dtc/dtc.o<br>=A0 HOSTCC=A0 scripts/dtc/flattree.o<br>=A0 HOSTCC=A0 s=
cripts/dtc/fstree.o<br>
=A0 HOSTCC=A0 scripts/dtc/livetree.o<br>=A0 HOSTCC=A0 scripts/dtc/srcpos.o<=
br>=A0 HOSTCC=A0 scripts/dtc/treesource.o<br>=A0 HOSTCC=A0 scripts/dtc/util=
.o<br>=A0 HOSTLD=A0 scripts/dtc/dtc<br>=A0 HOSTCC=A0 scripts/genksyms/genks=
yms.o<br>=A0 SHIPPED scripts/genksyms/lex.lex.c<br>
=A0 SHIPPED scripts/genksyms/keywords.hash.c<br>=A0 SHIPPED scripts/genksym=
s/parse.tab.h<br>=A0 HOSTCC=A0 scripts/genksyms/lex.lex.o<br>=A0 SHIPPED sc=
ripts/genksyms/parse.tab.c<br>=A0 HOSTCC=A0 scripts/genksyms/parse.tab.o<br=
>=A0 HOSTLD=A0 scripts/genksyms/genksyms<br>
=A0 CC=A0=A0=A0=A0=A0 scripts/mod/empty.o<br>=A0 HOSTCC=A0 scripts/mod/mk_e=
lfconfig<br>=A0 MKELF=A0=A0 scripts/mod/elfconfig.h<br>=A0 HOSTCC=A0 script=
s/mod/file2alias.o<br>=A0 HOSTCC=A0 scripts/mod/modpost.o<br>=A0 HOSTCC=A0 =
scripts/mod/sumversion.o<br>=A0 HOSTLD=A0 scripts/mod/modpost<br>
=A0 HOSTCC=A0 scripts/selinux/genheaders/genheaders<br>=A0 HOSTCC=A0 script=
s/selinux/mdp/mdp<br>=A0 HOSTCC=A0 scripts/kallsyms<br>=A0 HOSTCC=A0 script=
s/pnmtologo<br>=A0 HOSTCC=A0 scripts/conmakehash<br>=A0 HOSTCC=A0 scripts/b=
in2c<br>=A0 CC=A0=A0=A0=A0=A0 init/main.o<br>
=A0 CHK=A0=A0=A0=A0 include/generated/compile.h<br>=A0 UPD=A0=A0=A0=A0 incl=
ude/generated/compile.h<br>=A0 CC=A0=A0=A0=A0=A0 init/version.o<br>=A0 CC=
=A0=A0=A0=A0=A0 init/do_mounts.o<br>=A0 CC=A0=A0=A0=A0=A0 init/do_mounts_rd=
.o<br>=A0 CC=A0=A0=A0=A0=A0 init/do_mounts_initrd.o<br>=A0 CC=A0=A0=A0=A0=
=A0 init/do_mounts_md.o<br>
=A0 LD=A0=A0=A0=A0=A0 init/mounts.o<br>=A0 CC=A0=A0=A0=A0=A0 init/initramfs=
.o<br>=A0 LD=A0=A0=A0=A0=A0 init/built-in.o<br>=A0 HOSTCC=A0 usr/gen_init_c=
pio<br>=A0 GEN=A0=A0=A0=A0 usr/initramfs_data.cpio<br>=A0 AS=A0=A0=A0=A0=A0=
 usr/initramfs_data.o<br>=A0 LD=A0=A0=A0=A0=A0 usr/built-in.o<br>=A0 CC=A0=
=A0=A0=A0=A0 arch/powerpc/kernel/cputable.o<br>
=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kernel/ptrace.o<br>=A0 CC=A0=A0=A0=A0=A0=
 arch/powerpc/kernel/syscalls.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kerne=
l/irq.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kernel/align.o<br>=A0 CC=A0=
=A0=A0=A0=A0 arch/powerpc/kernel/signal_32.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/=
powerpc/kernel/pmc.o<br>
=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kernel/vdso.o<br>=A0 CC=A0=A0=A0=A0=A0 a=
rch/powerpc/kernel/init_task.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kernel=
/process.o<br>=A0 CPP=A0=A0=A0=A0 arch/powerpc/kernel/systbl_chk.i<br>=A0 C=
ALL=A0=A0=A0 /usr/src/kernels/linux/arch/powerpc/kernel/systbl_chk.sh<br>
=A0 AS=A0=A0=A0=A0=A0 arch/powerpc/kernel/systbl.o<br>=A0 CC=A0=A0=A0=A0=A0=
 arch/powerpc/kernel/idle.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kernel/si=
gnal.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kernel/sysfs.o<br>=A0 CC=A0=A0=
=A0=A0=A0 arch/powerpc/kernel/cacheinfo.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/pow=
erpc/kernel/time.o<br>
=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kernel/prom.o<br>=A0 CC=A0=A0=A0=A0=A0 a=
rch/powerpc/kernel/traps.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kernel/set=
up-common.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kernel/udbg.o<br>=A0 AS=
=A0=A0=A0=A0=A0 arch/powerpc/kernel/misc.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/po=
werpc/kernel/io.o<br>
=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kernel/dma.o<br>=A0 AS=A0=A0=A0=A0=A0 ar=
ch/powerpc/kernel/misc_64.o<br>=A0 LDS=A0=A0=A0=A0 arch/powerpc/kernel/vdso=
32/vdso32.lds<br>=A0 VDSO32A arch/powerpc/kernel/vdso32/sigtramp.o<br>=A0 V=
DSO32A arch/powerpc/kernel/vdso32/gettimeofday.o<br>
=A0 VDSO32A arch/powerpc/kernel/vdso32/datapage.o<br>=A0 VDSO32A arch/power=
pc/kernel/vdso32/cacheflush.o<br>=A0 VDSO32A arch/powerpc/kernel/vdso32/not=
e.o<br>=A0 VDSO32L arch/powerpc/kernel/vdso32/vdso32.so.dbg<br>=A0 OBJCOPY =
arch/powerpc/kernel/vdso32/vdso32.so<br>
=A0 AS=A0=A0=A0=A0=A0 arch/powerpc/kernel/vdso32/vdso32_wrapper.o<br>=A0 LD=
=A0=A0=A0=A0=A0 arch/powerpc/kernel/vdso32/built-in.o<br>=A0 LDS=A0=A0=A0=
=A0 arch/powerpc/kernel/vdso64/vdso64.lds<br>=A0 VDSO64A arch/powerpc/kerne=
l/vdso64/sigtramp.o<br>=A0 VDSO64A arch/powerpc/kernel/vdso64/gettimeofday.=
o<br>
=A0 VDSO64A arch/powerpc/kernel/vdso64/datapage.o<br>=A0 VDSO64A arch/power=
pc/kernel/vdso64/cacheflush.o<br>=A0 VDSO64A arch/powerpc/kernel/vdso64/not=
e.o<br>=A0 VDSO64L arch/powerpc/kernel/vdso64/vdso64.so.dbg<br>=A0 OBJCOPY =
arch/powerpc/kernel/vdso64/vdso64.so<br>
=A0 AS=A0=A0=A0=A0=A0 arch/powerpc/kernel/vdso64/vdso64_wrapper.o<br>=A0 LD=
=A0=A0=A0=A0=A0 arch/powerpc/kernel/vdso64/built-in.o<br>=A0 CC=A0=A0=A0=A0=
=A0 arch/powerpc/kernel/setup_64.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/ke=
rnel/sys_ppc32.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kernel/signal_64.o<b=
r>
=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kernel/ptrace32.o<br>=A0 CC=A0=A0=A0=A0=
=A0 arch/powerpc/kernel/paca.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kernel=
/nvram_64.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kernel/firmware.o<br>=A0 =
CC=A0=A0=A0=A0=A0 arch/powerpc/kernel/hw_breakpoint.o<br>
=A0 AS=A0=A0=A0=A0=A0 arch/powerpc/kernel/cpu_setup_ppc970.o<br>=A0 AS=A0=
=A0=A0=A0=A0 arch/powerpc/kernel/cpu_setup_pa6t.o<br>=A0 AS=A0=A0=A0=A0=A0 =
arch/powerpc/kernel/cpu_setup_power7.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerp=
c/kernel/vecemu.o<br>=A0 AS=A0=A0=A0=A0=A0 arch/powerpc/kernel/idle_power7.=
o<br>
=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kernel/of_platform.o<br>=A0 CC=A0=A0=A0=
=A0=A0 arch/powerpc/kernel/prom_parse.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/power=
pc/kernel/proc_powerpc.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kernel/rtas.=
o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kernel/rtas-rtc.o<br>
=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kernel/rtas_pci.o<br>=A0 CC=A0=A0=A0=A0=
=A0 arch/powerpc/kernel/rtasd.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kerne=
l/rtas_flash.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kernel/rtas-proc.o<br>=
=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kernel/lparcfg.o<br>=A0 CC=A0=A0=A0=A0=
=A0 arch/powerpc/kernel/vio.o<br>
=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kernel/ibmebus.o<br>=A0 CC=A0=A0=A0=A0=
=A0 arch/powerpc/kernel/crash_dump.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/=
kernel/module.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kernel/module_64.o<br=
>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kernel/dma-iommu.o<br>
=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kernel/iommu.o<br>=A0 CC=A0=A0=A0=A0=A0 =
arch/powerpc/kernel/kgdb.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kernel/pro=
m_init.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kernel/ppc_ksyms.o<br>=A0 CC=
=A0=A0=A0=A0=A0 arch/powerpc/kernel/btext.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/p=
owerpc/kernel/smp.o<br>
=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kernel/kprobes.o<br>=A0 CC=A0=A0=A0=A0=
=A0 arch/powerpc/kernel/legacy_serial.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/power=
pc/kernel/udbg_16550.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kernel/stacktr=
ace.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kernel/dma-swiotlb.o<br>
=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kernel/pci_64.o<br>=A0 CC=A0=A0=A0=A0=A0=
 arch/powerpc/kernel/pci_dn.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kernel/=
isa-bridge.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kernel/pci-common.o<br>=
=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kernel/pci_of_scan.o<br>
=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kernel/msi.o<br>=A0 CC=A0=A0=A0=A0=A0 ar=
ch/powerpc/kernel/machine_kexec.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/ker=
nel/crash.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kernel/machine_kexec_64.o=
<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kernel/audit.o<br>
=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/kernel/io-workarounds.o<br>=A0 AS=A0=A0=
=A0=A0=A0 arch/powerpc/kernel/reloc_64.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powe=
rpc/kernel/compat_audit.o<br>=A0 AS=A0=A0=A0=A0=A0 arch/powerpc/kernel/ppc_=
save_regs.o<br>=A0 CALL=A0=A0=A0 /usr/src/kernels/linux/arch/powerpc/kernel=
/prom_init_check.sh<br>
=A0 LD=A0=A0=A0=A0=A0 arch/powerpc/kernel/built-in.o<br>WARNING: arch/power=
pc/kernel/built-in.o(.text+0x2ab2c): Section mismatch in reference from the=
 function .prom_query_opal() to the function .init.text:.call_prom()<br>The=
 function .prom_query_opal() references<br>
the function __init .call_prom().<br>This is often because .prom_query_opal=
 lacks a __init <br>annotation or the annotation of .call_prom is wrong.<br=
><br>WARNING: arch/powerpc/kernel/built-in.o(.text+0x2ab54): Section mismat=
ch in reference from the function .prom_query_opal() to the function .init.=
text:.call_prom()<br>
The function .prom_query_opal() references<br>the function __init .call_pro=
m().<br>This is often because .prom_query_opal lacks a __init <br>annotatio=
n or the annotation of .call_prom is wrong.<br><br>WARNING: arch/powerpc/ke=
rnel/built-in.o(.text+0x2ab64): Section mismatch in reference from the func=
tion .prom_query_opal() to the function .init.text:.prom_printf()<br>
The function .prom_query_opal() references<br>the function __init .prom_pri=
ntf().<br>This is often because .prom_query_opal lacks a __init <br>annotat=
ion or the annotation of .prom_printf is wrong.<br><br>WARNING: arch/powerp=
c/kernel/built-in.o(.text+0x2abbc): Section mismatch in reference from the =
function .prom_query_opal() to the function .init.text:.prom_printf()<br>
The function .prom_query_opal() references<br>the function __init .prom_pri=
ntf().<br>This is often because .prom_query_opal lacks a __init <br>annotat=
ion or the annotation of .prom_printf is wrong.<br><br>WARNING: arch/powerp=
c/kernel/built-in.o(.text+0x2ac2c): Section mismatch in reference from the =
function .prom_query_opal() to the function .init.text:.prom_printf()<br>
The function .prom_query_opal() references<br>the function __init .prom_pri=
ntf().<br>This is often because .prom_query_opal lacks a __init <br>annotat=
ion or the annotation of .prom_printf is wrong.<br><br>WARNING: arch/powerp=
c/kernel/built-in.o(.text+0x2ac4c): Section mismatch in reference from the =
function .prom_query_opal() to the function .init.text:.prom_printf()<br>
The function .prom_query_opal() references<br>the function __init .prom_pri=
ntf().<br>This is often because .prom_query_opal lacks a __init <br>annotat=
ion or the annotation of .prom_printf is wrong.<br><br>WARNING: arch/powerp=
c/kernel/built-in.o(.text+0x2af40): Section mismatch in reference from the =
function .prom_opal_takeover() to the function .init.text:.prom_printf()<br=
>
The function .prom_opal_takeover() references<br>the function __init .prom_=
printf().<br>This is often because .prom_opal_takeover lacks a __init <br>a=
nnotation or the annotation of .prom_printf is wrong.<br><br>WARNING: arch/=
powerpc/kernel/built-in.o(.text+0x2af44): Section mismatch in reference fro=
m the function .prom_opal_takeover() to the function .init.text:.prom_close=
_stdin()<br>
The function .prom_opal_takeover() references<br>the function __init .prom_=
close_stdin().<br>This is often because .prom_opal_takeover lacks a __init =
<br>annotation or the annotation of .prom_close_stdin is wrong.<br><br>
=A0 AS=A0=A0=A0=A0=A0 arch/powerpc/kernel/head_64.o<br>=A0 LDS=A0=A0=A0=A0 =
arch/powerpc/kernel/vmlinux.lds<br>=A0 AS=A0=A0=A0=A0=A0 arch/powerpc/kerne=
l/fpu.o<br>=A0 AS=A0=A0=A0=A0=A0 arch/powerpc/kernel/vector.o<br>=A0 AS=A0=
=A0=A0=A0=A0 arch/powerpc/kernel/entry_64.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/p=
owerpc/mm/fault.o<br>
=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/mm/mem.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/p=
owerpc/mm/pgtable.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/mm/gup.o<br>=A0 C=
C=A0=A0=A0=A0=A0 arch/powerpc/mm/init_64.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/po=
werpc/mm/pgtable_64.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/mm/mmap_64.o<br=
>
=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/mm/hash_utils_64.o<br>=A0 AS=A0=A0=A0=A0=
=A0 arch/powerpc/mm/slb_low.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/mm/slb.=
o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/mm/stab.o<br>=A0 CC=A0=A0=A0=A0=A0 =
arch/powerpc/mm/hash_native_64.o<br>=A0 AS=A0=A0=A0=A0=A0 arch/powerpc/mm/h=
ash_low_64.o<br>
=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/mm/tlb_hash64.o<br>=A0 CC=A0=A0=A0=A0=A0=
 arch/powerpc/mm/mmu_context_hash64.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc=
/mm/numa.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/mm/slice.o<br>=A0 CC=A0=A0=
=A0=A0=A0 arch/powerpc/mm/hugetlbpage.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/power=
pc/mm/hugetlbpage-hash64.o<br>
=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/mm/subpage-prot.o<br>=A0 LD=A0=A0=A0=A0=
=A0 arch/powerpc/mm/built-in.o<br>=A0 AS=A0=A0=A0=A0=A0 arch/powerpc/lib/st=
ring.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/lib/alloc.o<br>=A0 AS=A0=A0=A0=
=A0=A0 arch/powerpc/lib/checksum_64.o<br>=A0 AS=A0=A0=A0=A0=A0 arch/powerpc=
/lib/crtsavres.o<br>
=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/lib/devres.o<br>=A0 AS=A0=A0=A0=A0=A0 ar=
ch/powerpc/lib/copypage_64.o<br>=A0 AS=A0=A0=A0=A0=A0 arch/powerpc/lib/copy=
user_64.o<br>=A0 AS=A0=A0=A0=A0=A0 arch/powerpc/lib/memcpy_64.o<br>=A0 CC=
=A0=A0=A0=A0=A0 arch/powerpc/lib/usercopy_64.o<br>=A0 AS=A0=A0=A0=A0=A0 arc=
h/powerpc/lib/mem_64.o<br>
=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/lib/checksum_wrappers_64.o<br>=A0 AS=A0=
=A0=A0=A0=A0 arch/powerpc/lib/hweight_64.o<br>=A0 AS=A0=A0=A0=A0=A0 arch/po=
werpc/lib/copyuser_power7.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/lib/sstep=
.o<br>=A0 AS=A0=A0=A0=A0=A0 arch/powerpc/lib/ldstfp.o<br>
=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/lib/locks.o<br>=A0 CC=A0=A0=A0=A0=A0 arc=
h/powerpc/lib/copyuser_power7_vmx.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/l=
ib/code-patching.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/lib/feature-fixups=
.o<br>=A0 LD=A0=A0=A0=A0=A0 arch/powerpc/lib/built-in.o<br>
=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/sysdev/mpic.o<br>=A0 CC=A0=A0=A0=A0=A0 a=
rch/powerpc/sysdev/mpic_msi.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/sysdev/=
mpic_u3msi.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/sysdev/mpic_pasemi_msi.o=
<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/sysdev/msi_bitmap.o<br>
=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/sysdev/pmi.o<br>=A0 CC=A0=A0=A0=A0=A0 ar=
ch/powerpc/sysdev/mmio_nvram.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/sysdev=
/simple_gpio.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/sysdev/rtc_cmos_setup.=
o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/sysdev/i8259.o<br>
=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/sysdev/dcr.o<br>=A0 CC=A0=A0=A0=A0=A0 ar=
ch/powerpc/sysdev/xics/xics-common.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/=
sysdev/xics/icp-native.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/sysdev/xics/=
icp-hv.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/sysdev/xics/ics-rtas.o<br>
=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/sysdev/xics/ics-opal.o<br>=A0 LD=A0=A0=
=A0=A0=A0 arch/powerpc/sysdev/xics/built-in.o<br>WARNING: arch/powerpc/sysd=
ev/xics/built-in.o(.text+0x1624): Section mismatch in reference from the fu=
nction .ics_rtas_init() to the function .init.text:.xics_register_ics()<br>
The function .ics_rtas_init() references<br>the function __init .xics_regis=
ter_ics().<br>This is often because .ics_rtas_init lacks a __init <br>annot=
ation or the annotation of .xics_register_ics is wrong.<br><br>=A0 LD=A0=A0=
=A0=A0=A0 arch/powerpc/sysdev/built-in.o<br>
WARNING: arch/powerpc/sysdev/built-in.o(.text+0x8de4): Section mismatch in =
reference from the function .ics_rtas_init() to the function .init.text:.xi=
cs_register_ics()<br>The function .ics_rtas_init() references<br>the functi=
on __init .xics_register_ics().<br>
This is often because .ics_rtas_init lacks a __init <br>annotation or the a=
nnotation of .xics_register_ics is wrong.<br><br>=A0 CC [M]=A0 arch/powerpc=
/sysdev/axonram.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/platforms/cell/cbe_=
regs.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/platforms/cell/interrupt.o<br>
=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/platforms/cell/pervasive.o<br>=A0 CC=A0=
=A0=A0=A0=A0 arch/powerpc/platforms/cell/iommu.o<br>=A0 CC=A0=A0=A0=A0=A0 a=
rch/powerpc/platforms/cell/setup.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/pl=
atforms/cell/spider-pic.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/platforms/c=
ell/pmu.o<br>
=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/platforms/cell/spider-pci.o<br>=A0 CC=A0=
=A0=A0=A0=A0 arch/powerpc/platforms/cell/ras.o<br>=A0 CC=A0=A0=A0=A0=A0 arc=
h/powerpc/platforms/cell/cbe_powerbutton.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/po=
werpc/platforms/cell/smp.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/platforms/=
cell/spu_callbacks.o<br>
=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/platforms/cell/spu_base.o<br>=A0 CC=A0=
=A0=A0=A0=A0 arch/powerpc/platforms/cell/spu_notify.o<br>=A0 CC=A0=A0=A0=A0=
=A0 arch/powerpc/platforms/cell/spu_syscalls.o<br>=A0 CC=A0=A0=A0=A0=A0 arc=
h/powerpc/platforms/cell/spu_fault.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/=
platforms/cell/spu_priv1_mmio.o<br>
=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/platforms/cell/spu_manage.o<br>=A0 LD=A0=
=A0=A0=A0=A0 arch/powerpc/platforms/cell/spufs/built-in.o<br>=A0 CC [M]=A0 =
arch/powerpc/platforms/cell/spufs/inode.o<br>=A0 CC [M]=A0 arch/powerpc/pla=
tforms/cell/spufs/file.o<br>
=A0 CC [M]=A0 arch/powerpc/platforms/cell/spufs/context.o<br>=A0 CC [M]=A0 =
arch/powerpc/platforms/cell/spufs/syscalls.o<br>=A0 CC [M]=A0 arch/powerpc/=
platforms/cell/spufs/coredump.o<br>=A0 CC [M]=A0 arch/powerpc/platforms/cel=
l/spufs/sched.o<br>
=A0 CC [M]=A0 arch/powerpc/platforms/cell/spufs/backing_ops.o<br>=A0 CC [M]=
=A0 arch/powerpc/platforms/cell/spufs/hw_ops.o<br>=A0 CC [M]=A0 arch/powerp=
c/platforms/cell/spufs/run.o<br>=A0 CC [M]=A0 arch/powerpc/platforms/cell/s=
pufs/gang.o<br>
=A0 SHIPPED arch/powerpc/platforms/cell/spufs/spu_save_dump.h<br>=A0 SHIPPE=
D arch/powerpc/platforms/cell/spufs/spu_restore_dump.h<br>=A0 CC [M]=A0 arc=
h/powerpc/platforms/cell/spufs/switch.o<br>=A0 CC [M]=A0 arch/powerpc/platf=
orms/cell/spufs/fault.o<br>
=A0 CC [M]=A0 arch/powerpc/platforms/cell/spufs/lscsa_alloc.o<br>=A0 LD [M]=
=A0 arch/powerpc/platforms/cell/spufs/spufs.o<br>=A0 CC=A0=A0=A0=A0=A0 arch=
/powerpc/platforms/cell/axon_msi.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/pl=
atforms/cell/qpace_setup.o<br>
=A0 LD=A0=A0=A0=A0=A0 arch/powerpc/platforms/cell/built-in.o<br>=A0 CC [M]=
=A0 arch/powerpc/platforms/cell/cbe_thermal.o<br>=A0 CC [M]=A0 arch/powerpc=
/platforms/cell/cbe_cpufreq_pervasive.o<br>=A0 CC [M]=A0 arch/powerpc/platf=
orms/cell/cbe_cpufreq.o<br>
=A0 LD [M]=A0 arch/powerpc/platforms/cell/cbe-cpufreq.o<br>=A0 CC [M]=A0 ar=
ch/powerpc/platforms/cell/cpufreq_spudemand.o<br>=A0 CC=A0=A0=A0=A0=A0 arch=
/powerpc/platforms/pasemi/setup.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/pla=
tforms/pasemi/pci.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/platforms/pasemi/=
time.o<br>
=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/platforms/pasemi/idle.o<br>=A0 AS=A0=A0=
=A0=A0=A0 arch/powerpc/platforms/pasemi/powersave.o<br>=A0 CC=A0=A0=A0=A0=
=A0 arch/powerpc/platforms/pasemi/iommu.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/pow=
erpc/platforms/pasemi/dma_lib.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/platf=
orms/pasemi/misc.o<br>
=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/platforms/pasemi/cpufreq.o<br>=A0 LD=A0=
=A0=A0=A0=A0 arch/powerpc/platforms/pasemi/built-in.o<br>=A0 CC [M]=A0 arch=
/powerpc/platforms/pasemi/gpio_mdio.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc=
/platforms/powernv/setup.o<br>=A0 AS=A0=A0=A0=A0=A0 arch/powerpc/platforms/=
powernv/opal-takeover.o<br>
=A0 AS=A0=A0=A0=A0=A0 arch/powerpc/platforms/powernv/opal-wrappers.o<br>=A0=
 CC=A0=A0=A0=A0=A0 arch/powerpc/platforms/powernv/opal.o<br>=A0 CC=A0=A0=A0=
=A0=A0 arch/powerpc/platforms/powernv/opal-rtc.o<br>=A0 CC=A0=A0=A0=A0=A0 a=
rch/powerpc/platforms/powernv/opal-nvram.o<br>
=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/platforms/powernv/smp.o<br>=A0 CC=A0=A0=
=A0=A0=A0 arch/powerpc/platforms/powernv/pci.o<br>=A0 CC=A0=A0=A0=A0=A0 arc=
h/powerpc/platforms/powernv/pci-p5ioc2.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powe=
rpc/platforms/powernv/pci-ioda.o<br>=A0 LD=A0=A0=A0=A0=A0 arch/powerpc/plat=
forms/powernv/built-in.o<br>
=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/platforms/pseries/lpar.o<br>=A0 AS=A0=A0=
=A0=A0=A0 arch/powerpc/platforms/pseries/hvCall.o<br>=A0 CC=A0=A0=A0=A0=A0 =
arch/powerpc/platforms/pseries/nvram.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerp=
c/platforms/pseries/reconfig.o<br>=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/platfo=
rms/pseries/setup.o<br>
=A0 CC=A0=A0=A0=A0=A0 arch/powerpc/platforms/pseries/iommu.o<br>/usr/src/ke=
rnels/linux/arch/powerpc/platforms/pseries/iommu.c: In function =91query_dd=
w=92:<br>/usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:823:=
 error: implicit declaration of function =91pci_dev_to_eeh_dev=92<br>
/usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:823: warning:=
 assignment makes pointer from integer without a cast<br>/usr/src/kernels/l=
inux/arch/powerpc/platforms/pseries/iommu.c:824: error: dereferencing point=
er to incomplete type<br>
/usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:825: error: d=
ereferencing pointer to incomplete type<br>/usr/src/kernels/linux/arch/powe=
rpc/platforms/pseries/iommu.c:826: error: dereferencing pointer to incomple=
te type<br>
/usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:827: error: d=
ereferencing pointer to incomplete type<br>/usr/src/kernels/linux/arch/powe=
rpc/platforms/pseries/iommu.c: In function =91create_ddw=92:<br>/usr/src/ke=
rnels/linux/arch/powerpc/platforms/pseries/iommu.c:852: warning: assignment=
 makes pointer from integer without a cast<br>
/usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:853: error: d=
ereferencing pointer to incomplete type<br>/usr/src/kernels/linux/arch/powe=
rpc/platforms/pseries/iommu.c:854: error: dereferencing pointer to incomple=
te type<br>
/usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:855: error: d=
ereferencing pointer to incomplete type<br>/usr/src/kernels/linux/arch/powe=
rpc/platforms/pseries/iommu.c:856: error: dereferencing pointer to incomple=
te type<br>
make[3]: *** [arch/powerpc/platforms/pseries/iommu.o] Error 1<br>make[2]: *=
** [arch/powerpc/platforms/pseries] Error 2<br>make[1]: *** [arch/powerpc/p=
latforms] Error 2<br>make: *** [sub-make] Error 2<br><br><br><br>

--001517573d0047c94f04be75dd4a--
