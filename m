Return-Path: <ruscur@russell.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJVqx4H4pzDrLg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 10:59:57 +1000 (AEST)
Message-ID: <1501203257.4721.1.camel@russell.cc>
Subject: Re: [PATCH] powerpc/powernv/pci: Return failure for some uses of
 dma_set_mask()
From: Russell Currey <ruscur@russell.cc>
To: Alistair Popple <alistair@popple.id.au>, benh@kernel.crashing.org,
 linuxppc-dev@lists.ozlabs.org
Date: Fri, 28 Jul 2017 10:54:17 +1000
In-Reply-To: <1501046800-6690-1-git-send-email-alistair@popple.id.au>
References: <1501046800-6690-1-git-send-email-alistair@popple.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-07-26 at 15:26 +1000, Alistair Popple wrote:
> Commit 8e3f1b1d8255 ("powerpc/powernv/pci: Enable 64-bit devices to access
> > 4GB DMA space") introduced the ability for PCI device drivers to request a
> 
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

Acked-by: Russell Currey <ruscur@russell.cc>
