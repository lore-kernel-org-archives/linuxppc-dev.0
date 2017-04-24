Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBLMx65c3zDqCC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 19:17:33 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/64s: use ibm,
 tlbiel-congruence-classes-(hash|radix) dt property
In-Reply-To: <8737cy2ozz.fsf@skywalker.in.ibm.com>
References: <20170422005854.17128-1-npiggin@gmail.com>
 <20170422005854.17128-2-npiggin@gmail.com>
 <8737cy2ozz.fsf@skywalker.in.ibm.com>
Date: Mon, 24 Apr 2017 19:17:33 +1000
Message-ID: <87a876rwpe.fsf@concordia.ellerman.id.au>
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

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
> Nicholas Piggin <npiggin@gmail.com> writes:
>> tlbiel instruction with IS!=0 on POWER7 and later Book3s CPUs invalidate
>> TLBs belonging to a specified congruence class. In order to operate on
>> the entire TLB, all congruence classes must be specified, requiring a
>> software loop.
...
>
> This may need a rebase if mpe is going to take https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-April/157130.html

I would but it says "Not yet tested" :)

cheers
