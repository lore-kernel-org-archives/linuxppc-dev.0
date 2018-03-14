Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401RHT16y6zDqFV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 20:28:53 +1100 (AEDT)
In-Reply-To: <1520412364-2680-1-git-send-email-wei.guo.simon@gmail.com>
To: wei.guo.simon@gmail.com, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Simon Guo <wei.guo.simon@gmail.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
Subject: Re: PCI/hotplug: ppc: correct a php_slot usage after free
Message-Id: <401RHS1y6kz9sRX@ozlabs.org>
Date: Wed, 14 Mar 2018 20:28:43 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-03-07 at 08:46:04 UTC, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> In pnv_php_unregister_one(), pnv_php_put_slot() might kfree
> php_slot structure. But there is pci_hp_deregister() after
> that with php_slot reference.
> 
> This patch moves pnv_php_put_slot() to the end of function.
> 
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/97c6f25d5828b497e3e802b1f7c701

cheers
