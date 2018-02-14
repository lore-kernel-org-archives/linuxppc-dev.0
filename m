Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zh7tQ2NKFzF0xj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 16:55:42 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, stable@vger.kernel.org
Subject: Re: [PATCH] powerpc/xive: use hw CPU ids when configuring the CPU
 queues
In-Reply-To: <592440b1-5943-2315-c477-598900c79521@kaod.org>
References: <20180213084712.18351-1-clg@kaod.org>
 <87a7wd2nwn.fsf@concordia.ellerman.id.au>
 <592440b1-5943-2315-c477-598900c79521@kaod.org>
Date: Wed, 14 Feb 2018 16:55:40 +1100
Message-ID: <87h8qkqfmr.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

C=C3=A9dric Le Goater <clg@kaod.org> writes:

> On 02/13/2018 10:18 AM, Michael Ellerman wrote:
>> C=C3=A9dric Le Goater <clg@kaod.org> writes:
>>=20
>>> The CPU event notification queues on sPAPR should be configured using
>>> a hardware CPU identifier.
>>>
>>> The problem did not show up on the Power Hypervisor because pHyp
>>> supports 8 threads per core which keeps CPU number contiguous. This is
>>> not the case on all sPAPR virtual machines, some use SMT=3D1.
>>>
>>> Also improve error logging by adding the CPU number.
>>>
>>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>> ---
>>>
>>>  I think we should send this one to stable also.
>>=20
>> Fixes: eac1e731b59e ("powerpc/xive: guest exploitation of the XIVE inter=
rupt controller")
>
> yes.
>
>> Cc: stable@vger.kernel.org # v4.14+
>
> yes. I just added the Cc:. I am not sure that will work with=20
> patchwork though.

They don't accept patches that way.

I'll add the tags and commit it.

cheers
