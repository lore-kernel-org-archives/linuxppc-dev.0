Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8W9j1DY0zDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 22:46:33 +1000 (AEST)
In-Reply-To: <1470650268-25085-1-git-send-email-fbarrat@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, imunsie@au1.ibm.com,
 mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: cxl: Set psl_fir_cntl to production environment value
Message-Id: <3s8W9j0RCmz9t1d@ozlabs.org>
Date: Wed, 10 Aug 2016 22:46:32 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-08-08 at 09:57:48 UTC, Frederic Barrat wrote:
> Switch the setting of psl_fir_cntl from debug to production
> environment recommended value. It mostly affects the PSL behavior when
> an error is raised in psl_fir1/2.
> 
> Tested with cxlflash.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Reviewed-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/c6d2ee09c2fffd3efdd31be2b2

cheers
