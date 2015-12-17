Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B981D1A127F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 22:57:29 +1100 (AEDT)
In-Reply-To: <1450320193-20116-2-git-send-email-alistair@popple.id.au>
To: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: gwshan@linux.vnet.ibm.com, Alistair Popple <alistair@popple.id.au>
Subject: Re: [v3,
 1/3] Revert "powerpc/pci: Remove unused struct pci_dn.pcidev field"
Message-Id: <20151217115729.6AE631402BB@ozlabs.org>
Date: Thu, 17 Dec 2015 22:57:29 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-17-12 at 02:43:11 UTC, Alistair Popple wrote:
> This commit removed the pcidev field from struct pci_dn as it was no
> longer in use by the kernel. However to support finding the
> association of Nvlink devices to GPU devices from the device-tree this
> field is required.
> 
> This reverts commit 250c7b277c65 ("powerpc/pci: Remove unused struct
> pci_dn.pcidev field").
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/94973b24d61b03f99017f836d8

cheers
