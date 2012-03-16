Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8C42DB6FC4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 07:22:48 +1100 (EST)
Subject: Re: [PATCH 2/9 v2] powerpc/mpc85xxcds: Fix PCI I/O space resource of
 PCI bridge
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1331720127-16012-1-git-send-email-chenhui.zhao@freescale.com>
Date: Fri, 16 Mar 2012 15:22:44 -0500
Message-Id: <D4083C5A-B17F-4090-853A-B6CE51C658E0@kernel.crashing.org>
References: <1331720127-16012-1-git-send-email-chenhui.zhao@freescale.com>
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 14, 2012, at 5:15 AM, Zhao Chenhui wrote:

> From: chenhui zhao <chenhui.zhao@freescale.com>
> 
> There is a PCI bridge(Tsi310) between the MPC8548 and a VIA
> southbridge chip.
> 
> The bootloader sets the PCI bridge to open a window from 0x0000
> to 0x1fff on the PCI I/O space. But the kernel can't set the I/O
> resource. In the routine pci_read_bridge_io(), if the base which
> is read from PCI_IO_BASE is equal to zero, the routine don't set
> the I/O resource of the child bus.
> 
> To allow the legacy I/O space on the VIA southbridge to be accessed,
> use the fixup to fix the PCI I/O space of the PCI bridge.
> 
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> Changes for v2:
> * merge patch 1/9 and 2/9
> * rename PCI_DEVICE_ID_IBM_PCIX_BRIDGE to PCI_DEVICE_ID_IDT_TSI310

applied

- k
