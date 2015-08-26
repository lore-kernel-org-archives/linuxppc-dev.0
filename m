Return-Path: <rth7680@gmail.com>
Received: from mail-qk0-x22f.google.com (mail-qk0-x22f.google.com
 [IPv6:2607:f8b0:400d:c09::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DEF1F1A0036
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 05:48:41 +1000 (AEST)
Received: by qkch123 with SMTP id h123so120312228qkc.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 12:48:39 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
Subject: Re: Ping Re: [PATCH 0/8] math-emu: Update kernel math-emu code from
 current glibc soft-fp
To: Joseph Myers <joseph@codesourcery.com>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <alpine.DEB.2.10.1507021542380.29415@digraph.polyomino.org.uk>
 <alpine.DEB.2.10.1508191433380.11312@digraph.polyomino.org.uk>
 <1440026806.13406.2.camel@ellerman.id.au>
 <alpine.DEB.2.10.1508261442440.13146@digraph.polyomino.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
From: Richard Henderson <rth@twiddle.net>
Message-ID: <55DE1813.7030901@twiddle.net>
Date: Wed, 26 Aug 2015 12:48:35 -0700
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1508261442440.13146@digraph.polyomino.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/26/2015 07:44 AM, Joseph Myers wrote:
> On Thu, 20 Aug 2015, Michael Ellerman wrote:
>
>> On Wed, 2015-08-19 at 14:39 +0000, Joseph Myers wrote:
>>> I'd like to ping this patch series, not having seen any comments on it.
>>>
>>> [PATCH 0/8] math-emu: Update kernel math-emu code from current glibc soft-fp
>>> https://lkml.org/lkml/2015/7/2/394
>>>
>>> [PATCH 1/8] math-emu: Move math-emu to math-emu-old
>>> https://lkml.org/lkml/2015/7/2/395
>>>
>>> [PATCH 2/8] math-emu: Import current glibc soft-fp as include/math-emu
>>> https://lkml.org/lkml/2015/7/2/398
>>>
>>> [PATCH 3/8] alpha/math-emu: Move alpha from math-emu-old to math-emu
>>> https://lkml.org/lkml/2015/7/2/399
>>>
>>> [PATCH 4/8] powerpc/math-emu: Move powerpc from math-emu-old to math-emu
>>> https://lkml.org/lkml/2015/7/2/400
>>>
>>> [PATCH 5/8] s390/math-emu: Move s390 from math-emu-old to math-emu
>>> https://lkml.org/lkml/2015/7/2/401
>>>
>>> [PATCH 6/8] sh/math-emu: Move sh from math-emu-old to math-emu
>>> https://lkml.org/lkml/2015/7/2/402
>>>
>>> [PATCH 7/8] sparc/math-emu: Move sparc from math-emu-old to math-emu
>>> https://lkml.org/lkml/2015/7/2/404
>>>
>>> [PATCH 8/8] math-emu: Remove math-emu-old
>>> https://lkml.org/lkml/2015/7/2/405
>>>
>>> As noted in patch 0, the dependencies are as follows: patch 2 depends on
>>> patch 1, patches 3-7 depend on patches 1 and 2 but are independent of each
>>> other, patch 8 depends on all the other patches.
>>
>> Hi Joseph,
>>
>> I have done some testing on powerpc, and it seems good.
>>
>> I'm reluctant to proceed with merging them though until we've heard at least
>> *something* from the other maintainers.
>
> Ping again for the other-architecture maintainers (alpha, s390, sh,
> sparc)....
>

I thought I already gave an

Acked-by: Richard Henderson <rth@twiddle.net>

for the alpha patches.


r~
