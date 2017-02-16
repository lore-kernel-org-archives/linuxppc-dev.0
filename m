Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vP58f0l05zDqBW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 16:59:46 +1100 (AEDT)
In-Reply-To: <1484095808-24777-2-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: #v4.9+@gwshan.ozlabs.ibm.com, williel@supermicro.com.tw,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, stable@vger.kernel.org,
 hankmax0000@gmail.com
Subject: Re: [1/3] drivers/pci/hotplug: Handle presence detection change
 properly
Message-Id: <3vP58d6Dkhz9s8T@ozlabs.org>
Date: Thu, 16 Feb 2017 16:59:45 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-01-11 at 00:50:06 UTC, Gavin Shan wrote:
> The surprise hotplug is driven by interrupt in PowerNV PCI hotplug
> driver. In the interrupt handler, pnv_php_interrupt(), we bail when
> pnv_pci_get_presence_state() returns zero wrongly. It causes the
> presence change event is always ignored incorrectly.
> 
> This fixes the issue by bailing on error (non-zero value) returned
> from pnv_pci_get_presence_state().
> 
> Fixes: 360aebd85a4 ("drivers/pci/hotplug: Support surprise hotplug in powernv driver")
> Cc: stable@vger.kernel.org #v4.9+
> Reported-by: Hank Chang <hankmax0000@gmail.com>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Tested-by: Willie Liauw <williel@supermicro.com.tw>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d7d55536c6cd1f80295b6d7483ad05

cheers
