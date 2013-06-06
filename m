Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9ABD32C02EB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jun 2013 16:06:04 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 6 Jun 2013 15:57:31 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1542E2BB0050
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jun 2013 16:05:51 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r565pFdm64749670
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Jun 2013 15:51:15 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5665nSi030212
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Jun 2013 16:05:49 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH -V10 00/15] THP support for PPC64
In-Reply-To: <20130605171310.065c6fe2a3313c69bcfa0fc8@linux-foundation.org>
References: <1370446119-8837-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1370475066.3766.249.camel@pasglop>
 <20130605171310.065c6fe2a3313c69bcfa0fc8@linux-foundation.org>
Date: Thu, 06 Jun 2013 11:35:47 +0530
Message-ID: <8738svyds4.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andrew Morton <akpm@linux-foundation.org> writes:

> On Thu, 06 Jun 2013 09:31:06 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
>> On Wed, 2013-06-05 at 20:58 +0530, Aneesh Kumar K.V wrote:
>> > 
>> > This is the second patchset needed to support THP on ppc64. Some of the changes
>> > included in this series are tricky in that it changes the powerpc linux page table
>> > walk subtly. We also overload few of the pte flags for ptes at PMD level (huge
>> > page PTEs).
>> > 
>> > The related mm/ changes are already merged to Andrew's -mm tree.
>> 
>> If I am to put that into powerpc-next, I need the dependent mm/ changes as well.
>> 
>> Do you have them in the form of a separate git tree that is *exactly* (same SHA1s)
>> what is expected to go upstream via Andrew ?
>> 
>> Andrew, are they fully acked on your side and ready to go ?
>
> Not being on linuxppc-dev I'm at a bit of a loss here.
>
> I assume we're referring to
>
> mm-thp-add-pmd-args-to-pgtable-deposit-and-withdraw-apis.patch
> mm-thp-withdraw-the-pgtable-after-pmdp-related-operations.patch
> mm-thp-withdraw-the-pgtable-after-pmdp-related-operations-fix.patch
> mm-thp-dont-use-hpage_shift-in-transparent-hugepage-code.patch
> mm-thp-deposit-the-transpare-huge-pgtable-before-set_pmd.patch
>

There is one more:

mm/THP: Use the right function when updating access flags

mm-thp-use-the-right-function-when-updating-access-flags.patc

-aneesh
