Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v3Qlg6MftzDqLd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 23:10:23 +1100 (AEDT)
In-Reply-To: <20170116175853.2458-1-benh@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Paul Mackerras <pmac@au1.ibm.com>
Subject: Re: powerpc/icp-opal: Fix missing KVM case and harden replay
Message-Id: <3v3Qlg5Czkz9tkD@ozlabs.org>
Date: Wed, 18 Jan 2017 23:10:23 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-01-16 at 17:58:53 UTC, Benjamin Herrenschmidt wrote:
> The icp-opal call is missing the code from icp-native to recover
> interrupts snatched by KVM. Without that, when running KVM, we can
> get into a situation where an interrupt is lost and the CPU stuck
> with an elevated CPPR.
> 
> Also harden replay by always checking the return from opal_int_eoi
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/9728a7c8ab2f7a1c8d5c95278d2e4f

cheers
