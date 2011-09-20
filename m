Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 767F31007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 20 Sep 2011 16:48:09 +1000 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p8K6m47K028121
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2011 01:48:05 -0500
Subject: Re: power-next
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
In-Reply-To: <1316501174.7975.32.camel@pasglop>
References: <1316501174.7975.32.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 20 Sep 2011 16:48:02 +1000
Message-ID: <1316501282.7975.34.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-09-20 at 16:46 +1000, Benjamin Herrenschmidt wrote:
> Hi folks !
> 
> So I've finally got to setup a branch on github for powerpc next.
> 
> I've also committed a bunch of stuff to it, so here it is. I'll go back
> to kernel.org as soon as it's been fixed.
> 
> https://github.com/ozbenh/linux/commits/next

BTW. Current log is:

Anshuman Khandual (1):
      perf events, powerpc: Add POWER7 stalled-cycles-frontend/backend events

Anton Blanchard (11):
      powerpc/pseries: Avoid spurious error during hotplug CPU add
      powerpc/numa: Enable SD_WAKE_AFFINE in node definition
      sched: Allow SD_NODES_PER_DOMAIN to be overridden
      powerpc/numa: Increase SD_NODES_PER_DOMAIN to 32.
      powerpc/numa: Disable NEWIDLE balancing at node level
      powerpc/numa: Remove duplicate RECLAIM_DISTANCE definition
      powerpc/numa: Remove double of_node_put in hot_add_node_scn_to_nid
      powerpc: Use for_each_node_by_type instead of open coding it
      powerpc: Coding style cleanups
      powerpc: Fix oops when echoing bad values to /sys/devices/system/memory/probe
      powerpc: Fix deadlock in icswx code

Arnaud Lacombe (1):
      powerpc/xics: Add __init to marker icp_native_init()

Arnd Bergmann (1):
      serial/8250: Move UPIO_TSI to powerpc

Ayman El-Khashab (1):
      powerpc/4xx: enable and fix pcie gen1/gen2 on the 460sx

Becky Bruce (1):
      powerpc: Hugetlb for BookE

Benjamin Herrenschmidt (24):
      Merge remote-tracking branch 'jwb/next' into next
      Merge remote-tracking branch 'origin/master' into next
      powerpc/wsp: Add PCIe Root support to PowerEN/WSP
      Merge remote-tracking branch 'origin/master' into next
      powerpc/udbg: Fix Kconfig entry for avoiding 44x early debug with KVM
      powerpc/smp: More generic support for "soft hotplug"
      powerpc/pci: Call pcie_bus_configure_settings()
      powerpc/powernv: Don't clobber r9 in relative_toc()
      powerpc: Add skeleton PowerNV platform
      of: Change logic to overwrite cmd_line with CONFIG_CMDLINE
      powerpc/powernv: Add CPU hotplug support
      powerpc/powernv: Add OPAL takeover from PowerVM
      powerpc/powernv: Get kernel command line accross OPAL takeover
      powerpc/powernv: Basic support for OPAL
      powerpc/powernv: Add support for instanciating OPAL v2 from Open Firmware
      powerpc/powernv: Support for OPAL console
      powerpc/powernv: Hookup reboot and poweroff functions
      powerpc/powernv: Add RTC and NVRAM support plus RTAS fallbacks
      powerpc/powernv: Add OPAL ICS backend
      powerpc/powernv: Register and handle OPAL interrupts
      powerpc/powernv: Machine check and other system interrupts
      powerpc/powernv: Add support for p5ioc2 PCI-X and PCIe
      powerpc/powernv: Implement MSI support for p5ioc2 PCIe
      powerpc/powernv: Handle PCI-X/PCIe reset delay

Brian King (1):
      hvcs: Ensure page aligned partner info buffer

Dmitry Eremin-Solenikov (1):
      cpc925_edac: Support single-processor configurations

Hector Martin (1):
      powerpc/ps3: Add gelic udbg driver

Jim Keniston (1):
      powerpc/nvram: Add compression to fit more oops output into NVRAM

Jimi Xenidis (1):
      powerpc/wsp: Fix Wire Speed Processor platform configs

Josh Boyer (1):
      powerpc/40x: Remove obsolete HCU4 board

Julia Lawall (1):
      pseries/iommu: Add missing kfree

Matthew McClintock (1):
      powerpc: Fix build dependencies for epapr.c which needs libfdt.h

Michael Ellerman (1):
      powerpc/wsp: Add MSI support for PCI on PowerEN

Mike Williams (1):
      powerpc/4xx: edac: Add comma to fix build error

Milton Miller (4):
      powerpc: Override dma_get_required_mask by platform hook and ops
      dma-mapping: Add get_required_mask if arch overrides default
      powerpc: Use the newly added get_required_mask dma_map_ops hook
      powerpc: Tidy up dma_map_ops after adding new hook

Scott Wood (1):
      powerpc/32: Pass device tree address as u64 to machine_init

Stefan Roese (1):
      powerpc/44x: Add NOR flash device to Yosemite dts

Suzuki Poulose (1):
      powerpc/44x: Kexec support for PPC440X chipsets

Tang Yuantian (1):
      powerpc/mm: Fix the call trace when resumed from hibernation

Thadeu Lima de Souza Cascardo (1):
      powerpc/eeh: Fix /proc/ppc64/eeh creation

Timur Tabi (1):
      powerpc/mpic: Add support for discontiguous cores

Tony Breeds (1):
      powerpc/4xx/pci: Add __init annotations for *init_port_hw() functions.
