Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJG205Dy4zDq60
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 20:22:16 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: Fix typo in set_pte_at()
In-Reply-To: <20170208031728.GA20879@gwshan>
References: <1486340396-24609-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <87tw88gi96.fsf@skywalker.in.ibm.com> <20170208031728.GA20879@gwshan>
Date: Wed, 08 Feb 2017 20:22:15 +1100
Message-ID: <87d1et9gvs.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Gavin Shan <gwshan@linux.vnet.ibm.com> writes:

> On Mon, Feb 06, 2017 at 08:03:57AM +0530, Aneesh Kumar K.V wrote:
>>Gavin Shan <gwshan@linux.vnet.ibm.com> writes:
>>
>>> This fixes the typo about the _PAGE_PTE in set_pte_at() by changing
>>> "tryint" to "trying to".
>>>
>>> Fixes: 6a119eae942 ("powerpc/mm: Add a _PAGE_PTE bit")
>>
>>I guess this is not needed. We add that when we want to hint whether the
>>patch needs backporting. 
>>
>
> I just sent v2 to remove the "Fixes" tag.

OK.

I don't mind if you send a Fixes tag even for a trivial fix like this.

It's not incorrect, this commit does fix that other commit.

It's probably true that we wouldn't backport a trivial fix like that,
but having the Fixes tag means we could if we wanted to. And if we don't
want to backport it then it's harmless extra information.

cheers
