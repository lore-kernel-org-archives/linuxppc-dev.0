Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrvdf3MkXzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 22:12:54 +1000 (AEST)
In-Reply-To: <1458588768-21253-1-git-send-email-fbarrat@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, imunsie@au1.ibm.com,
 mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v2,next] cxl: Allow initialization on timebase sync failures
Message-Id: <3qrvdf1Sz4z9t3h@ozlabs.org>
Date: Fri, 22 Apr 2016 22:12:53 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-21-03 at 19:32:48 UTC, Frederic Barrat wrote:
> Failure to synchronize the PSL timebase currently prevents the
> initialization of the cxl card, thus rendering the card useless. This
> is too extreme for a feature which is rarely used, if at all. No
> hardware AFUs or software is currently using PSL timebase.
> 
> This patch still tries to synchronize the PSL timebase when the card
> is initialized, but ignores the error if it can't. Instead, it reports
> a status via /sys.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e009a7e858fed215cb4eed5174

cheers
