Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 535D81A0B62
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 01:34:20 +1100 (AEDT)
In-Reply-To: <1455840984-24068-2-git-send-email-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [v2,
 1/3] powerpc/powernv: Create separate subcores CPU feature bit
Message-Id: <20160224143420.33DB7140557@ozlabs.org>
Date: Thu, 25 Feb 2016 01:34:20 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-19-02 at 00:16:22 UTC, Michael Neuling wrote:
> Subcores isn't really part of the 2.07 architecture but currently we
> turn it on using the 2.07 feature bit.  Subcores is really a POWER8
> specific feature.
> 
> This adds a new CPU_FTR bit just for subcores and moves the subcore
> init code over to use this.
> 
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ce5732a28dd09956540f61ba9d

cheers
