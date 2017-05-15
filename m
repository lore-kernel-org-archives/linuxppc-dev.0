Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRFxp2j7LzDqP3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 19:43:10 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: pc@us.ibm.com, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/64s: dt_cpu_ftrs boot time setup option
In-Reply-To: <7f6307f3-6b5a-f655-a93c-3eb4bb1c2062@us.ibm.com>
References: <20170511112441.30287-1-npiggin@gmail.com>
 <9b214f48-9d56-440c-f6d0-6308ff47305d@us.ibm.com>
 <87inl6butu.fsf@concordia.ellerman.id.au>
 <7f6307f3-6b5a-f655-a93c-3eb4bb1c2062@us.ibm.com>
Date: Mon, 15 May 2017 19:43:08 +1000
Message-ID: <87vap2a21f.fsf@concordia.ellerman.id.au>
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

Paul Clarke <pc@us.ibm.com> writes:

> On 05/11/2017 10:46 PM, Michael Ellerman wrote:
>> Paul Clarke <pc@us.ibm.com> writes:
>>> On 05/11/2017 06:24 AM, Nicholas Piggin wrote:
>>>> Provide a dt_cpu_ftrs= cmdline option to disable the dt_cpu_ftrs CPU
>>>> feature discovery, and fall back to the "cputable" based version.
>>>
>>> This boat has already sailed, I think, but "ftrs"?
>> 
>> What you think vowels grow on trees! :)
>
> At least you're using lower-case, which takes less space.  ;-)
>
>>> Was it too difficult to type "features"?
>
> I see "ftrs" and think "footers".

"FTR" - the shouty version - has meant "feature" in the powerpc code
base since at least 2002.

So it may be a crappy abbreviation but it's at least consistent :)

cheers
