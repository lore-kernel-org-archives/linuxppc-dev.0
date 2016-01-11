Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9018E1A0B57
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 20:14:05 +1100 (AEDT)
In-Reply-To: <1450435564.2791.98.camel@neuling.org>
To: Michael Neuling <mikey@neuling.org>, benh <benh@kernel.crashing.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Stewart Smith <sesmith@au1.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Anton Blanchard <anton@samba.org>
Subject: Re: powerpc/powernv: Only delay opal_rtc_read() retry when necessary
Message-Id: <20160111091404.DB373140772@ozlabs.org>
Date: Mon, 11 Jan 2016 20:14:04 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-18-12 at 10:46:04 UTC, Michael Neuling wrote:
> Only delay opal_rtc_read() when busy and are going to retry.
> 
> This has the advantage of possibly saving a massive 10ms off booting!
> 
> Kudos to Stewart for noticing.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Reviewed-by: Stewart Smith <stewart@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/57a9039052aadf5833c40ab494

cheers
