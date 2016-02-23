Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C6B301A051A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 12:19:15 +1100 (AEDT)
Date: Tue, 23 Feb 2016 12:16:08 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 3/9] powerpc/mm/book3s-64: Use physical addresses in
 upper page table tree levels
Message-ID: <20160223011608.GA26469@fergus.ozlabs.ibm.com>
References: <1456108880-27464-1-git-send-email-paulus@ozlabs.org>
 <1456108880-27464-4-git-send-email-paulus@ozlabs.org>
 <871t85finc.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <871t85finc.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 22, 2016 at 10:25:51AM +0530, Aneesh Kumar K.V wrote:
> Paul Mackerras <paulus@ozlabs.org> writes:
> 
> > From: Paul Mackerras <paulus@samba.org>
> >
> > This changes the Linux page tables to store physical addresses
> > rather than kernel virtual addresses in the upper levels of the
> > tree (pgd, pud and pmd) for 64-bit Book 3S machines.
> >
> > This frees up some high order bits, and will be needed with
> > PowerISA v3.0 machines which read the page table tree in hardware
> > in radix mode.
> 
> How about hugepd pointer with 4k linux page size ?

Yes, I need to fix them too.  New series coming...

Paul.
