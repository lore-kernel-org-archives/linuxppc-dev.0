Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qk9w41l7BzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 23:32:04 +1000 (AEST)
Message-ID: <1460381518.32475.0.camel@ellerman.id.au>
Subject: Re: [PATCH V2] powerpc/mm: Add validation for platform reserved
 memory ranges
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com
Date: Mon, 11 Apr 2016 23:31:58 +1000
In-Reply-To: <570B4093.1010600@linux.vnet.ibm.com>
References: <1457344559-2505-1-git-send-email-khandual@linux.vnet.ibm.com>
 <570B4093.1010600@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-04-11 at 11:43 +0530, Anshuman Khandual wrote:
> On 03/07/2016 03:25 PM, Anshuman Khandual wrote:
> > For partition running on PHYP, there can be a adjunct partition
> > which shares the virtual address range with the operating system.
> > Virtual address ranges which can be used by the adjunct partition
> > are communicated with virtual device node of the device tree with
> > a property known as "ibm,reserved-virtual-addresses". This patch
> > introduces a new function named 'validate_reserved_va_range' which
> > is called  during initialization to validate that these reserved
> > virtual address ranges do not overlap with the address ranges used
> > by the kernel for all supported memory contexts. This helps prevent
> > the possibility of getting return codes similar to H_RESOURCE for
> > H_PROTECT hcalls for conflicting HPTE entries.
> > 
> > Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> > ---
> > - Tested on both POWER8 LE and BE platforms
> > 
> > Changes in V2:
> > - Added braces to the definition of LINUX_VA_BITS
> > - Adjusted tabs as spaces for the definition of PARTIAL_LINUX_VA_MASK
> 
> mpe, any updates on this ?

I'm just starting to look at things for next. So will try and get to it this
week.

cheers
