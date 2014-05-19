Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 by lists.ozlabs.org (Postfix) with ESMTP id 597D51A0815
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 09:43:04 +1000 (EST)
Date: Mon, 19 May 2014 16:43:01 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH V4 0/2] mm: FAULT_AROUND_ORDER patchset performance data
 for powerpc
Message-Id: <20140519164301.eafd3dd288ccb88361ddcfc7@linux-foundation.org>
In-Reply-To: <alpine.LSU.2.11.1405191531150.1317@eggly.anvils>
References: <1399541296-18810-1-git-send-email-maddy@linux.vnet.ibm.com>
 <537479E7.90806@linux.vnet.ibm.com>
 <alpine.LSU.2.11.1405151026540.4664@eggly.anvils>
 <87wqdik4n5.fsf@rustcorp.com.au>
 <53797511.1050409@linux.vnet.ibm.com>
 <alpine.LSU.2.11.1405191531150.1317@eggly.anvils>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-arch@vger.kernel.org, x86@kernel.org, riel@redhat.com,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, dave.hansen@intel.com,
 peterz@infradead.org, Rusty Russell <rusty@rustcorp.com.au>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, ak@linux.intel.com,
 paulus@samba.org, mgorman@suse.de, linuxppc-dev@lists.ozlabs.org,
 mingo@kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 19 May 2014 16:23:07 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:

> Shouldn't FAULT_AROUND_ORDER and fault_around_order be changed to be
> the order of the fault-around size in bytes, and fault_around_pages()
> use 1UL << (fault_around_order - PAGE_SHIFT)

Yes.  And shame on me for missing it (this time!) at review.

There's still time to fix this.  Patches, please.
