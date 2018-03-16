Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402nW90Yd4zDqnN
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2018 01:13:41 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: dtc warnings
In-Reply-To: <20180314161854.51b994ff@canb.auug.org.au>
References: <20180314161854.51b994ff@canb.auug.org.au>
Date: Sat, 17 Mar 2018 01:13:36 +1100
Message-ID: <87r2okglbj.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
>
> I get the following from a powerpc_ppc44x defconfig build in current
> linux-next:
>
> arch/powerpc/boot/ebony.dtb: Warning (pci_bridge): /plb/pci@20ec00000: missing bus-range for PCI bridge
> arch/powerpc/boot/ebony.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
> arch/powerpc/boot/ebony.dtb: Warning (chosen_node_stdout_path): /chosen:linux,stdout-path: Use 'stdout-path' instead
> arch/powerpc/boot/sequoia.dtb: Warning (pci_bridge): /plb/pci@1ec000000: missing bus-range for PCI bridge
> arch/powerpc/boot/sequoia.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
> arch/powerpc/boot/sequoia.dtb: Warning (chosen_node_stdout_path): /chosen:linux,stdout-path: Use 'stdout-path' instead
> arch/powerpc/boot/sam440ep.dtb: Warning (pci_bridge): /plb/pci@ec000000: missing bus-range for PCI bridge
> arch/powerpc/boot/sam440ep.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
> arch/powerpc/boot/sam440ep.dtb: Warning (chosen_node_stdout_path): /chosen:linux,stdout-path: Use 'stdout-path' instead
> arch/powerpc/boot/rainier.dtb: Warning (pci_bridge): /plb/pci@1ec000000: missing bus-range for PCI bridge
> arch/powerpc/boot/rainier.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
> arch/powerpc/boot/rainier.dtb: Warning (chosen_node_stdout_path): /chosen:linux,stdout-path: Use 'stdout-path' instead
> arch/powerpc/boot/taishan.dtb: Warning (pci_bridge): /plb/pci@20ec00000: missing bus-range for PCI bridge
> arch/powerpc/boot/taishan.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
> arch/powerpc/boot/taishan.dtb: Warning (chosen_node_stdout_path): /chosen:linux,stdout-path: Use 'stdout-path' instead
> arch/powerpc/boot/bamboo.dtb: Warning (pci_bridge): /plb/pci@ec000000: missing bus-range for PCI bridge
> arch/powerpc/boot/bamboo.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
> arch/powerpc/boot/bamboo.dtb: Warning (chosen_node_stdout_path): /chosen:linux,stdout-path: Use 'stdout-path' instead
> arch/powerpc/boot/katmai.dtb: Warning (pci_bridge): /plb/pciex@d00000000: node name is not "pci" or "pcie"
> arch/powerpc/boot/katmai.dtb: Warning (pci_bridge): /plb/pciex@d20000000: node name is not "pci" or "pcie"
> arch/powerpc/boot/katmai.dtb: Warning (pci_bridge): /plb/pciex@d40000000: node name is not "pci" or "pcie"
> arch/powerpc/boot/katmai.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
> arch/powerpc/boot/katmai.dtb: Warning (chosen_node_stdout_path): /chosen:linux,stdout-path: Use 'stdout-path' instead
> arch/powerpc/boot/warp.dtb: Warning (chosen_node_stdout_path): /chosen:linux,stdout-path: Use 'stdout-path' instead
> arch/powerpc/boot/yosemite.dtb: Warning (pci_bridge): /plb/pci@ec000000: missing bus-range for PCI bridge
> arch/powerpc/boot/yosemite.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
> arch/powerpc/boot/yosemite.dtb: Warning (chosen_node_stdout_path): /chosen:linux,stdout-path: Use 'stdout-path' instead
>
> I though someone might like to do something about them ...

Feel free!

Oh that's not what you meant :P

Rob sent a patch to fix most of them:
  http://patchwork.ozlabs.org/patch/879475/

I thought he was going to merge it, but actually I'm not sure why I
thought that. So I should probably merge it.

cheers
