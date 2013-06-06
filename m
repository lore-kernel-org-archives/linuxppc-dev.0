Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id AECA32C0077
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jun 2013 10:13:12 +1000 (EST)
Date: Wed, 5 Jun 2013 17:13:10 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH -V10 00/15] THP support for PPC64
Message-Id: <20130605171310.065c6fe2a3313c69bcfa0fc8@linux-foundation.org>
In-Reply-To: <1370475066.3766.249.camel@pasglop>
References: <1370446119-8837-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1370475066.3766.249.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 06 Jun 2013 09:31:06 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Wed, 2013-06-05 at 20:58 +0530, Aneesh Kumar K.V wrote:
> > 
> > This is the second patchset needed to support THP on ppc64. Some of the changes
> > included in this series are tricky in that it changes the powerpc linux page table
> > walk subtly. We also overload few of the pte flags for ptes at PMD level (huge
> > page PTEs).
> > 
> > The related mm/ changes are already merged to Andrew's -mm tree.
> 
> If I am to put that into powerpc-next, I need the dependent mm/ changes as well.
> 
> Do you have them in the form of a separate git tree that is *exactly* (same SHA1s)
> what is expected to go upstream via Andrew ?
> 
> Andrew, are they fully acked on your side and ready to go ?

Not being on linuxppc-dev I'm at a bit of a loss here.

I assume we're referring to

mm-thp-add-pmd-args-to-pgtable-deposit-and-withdraw-apis.patch
mm-thp-withdraw-the-pgtable-after-pmdp-related-operations.patch
mm-thp-withdraw-the-pgtable-after-pmdp-related-operations-fix.patch
mm-thp-dont-use-hpage_shift-in-transparent-hugepage-code.patch
mm-thp-deposit-the-transpare-huge-pgtable-before-set_pmd.patch

?

Yes, they're ready to go.  I'll squirt them over at you and will drop
my copies when I see them turn up in linux-next.
