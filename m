Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tT6st408kzDvpx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 15:30:42 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v7 0/7] Radix pte update tlbflush optimizations.
In-Reply-To: <5687de37-0669-82f3-3d1d-735f3db79cf4@gmail.com>
References: <20161128061704.4914-1-aneesh.kumar@linux.vnet.ibm.com>
 <5687de37-0669-82f3-3d1d-735f3db79cf4@gmail.com>
Date: Wed, 30 Nov 2016 15:30:41 +1100
Message-ID: <87lgw1pp1q.fsf@concordia.ellerman.id.au>
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

> On 28/11/16 17:16, Aneesh Kumar K.V wrote:
>> Changes from v6:
>> * restrict the new pte bit to radix and DD1 config
>> 
>> Changes from V5:
>> Switch to use pte bits to track page size.
>
> This series looks much better, I wish there was a better
> way of avoiding to have to pass the address to the ptep function,
> but I guess we get to live with it forever

No, we can always revert it when P9 DD1 is dead and buried.

cheers
