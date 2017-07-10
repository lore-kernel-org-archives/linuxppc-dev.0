Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x5hT73f6czDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 20:36:11 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Michael Neuling <michael.neuling@au1.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/mm/radix: Properly clear process table entry
In-Reply-To: <1499659154.2865.5.camel@kernel.crashing.org>
References: <1499517932.3397.22.camel@kernel.crashing.org>
 <87bmot9cf8.fsf@concordia.ellerman.id.au>
 <1499659154.2865.5.camel@kernel.crashing.org>
Date: Mon, 10 Jul 2017 20:36:08 +1000
Message-ID: <87eftovasn.fsf@concordia.ellerman.id.au>
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Mon, 2017-07-10 at 13:51 +1000, Michael Ellerman wrote:
>> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>> 
>> > On radix, the process table entry we want to clear when
>> > destroying a context is entry 0, not entry 1
>> 
>> .. but has no real world consequence? Or causes the system to instantly
>> catch fire?
>
> It has no *immediate* consequence on P9 , but it can cause other bugs
> to become worse (such as the KVM issue I'm chasing).

OK, I'll flag it for stable then to be safe.

cheers
