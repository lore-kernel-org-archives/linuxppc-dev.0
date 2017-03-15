Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjqHT4NHlzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 22:33:41 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>, Oliver O'Halloran <oohall@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 5/5] powerpc/smp: Add Power9 scheduler topology
In-Reply-To: <3ef222c7-15f7-e981-394d-61cf4b26a1cc@gmail.com>
References: <20170302004920.21948-1-oohall@gmail.com>
 <20170302004920.21948-5-oohall@gmail.com>
 <3ef222c7-15f7-e981-394d-61cf4b26a1cc@gmail.com>
Date: Wed, 15 Mar 2017 22:33:40 +1100
Message-ID: <87varakc4r.fsf@concordia.ellerman.id.au>
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

Balbir Singh <bsingharora@gmail.com> writes:

> On 02/03/17 11:49, Oliver O'Halloran wrote:
>> In previous generations of Power processors each core had a private L2
>> cache. The Power9 processor has a slightly different architecture where
>> the L2 cache is shared among pairs of cores rather than being completely
>> private.
>> 
>> Making the scheduler aware of this cache sharing allows the scheduler to
>> make more intelligent migration decisions. When one core in the pair is
>> overloaded tasks can be migrated to its paired core to improve throughput
>> without cache-refilling penality typically associated with task
>> migration.
>
> Could you please describe the changes to sched_domains w.r.t before and
> after for P9.

Yes please.

cheers
