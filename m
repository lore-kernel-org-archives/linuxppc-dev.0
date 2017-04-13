Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3Z5X2KndzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 18:41:36 +1000 (AEST)
Subject: Re: [PATCH] powerpc/configs: Enable function trace by default
To: Balbir Singh <bsingharora@gmail.com>, mpe@ellerman.id.au
References: <20170413070309.10497-1-bsingharora@gmail.com>
 <eea3c818-f5ca-4cd9-c715-307104534970@c-s.fr>
 <1492071568.8380.20.camel@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <585eeaa5-52bd-7fe4-2179-3582570966e5@c-s.fr>
Date: Thu, 13 Apr 2017 10:41:32 +0200
MIME-Version: 1.0
In-Reply-To: <1492071568.8380.20.camel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 13/04/2017 à 10:19, Balbir Singh a écrit :
> On Thu, 2017-04-13 at 09:24 +0200, Christophe LEROY wrote:
>> Hi Baldir
>
> Hi Christophe, It's Balbir

Sorry

>
>>
>> Le 13/04/2017 à 09:03, Balbir Singh a écrit :
>>> We expect to have these configs on by default, most
>>> distros turn them off, its always good to have them on
>>> so that we can use them and hopefully not break them
>>
>> Isn't it the purpose of the target allyesconfig to allow such tests ?
>>
>
> As a developer I don't use allyesconfig for submitting patches or testing
> the kernel.

I do it most of the time to check compilation doesn't fail.

>
>> FTRACE is quite CPU consumming, shouldn't it really be on by default ?
>
> It does some work at boot to NOP out function entry points at _mcount
> locations. Is that what you are referring to? Or the overhead of the
> code in terms of size? Most distro kernels have tracing on by default.

You said in you patch text: "most distros turn them off".

If most distros turn it ON (and not OFF as you said), then I can 
understand we have it ON as well in defconfigs.

Christophe

>
> The rest of the overhead is enablement based.
>
> Thanks for the review!
> Balbir Singh
>
