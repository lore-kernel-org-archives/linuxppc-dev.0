Return-Path: <srs0=oh4o=h3=intel.com=dave.hansen@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gQRY2fDpzF1nR
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 02:48:41 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40gQRY1t0dz8t79
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 02:48:41 +1000 (AEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40gQRX3h73z9s2k
 for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2018 02:47:19 +1000 (AEST)
Subject: Re: [PATCH 8/8] mm/pkeys, x86, powerpc: Display pkey in smaps if arch
 supports pkeys
To: Michael Ellerman <mpe@ellerman.id.au>, linuxram@us.ibm.com
References: <20180508145948.9492-1-mpe@ellerman.id.au>
 <20180508145948.9492-9-mpe@ellerman.id.au>
Cc: mingo@redhat.com, linuxppc-dev@ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <cd58dbfe-55f9-bb9a-d907-0f92740a8c2e@intel.com>
Date: Tue, 8 May 2018 09:47:15 -0700
MIME-Version: 1.0
In-Reply-To: <20180508145948.9492-9-mpe@ellerman.id.au>
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
> Currently the architecture specific code is expected to display the
> protection keys in smap for a given vma. This can lead to redundant
> code and possibly to divergent formats in which the key gets
> displayed.
> 
> This patch changes the implementation. It displays the pkey only if
> the architecture support pkeys, i.e arch_pkeys_enabled() returns true.


For this, along with 6/8 and 7/8:

Reviewed-by: Dave Hansen <dave.hansen@intel.com>
