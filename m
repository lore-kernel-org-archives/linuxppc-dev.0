Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mFrr66NlzF14s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 23:38:52 +1000 (AEST)
In-Reply-To: <20180514093922.27179-1-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [kernel, v3] powerpc/ioda: Use ibm,
 supported-tce-sizes for IOMMU page size mask
Message-Id: <40mFrr0jyRz9s3B@ozlabs.org>
Date: Wed, 16 May 2018 23:38:51 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-05-14 at 09:39:22 UTC, Alexey Kardashevskiy wrote:
> At the moment we assume that IODA2 and newer PHBs can always do 4K/64K/16M
> IOMMU pages, however this is not the case for POWER9 and now skiboot
> advertises the supported sizes via the device so we use that instead
> of hard coding the mask.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7ef73cd39b4e2829ee88c06f938bc7

cheers
