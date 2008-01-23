Return-Path: <sam@ravnborg.org>
Received: from pasmtpA.tele.dk (pasmtpa.tele.dk [80.160.77.114])
	by ozlabs.org (Postfix) with ESMTP id ADD6DDDEF5
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 05:53:57 +1100 (EST)
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk
	[83.93.152.216])
	by pasmtpA.tele.dk (Postfix) with ESMTP id 1EE9C1840B
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 19:53:54 +0100 (CET)
Date: Wed, 23 Jan 2008 19:54:05 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Section mismatch warnings om powerpc defconfig build:wq
Message-ID: <20080123185405.GA23693@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Powerpc.

Just a heads up.
When building the provided defconfig for powerpc I get the following bunch
of section mismatch warnings:

WARNING: vmlinux.o(.text+0x83c0): Section mismatch: reference to .devinit.text:.start_secondary in '.start_secondary_prolog'
WARNING: vmlinux.o(.text+0xe878): Section mismatch: reference to .init.text:.find_symbol64 in '.vdso_do_func_patch64'
WARNING: vmlinux.o(.text+0xe8a4): Section mismatch: reference to .init.text:.find_symbol64 in '.vdso_do_func_patch64'
WARNING: vmlinux.o(.text+0xe944): Section mismatch: reference to .init.text:.find_symbol32 in '.vdso_do_func_patch32'
WARNING: vmlinux.o(.text+0xe970): Section mismatch: reference to .init.text:.find_symbol32 in '.vdso_do_func_patch32'
WARNING: vmlinux.o(.text+0x25b10): Section mismatch: reference to .init.text:.lmb_alloc_base in '.move_device_tree'
WARNING: vmlinux.o(.text+0x2bc98): Section mismatch: reference to .devinit.text:.fixup_resource in '.pci_parse_of_addrs'
WARNING: vmlinux.o(.text+0x2c428): Section mismatch: reference to .devinit.text:.update_dn_pci_info in '.pci_dn_reconfig_notifier'
WARNING: vmlinux.o(.text+0x2c9ec): Section mismatch: reference to .devinit.text:.pci_setup_pci_controller in '.pcibios_alloc_controller'
WARNING: vmlinux.o(.text+0x4db6c): Section mismatch: reference to .devinit.text:.pcibios_setup_new_device in '.pcibios_fixup_new_pci_devices'
WARNING: vmlinux.o(.text+0x4db84): Section mismatch: reference to .devinit.text:.pcibios_fixup_device_resources in '.pcibios_fixup_new_pci_devices'
WARNING: vmlinux.o(.text+0x4de28): Section mismatch: reference to .devinit.text:.of_scan_bus in '.pcibios_add_pci_devices'
WARNING: vmlinux.o(.text+0x55474): Section mismatch: reference to .init.text:.free_property in '.free_node'
WARNING: vmlinux.o(.text+0x559d0): Section mismatch: reference to .devinit.text:.vio_register_device_node in '.vio_create_viodasd'
WARNING: vmlinux.o(.text+0xe73c0): Section mismatch: reference to .init.text:.__alloc_bootmem_node in '.sparse_early_usemap_alloc'
WARNING: vmlinux.o(.text+0xe74b4): Section mismatch: reference to .meminit.text:.sparse_index_init in '.sparse_add_one_section'
WARNING: vmlinux.o(.text+0xe74d4): Section mismatch: reference to .meminit.text:.sparse_mem_map_populate in '.sparse_add_one_section'
WARNING: vmlinux.o(.text+0xe7548): Section mismatch: reference to .meminit.text:.sparse_init_one_section in '.sparse_add_one_section'
WARNING: vmlinux.o(.text+0xf1c90): Section mismatch: reference to .devinit.text:.arch_add_memory in '.add_memory'
WARNING: vmlinux.o(.text+0xf1eac): Section mismatch: reference to .meminit.text:.init_currently_empty_zone in '.__add_zone'
WARNING: vmlinux.o(.text+0xf1ee0): Section mismatch: reference to .meminit.text:.memmap_init_zone in '.__add_zone'
WARNING: vmlinux.o(.text+0x279f08): Section mismatch: reference to .devinit.text:.pci_alloc_child_bus in '.pci_add_new_bus'
WARNING: vmlinux.o(.text+0x27a95c): Section mismatch: reference to .devinit.text:.pci_scan_device in '.pci_scan_single_device'
WARNING: vmlinux.o(.text+0x27af44): Section mismatch: reference to .devinit.text:.pcibios_fixup_bus in '.pci_scan_child_bus'
WARNING: vmlinux.o(.text+0x2849a4): Section mismatch: reference to .devinit.text:.pci_setup_bridge in '.pci_bus_assign_resources'
WARNING: vmlinux.o(.text+0x284ca8): Section mismatch: reference to .devinit.text:.pci_bus_size_cardbus in '.pci_bus_size_bridges'
WARNING: vmlinux.o(.text+0x2f649c): Section mismatch: reference to .devinit.text:.hvc_alloc in '.hvc_rtas_init'
WARNING: vmlinux.o(.text+0x30d99c): Section mismatch: reference to .cpuinit.text:.cpu_up in '.store_online'
WARNING: vmlinux.o(.text+0x38c724): Section mismatch: reference to .devinit.text:.olympic_init in '.olympic_open'
WARNING: vmlinux.o(.text+0x3b5630): Section mismatch: reference to .init.text:.pmac_ide_setup_dma in '.pmac_ide_setup_device'
WARNING: vmlinux.o(.text+0x3daa04): Section mismatch: reference to .devexit.text:.sym2_remove in '.sym2_io_error_detected'
WARNING: vmlinux.o(.text+0x4da38c): Section mismatch: reference to .cpuinit.text:.register_cpu_notifier in '.cpufreq_register_driver'
  AS      .tmp_kallsyms2.o
  LD      vmlinux
  SYSMAP  System.map
  SYSMAP  .tmp_System.map
  Building modules, stage 2.
  WRAP    arch/powerpc/boot/zImage.pseries
  WRAP    arch/powerpc/boot/zImage.pmac
powerpc64-unknown-linux-gnu-strip -s -R .comment vmlinux -o arch/powerpc/boot/zImage.iseries
  MODPOST 263 modules
WARNING: drivers/cdrom/viocd.o(.text+0x504): Section mismatch: reference to .init.text:.find_capability in '.viocd_probe'
WARNING: drivers/net/iseries_veth.o(.text+0x113c): Section mismatch: reference to .init.text:.veth_probe_one in '.veth_probe'

Some of these are powerpc specific and you ought to take a look at these.
It is planned to let section mismatches become fatal in the build process during 2.6.25
so now is a good time to fix them.

The above list is generatd from kbuild.git which is included in -mm.
So some warnings may already be fixed and you will need -mm to get the full list.

Another note - I build with 'make KCFLAGS=-fno-inline-functions-called-once'
which triggers a few more warnings than normal with gcc > 3.4.

	Sam
