Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gfcN5GbWzF27h
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 11:57:08 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Dave Hansen <dave.hansen@intel.com>, linuxram@us.ibm.com
Cc: mingo@redhat.com, linuxppc-dev@ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] mm/pkeys, x86,
 powerpc: Display pkey in smaps if arch supports pkeys
In-Reply-To: <cd58dbfe-55f9-bb9a-d907-0f92740a8c2e@intel.com>
References: <20180508145948.9492-1-mpe@ellerman.id.au>
 <20180508145948.9492-9-mpe@ellerman.id.au>
 <cd58dbfe-55f9-bb9a-d907-0f92740a8c2e@intel.com>
Date: Wed, 09 May 2018 11:57:08 +1000
Message-ID: <87lgctzj4b.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dave Hansen <dave.hansen@intel.com> writes:

> On 05/08/2018 07:59 AM, Michael Ellerman wrote:
>> Currently the architecture specific code is expected to display the
>> protection keys in smap for a given vma. This can lead to redundant
>> code and possibly to divergent formats in which the key gets
>> displayed.
>> 
>> This patch changes the implementation. It displays the pkey only if
>> the architecture support pkeys, i.e arch_pkeys_enabled() returns true.
>
>
> For this, along with 6/8 and 7/8:
>
> Reviewed-by: Dave Hansen <dave.hansen@intel.com>

Thanks for reviewing them all.

cheers
