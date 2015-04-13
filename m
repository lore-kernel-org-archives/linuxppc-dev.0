Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DEC521A01A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 01:27:44 +1000 (AEST)
Received: from /spool/local
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Mon, 13 Apr 2015 16:27:41 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 71C6917D8042
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 16:28:13 +0100 (BST)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
 [9.149.37.247])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3DFRcKp9961768
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 15:27:38 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3DFRYii000856
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 09:27:37 -0600
Message-ID: <552BE064.4000903@linux.vnet.ibm.com>
Date: Mon, 13 Apr 2015 17:27:32 +0200
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Pavel Emelyanov <xemul@parallels.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [RESEND PATCH v3 1/2] mm: Introducing arch_remap hook
References: <cover.1428916945.git.ldufour@linux.vnet.ibm.com>
 <9d827fc618a718830b2c47aa87e8be546914c897.1428916945.git.ldufour@linux.vnet.ibm.com>
 <20150413115811.GA12354@node.dhcp.inet.fi>
 <552BB972.3010704@linux.vnet.ibm.com>
 <20150413131357.GC12354@node.dhcp.inet.fi>
 <552BC2CA.80309@linux.vnet.ibm.com> <552BC619.9080603@parallels.com>
 <20150413140219.GA14480@node.dhcp.inet.fi>
 <552BCE87.8040103@linux.vnet.ibm.com>
 <20150413142655.GA14646@node.dhcp.inet.fi> <552BD37A.8070505@parallels.com>
In-Reply-To: <552BD37A.8070505@parallels.com>
Content-Type: text/plain; charset=windows-1252
Cc: Rik van Riel <riel@redhat.com>, Hugh Dickins <hughd@google.com>,
 linux-kernel@vger.kernel.org, criu@openvz.org, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, Mel Gorman <mgorman@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, cov@codeaurora.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 13/04/2015 16:32, Pavel Emelyanov wrote:
>>>> I initially thought it would be enough to put it into
>>>> <asm-generic/mmu_context.h>, expecting it works as
>>>> <asm-generic/pgtable.h>. But that's not the case.
>>>>
>>>> It probably worth at some point rework all <asm/mmu_context.h> to include
>>>> <asm-generic/mmu_context.h> at the end as we do for <asm/pgtable.h>.
>>>> But that's outside the scope of the patchset, I guess.
>>>>
>>>> I don't see any better candidate for such dummy header. :-/
>>>
>>> Clearly, I'm not confortable with a rewrite of <asm/mmu_context.h> :(
>>>
>>> So what about this patch, is this v3 acceptable ?
>>
>> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> Other than the #ifdef thing, the same:
> 
> Acked-by: Pavel Emelyanov <xemul@parallels.com>
> 

Thanks Kirill and Pavel.

Should I send a new version fixing the spaces around the plus sign ?

Cheers,
Laurent.
