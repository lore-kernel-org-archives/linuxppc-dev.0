Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wpdxq5HJCzDq68
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 08:50:23 +1000 (AEST)
In-Reply-To: <1497415670-723-1-git-send-email-alistair@popple.id.au>
To: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Alistair Popple <alistair@popple.id.au>, paulus@samba.org
Subject: Re: powernv/npu-dma.c: Remove spurious WARN_ON when a PCI device has
 no of_node
Message-Id: <3wpdxq2V8tz9s4s@ozlabs.org>
Date: Fri, 16 Jun 2017 08:50:23 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-06-14 at 04:47:50 UTC, Alistair Popple wrote:
> "4c3b89e powerpc/powernv: Add sanity checks to pnv_pci_get_{gpu|npu}_dev"
> introduced explicit warnings in pnv_pci_get_npu_dev() when a PCIe device
> has no associated device-tree node. However not all PCIe devices have an
> of_node and pnv_pci_get_npu_dev() gets indirectly called at least once for
> every PCIe device in the system. This results in spurious WARN_ON()'s so
> remove it.
> 
> The same situation should not exist for pnv_pci_get_gpu_dev() as any NPU
> based PCIe device requires a device-tree node.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/377aa6b0efbaa29cfeecd8b9244641

cheers
