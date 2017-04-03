Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxSc13Pp7zDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Apr 2017 20:13:21 +1000 (AEST)
In-Reply-To: <1490117400-9891-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [V3,01/10] powerpc/mm/nohash: MM_SLICE is only used by book3s 64
Message-Id: <3vxSc12215z9s89@ozlabs.org>
Date: Mon,  3 Apr 2017 20:13:21 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-03-21 at 17:29:51 UTC, "Aneesh Kumar K.V" wrote:
> BOOKE code is dead code as per the Kconfig details. So make it simpler
> by enabling MM_SLICE only for book3s_64. The changes w.r.t nohash is just
> removing deadcode. W.r.t ppc64, 4k without hugetlb will now enable MM_SLICE.
> But that is good, because we reduce one extra variant which probably is not
> getting tested much.
> 
> Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b42279f0165cdfb093718ec368e56d

cheers
