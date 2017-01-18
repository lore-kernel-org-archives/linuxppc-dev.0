Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v3Qld659SzDqHy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 23:10:21 +1100 (AEDT)
In-Reply-To: <20161214043753.25934-1-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, Scott Wood <oss@buserror.net>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: powerpc/mm: Fix little-endian 4K hugetlb
Message-Id: <3v3Qld5HwYz9tJD@ozlabs.org>
Date: Wed, 18 Jan 2017 23:10:21 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-12-14 at 04:37:53 UTC, "Aneesh Kumar K.V" wrote:
> When we switched to big endian page table, we never updated
> the hugepd format such that it can work for both big endian and
> little endian config. This patch series update hugepd format
> such that it is looked at as __be64 value in big endian page
> table config.
> 
> This patch also switch hugepd_t.pd from signed long to unsigned long.
> I did update the FSL hugepd_ok check to check for the top bit instead
> of checking > 0.
> 
> Fixes: 5dc1ef858c12f8 ("powerpc/mm: Use big endian Linux page tables for book3s 64")
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/20717e1ff52672e31f9399c45d8893

cheers
