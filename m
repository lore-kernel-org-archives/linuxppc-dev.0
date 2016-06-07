Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rP9L3178czDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jun 2016 22:07:23 +1000 (AEST)
Message-ID: <1465301235.16285.4.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/mm/hash: Fix the reference bit update when
 handling hash fault
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hugh Dickins <hughd@google.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
Date: Tue, 07 Jun 2016 22:07:15 +1000
In-Reply-To: <alpine.LSU.2.11.1606020807590.9580@eggly.anvils>
References: <201605270629.u4R6OCLx014831@mx0a-001b2d01.pphosted.com>
 <alpine.LSU.2.11.1605300903270.1076@eggly.anvils>
 <1464647262.3078.219.camel@kernel.crashing.org>
 <alpine.LSU.2.11.1605310902480.7816@eggly.anvils>
 <alpine.LSU.2.11.1606020807590.9580@eggly.anvils>
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

On Thu, 2016-06-02 at 08:12 -0700, Hugh Dickins wrote:
> On Tue, 31 May 2016, Hugh Dickins wrote:
> > 
> > But all my evidence so far is that it is now right: I'll continue
> > testing v4.6+fix on a couple of loads until this evening: all is
> > well so far.  And then switch to testing v4.5+fix on those loads
> > for another day and a half.
> 
> I'm glad to confirm: your patch to htab_convert_pte_flags() fixes all
> the elusive sigsegv issues I was seeing under load on v4.5 and v4.6.
> Thank you!

Thanks for all the testing Hugh, and sorry for the bug.

cheers
