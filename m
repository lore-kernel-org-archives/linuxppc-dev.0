Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rvWN12mKmzDqQK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 19:10:25 +1000 (AEST)
In-Reply-To: <1468275387-22392-1-git-send-email-tyreld@linux.vnet.ibm.com>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, linux-pci@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mdroth@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, bhelgaas@google.com,
 nfont@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [v2] rpaphp: fix slot registration for multiple slots under a PHB
Message-Id: <3rvWN11qwnz9t1D@ozlabs.org>
Date: Wed, 20 Jul 2016 19:10:25 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-11-07 at 22:16:27 UTC, Tyrel Datwyler wrote:
> PowerVM seems to only ever provide a single hotplug slot per PHB.
> The under lying slot hotplug registration code assumed multiple slots,
> but the actual implementation is broken for multiple slots. This went
> unnoticed for years due to the nature of PowerVM as mentioned
> previously. Under qemu/kvm the hotplug slot model aligns more with
> x86 where multiple slots are presented under a single PHB. As seen
> in the following each additional slot after the first fails to
> register due to each slot always being compared against the first
> child node of the PHB in the device tree.
...
> 
> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e2413a7dae52fab290b7a8d11e

cheers
