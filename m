Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B148FB708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 Aug 2009 23:24:43 +1000 (EST)
Message-Id: <66B8BD01-F3D5-482E-8D9A-8026328FC37A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20090826060708.30936.54239.stgit@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH V2 2/3] powerpc/pci: move pci_64.c device tree scanning
	code into pci-common.c
Date: Wed, 26 Aug 2009 08:24:30 -0500
References: <20090826060659.30936.75706.stgit@localhost.localdomain>
	<20090826060708.30936.54239.stgit@localhost.localdomain>
Cc: linuxppc-dev@lists.ozlabs.org, sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 26, 2009, at 1:07 AM, Grant Likely wrote:

> From: Grant Likely <grant.likely@secretlab.ca>
>
> The PCI device tree scanning code in pci_64.c is some useful  
> functionality.
> It allows PCI devices to be described in the device tree instead of  
> being
> probed for, which in turn allows pci devices to use all of the  
> device tree
> facilities to describe complex PCI bus architectures like GPIO and IRQ
> routing (perhaps not a common situation for desktop or server systems,
> but useful for embedded systems with on-board PCI devices).
>
> This patch moves the device tree scanning into pci-common.c so it is
> available for 32-bit powerpc machines too.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>
> arch/powerpc/include/asm/pci-bridge.h |    5
> arch/powerpc/include/asm/pci.h        |    5
> arch/powerpc/kernel/Makefile          |    2
> arch/powerpc/kernel/pci-common.c      |    1
> arch/powerpc/kernel/pci_64.c          |  289  
> ---------------------------
> arch/powerpc/kernel/pci_of_scan.c     |  358 ++++++++++++++++++++++++ 
> +++++++++
> 6 files changed, 364 insertions(+), 296 deletions(-)
> create mode 100644 arch/powerpc/kernel/pci_of_scan.c
>

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k
