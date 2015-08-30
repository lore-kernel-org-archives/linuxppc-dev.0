Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 70E8C1A0163
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 07:20:41 +1000 (AEST)
In-Reply-To: <55E00FC0.5090906@linux.vnet.ibm.com>
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, imunsie@au1.ibm.com
Subject: Re: [RESEND] cxl: Set up and enable PSL Timebase
Message-Id: <20150830212041.58D4D1401F6@ozlabs.org>
Date: Mon, 31 Aug 2015 07:20:41 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-28-08 at 07:37:36 UTC, Philippe Bergheaud wrote:
> This patch configures the PSL Timebase function and enables it,
> after the CAPP has been initialized by OPAL.
> 
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>
> Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/390fd5929f52bdfb9dfcc038

cheers
