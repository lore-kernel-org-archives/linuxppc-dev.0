Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYn6W5QpMzDq5c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 22:27:15 +1000 (AEST)
In-Reply-To: <1463726502-14679-2-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: aik@ozlabs.ru, linux-pci@vger.kernel.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, alistair@popple.id.au
Subject: Re: [v10,01/18] PCI: Add pcibios_setup_bridge()
Message-Id: <3rYn6W4S0bz9sf9@ozlabs.org>
Date: Tue, 21 Jun 2016 22:27:15 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-20-05 at 06:41:25 UTC, Gavin Shan wrote:
> Currently, PowerPC PowerNV platform utilizes ppc_md.pcibios_fixup(),
> which is called for once after PCI probing and resource assignment
> are completed, to allocate platform required resources for PCI devices:
> PE#, IO and MMIO mapping, DMA address translation (TCE) table etc.
> Obviously, it's not hotplug friendly.
> 
> This adds weak function pcibios_setup_bridge(), which is called by
> pci_setup_bridge(). PowerPC PowerNV platform will reuse the function
> to assign above platform required resources to newly plugged PCI devices
> during PCI hotplug in subsequent patches.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Entire series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d366d28cd1325f11d582ec6d4a

cheers
