Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wR7ps2HsZzDqLK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 15:06:45 +1000 (AEST)
In-Reply-To: <1492577184-20204-1-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [v2] powerpc/powernv: Block PCI config access on BCM5718 during
 EEH recovery
Message-Id: <3wR7ps093jz9s8D@ozlabs.org>
Date: Mon, 15 May 2017 15:06:44 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-04-19 at 04:46:24 UTC, Gavin Shan wrote:
> Similar to what is done in commit b6541db13952 ("powerpc/eeh: Block
> PCI config access upon frozen PE"), we need block PCI config access
> for BCM5719 when recovering frozen error on them. Otherwise, an
> unexpected recursive fenced PHB error is observed.
> 
>    0001:06:00.0 Ethernet controller: Broadcom Corporation \
>                 NetXtreme BCM5718 Gigabit Ethernet PCIe (rev 10)
>    0001:06:00.1 Ethernet controller: Broadcom Corporation \
>                 NetXtreme BCM5718 Gigabit Ethernet PCIe (rev 10)
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c374ed27c93698c794f99c5d41d9ad

cheers
