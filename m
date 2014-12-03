Return-Path: <mgorman@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 349A81A0588
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 02:52:52 +1100 (AEDT)
Date: Wed, 3 Dec 2014 15:52:43 +0000
From: Mel Gorman <mgorman@suse.de>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 03/10] mm: Convert p[te|md]_numa users to
 p[te|md]_protnone_numa
Message-ID: <20141203155242.GE6043@suse.de>
References: <1416578268-19597-1-git-send-email-mgorman@suse.de>
 <1416578268-19597-4-git-send-email-mgorman@suse.de>
 <1417473762.7182.8.camel@kernel.crashing.org>
 <87k32ah5q3.fsf@linux.vnet.ibm.com>
 <1417551115.27448.7.camel@kernel.crashing.org>
 <87lhmobvuu.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <87lhmobvuu.fsf@linux.vnet.ibm.com>
Cc: Rik van Riel <riel@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Sasha Levin <sasha.levin@oracle.com>,
 Dave Jones <davej@redhat.com>, LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 03, 2014 at 08:53:37PM +0530, Aneesh Kumar K.V wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > On Tue, 2014-12-02 at 12:57 +0530, Aneesh Kumar K.V wrote:
> >> Now, hash_preload can possibly insert an hpte in hash page table even if
> >> the access is not allowed by the pte permissions. But i guess even that
> >> is ok. because we will fault again, end-up calling hash_page_mm where we
> >> handle that part correctly.
> >
> > I think we need a test case...
> >
> 
> I ran the subpageprot test that Paul had written. I modified it to ran
> with selftest. 
> 

It's implied but can I assume it passed? If so, Ben and Paul, can I
consider the series to be acked by you other than the minor comment
updates?

Thanks.

-- 
Mel Gorman
SUSE Labs
