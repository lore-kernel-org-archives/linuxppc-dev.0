Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0F2ED1A0501
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 01:34:22 +1100 (AEDT)
In-Reply-To: <1455840984-24068-4-git-send-email-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [v2,3/3] powerpc: Add POWER9 cputable entry
Message-Id: <20160224143421.C63A914076B@ozlabs.org>
Date: Thu, 25 Feb 2016 01:34:21 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-19-02 at 00:16:24 UTC, Michael Neuling wrote:
> Add a cputable entry for POWER9.  More code is required to actually
> boot and run on a POWER9 but this gets the base piece in which we can
> start building on.
> 
> Copies over from POWER8 except for:
> - Adds a new CPU_FTR_ARCH_300 bit to start hanging new architecture
>    features from (in subsequent patches).
> - Advertises new user features bits PPC_FEATURE2_ARCH_3_00 &
>   HAS_IEEE128 when on POWER9.
> - Drops CPU_FTR_SUBCORE.
> - Drops PMU code and machine check.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c3ab300ea55541014348561e76

cheers
