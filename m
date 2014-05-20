Return-Path: <hughd@google.com>
Received: from mail-pb0-x229.google.com (mail-pb0-x229.google.com
 [IPv6:2607:f8b0:400e:c01::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DBF551A0848
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 12:35:47 +1000 (EST)
Received: by mail-pb0-f41.google.com with SMTP id uo5so6646794pbc.28
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 May 2014 19:35:44 -0700 (PDT)
Date: Mon, 19 May 2014 19:34:27 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH V4 0/2] mm: FAULT_AROUND_ORDER patchset performance data
 for powerpc
In-Reply-To: <87d2f9jlpd.fsf@rustcorp.com.au>
Message-ID: <alpine.LSU.2.11.1405191930130.3574@eggly.anvils>
References: <1399541296-18810-1-git-send-email-maddy@linux.vnet.ibm.com>
 <537479E7.90806@linux.vnet.ibm.com>
 <alpine.LSU.2.11.1405151026540.4664@eggly.anvils>
 <87wqdik4n5.fsf@rustcorp.com.au> <53797511.1050409@linux.vnet.ibm.com>
 <alpine.LSU.2.11.1405191531150.1317@eggly.anvils>
 <87d2f9jlpd.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-arch@vger.kernel.org, riel@redhat.com,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, dave.hansen@intel.com,
 peterz@infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, ak@linux.intel.com, paulus@samba.org, mgorman@suse.de,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 20 May 2014, Rusty Russell wrote:
> Hugh Dickins <hughd@google.com> writes:
> >> On Monday 19 May 2014 05:42 AM, Rusty Russell wrote:
> >> > 
> >> > Perhaps we try to generalize from two data points (a slight improvement
> >> > over doing it from 1!), eg:
> >> > 
> >> > /* 4 seems good for 4k-page x86, 0 seems good for 64k page ppc64, so: */
> >> > unsigned int fault_around_order __read_mostly =
> >> >         (16 - PAGE_SHIFT < 0 ? 0 : 16 - PAGE_SHIFT);
> >
> > Rusty's bimodal answer doesn't seem the right starting point to me.
> 
> ?  It's not bimodal, it's graded.  I think you misread?

Yikes, worse than misread, more like I was too rude even to read: sorry!

Hugh
