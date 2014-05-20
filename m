Return-Path: <rusty@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9D0A51A084C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 17:17:07 +1000 (EST)
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH V4 0/2] mm: FAULT_AROUND_ORDER patchset performance data
 for powerpc
In-Reply-To: <20140520004429.E660AE009B@blue.fi.intel.com>
References: <1399541296-18810-1-git-send-email-maddy@linux.vnet.ibm.com>
 <537479E7.90806@linux.vnet.ibm.com>
 <alpine.LSU.2.11.1405151026540.4664@eggly.anvils>
 <87wqdik4n5.fsf@rustcorp.com.au> <53797511.1050409@linux.vnet.ibm.com>
 <alpine.LSU.2.11.1405191531150.1317@eggly.anvils>
 <20140519164301.eafd3dd288ccb88361ddcfc7@linux-foundation.org>
 <20140520004429.E660AE009B@blue.fi.intel.com>
Date: Tue, 20 May 2014 15:52:07 +0930
Message-ID: <87oaythsvk.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-arch@vger.kernel.org, riel@redhat.com,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, dave.hansen@intel.com,
 peterz@infradead.org, x86@kernel.org, Hugh Dickins <hughd@google.com>,
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

"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> writes:
> Andrew Morton wrote:
>> On Mon, 19 May 2014 16:23:07 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:
>> 
>> > Shouldn't FAULT_AROUND_ORDER and fault_around_order be changed to be
>> > the order of the fault-around size in bytes, and fault_around_pages()
>> > use 1UL << (fault_around_order - PAGE_SHIFT)
>> 
>> Yes.  And shame on me for missing it (this time!) at review.
>> 
>> There's still time to fix this.  Patches, please.
>
> Here it is. Made at 3.30 AM, build tested only.

Prefer on top of Maddy's patch which makes it always a variable, rather
than CONFIG_DEBUG_FS.  It's got enough hair as it is.

Cheers,
Rusty.
