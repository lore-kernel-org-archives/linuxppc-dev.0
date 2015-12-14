Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 788991A010A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 20:46:36 +1100 (AEDT)
In-Reply-To: <1449495280-18819-1-git-send-email-fbarrat@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, imunsie@au1.ibm.com, stable@vger.kernel.org
Subject: Re: cxl: Set endianess of kernel contexts
Message-Id: <20151214094636.2CDE114031F@ozlabs.org>
Date: Mon, 14 Dec 2015 20:46:36 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-07-12 at 13:34:40 UTC, Frederic Barrat wrote:
> A process element (defined in CAIA) keeps track of the endianess of
> contexts through the Little Endian (LE) bit of the State Register. It
> is currently set for user contexts, but was somehow forgotten for
> kernel contexts, so this patch fixes it.
> It could lead to erratic behavior from an AFU when the context is
> attached through the kernel API.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Suggested-by: Michael Neuling <mikey@neuling.org>
> Cc: <stable@vger.kernel.org> # 4.3+

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/e606e035cc7293a3824527d9

cheers
