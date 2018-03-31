Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40D0bD2dgSzF1ps
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2018 01:04:08 +1100 (AEDT)
In-Reply-To: <20180326100450.18614-2-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [V6, 1/4] powerpc/mm/slice: Consolidate return path in
 slice_get_unmapped_area()
Message-Id: <40D0bB01P9z9s3B@ozlabs.org>
Date: Sun,  1 Apr 2018 01:04:03 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-03-26 at 10:04:47 UTC, "Aneesh Kumar K.V" wrote:
> In a following patch, on finding a free area we will need to do
> allocatinon of extra contexts as needed. Consolidating the return path
> for slice_get_unmapped_area() will make that easier.
> 
> Split into a separate patch to make review easy.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0dea04b288c06654b0de3563c5b8cd

cheers
