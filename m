Return-Path: <srs0=oh4o=h3=intel.com=dave.hansen@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gQMT2vGYzF1dn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 02:45:09 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40gQMT1mj2z8vp7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 02:45:09 +1000 (AEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40gQMS2lVcz9s27
 for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2018 02:45:06 +1000 (AEST)
Subject: Re: [PATCH 4/8] mm/pkeys, powerpc, x86: Provide an empty vma_pkey()
 in linux/pkeys.h
To: Michael Ellerman <mpe@ellerman.id.au>, linuxram@us.ibm.com
References: <20180508145948.9492-1-mpe@ellerman.id.au>
 <20180508145948.9492-5-mpe@ellerman.id.au>
Cc: mingo@redhat.com, linuxppc-dev@ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <1a37801a-fde1-53a3-0082-735834d1e9a4@intel.com>
Date: Tue, 8 May 2018 09:45:02 -0700
MIME-Version: 1.0
In-Reply-To: <20180508145948.9492-5-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/08/2018 07:59 AM, Michael Ellerman wrote:
> Consolidate the pkey handling by providing a common empty definition
> of vma_pkey() in pkeys.h when CONFIG_ARCH_HAS_PKEYS=n.
> 
> This also removes another entanglement of pkeys.h and
> asm/mmu_context.h.

Looks fine to me.  Thanks for consolidating these.

Reviewed-by: Dave Hansen <dave.hansen@intel.com>
