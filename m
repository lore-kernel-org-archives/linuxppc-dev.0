Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLV3K05HJzDrJh
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 16:31:41 +1000 (AEST)
In-Reply-To: <1501046800-6690-1-git-send-email-alistair@popple.id.au>
To: Alistair Popple <alistair@popple.id.au>, ruscur@russell.cc,
 benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Alistair Popple <alistair@popple.id.au>
Subject: Re: powerpc/powernv/pci: Return failure for some uses of
 dma_set_mask()
Message-Id: <3xLV3J5Sl6z9tWD@ozlabs.org>
Date: Mon, 31 Jul 2017 16:31:40 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-07-26 at 05:26:40 UTC, Alistair Popple wrote:
> Commit 8e3f1b1d8255 ("powerpc/powernv/pci: Enable 64-bit devices to access
> >4GB DMA space") introduced the ability for PCI device drivers to request a
> DMA mask between 64 and 32 bits and actually get a mask greater than
> 32-bits. However currently if certain machine configuration dependent
> conditions are not meet the code silently falls back to a 32-bit mask.
> 
> This makes it hard for device drivers to detect which mask they actually
> got. Instead we should return an error when the request could not be
> fulfilled which allows drivers to either fallback or implement other
> workarounds as documented in DMA-API-HOWTO.txt.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> Acked-by: Russell Currey <ruscur@russell.cc>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/253fd51e2f533552ae35a0c661705d

cheers
