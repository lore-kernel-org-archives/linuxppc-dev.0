Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8B3691A02DF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 22:41:45 +1100 (AEDT)
In-Reply-To: <1444882955-27601-1-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: powerpc/eeh: Fix recursive fenced PHB on Broadcom shiner adapter
Message-Id: <20151021114145.37C91140E31@ozlabs.org>
Date: Wed, 21 Oct 2015 22:41:45 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-15-10 at 04:22:35 UTC, Gavin Shan wrote:
> Similar to commit b6541db ("powerpc/eeh: Block PCI config access
> upon frozen PE"), this blocks the PCI config space of Broadcom
> Shiner adapter until PE reset is completed, to avoid recursive
> fenced PHB when dumping PCI config registers during the period
> of error recovery.
> 
>    ~# lspci -ns 0003:03:00.0
>    0003:03:00.0 0200: 14e4:168a (rev 10)
>    ~# lspci -s 0003:03:00.0
>    0003:03:00.0 Ethernet controller: Broadcom Corporation \
>                 NetXtreme II BCM57800 1/10 Gigabit Ethernet (rev 10)
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/353169acf1858bb2dc3f9147

cheers
