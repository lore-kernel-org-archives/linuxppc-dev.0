Return-Path: <bsingharora@gmail.com>
Received: from mail-lf0-x22a.google.com (mail-lf0-x22a.google.com
 [IPv6:2a00:1450:4010:c07::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3fJs1MNhzDq7j
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 21:51:41 +1000 (AEST)
Received: by mail-lf0-x22a.google.com with SMTP id s141so28309784lfe.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 04:51:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <585eeaa5-52bd-7fe4-2179-3582570966e5@c-s.fr>
References: <20170413070309.10497-1-bsingharora@gmail.com>
 <eea3c818-f5ca-4cd9-c715-307104534970@c-s.fr>
 <1492071568.8380.20.camel@gmail.com>
 <585eeaa5-52bd-7fe4-2179-3582570966e5@c-s.fr>
From: Balbir Singh <bsingharora@gmail.com>
Date: Thu, 13 Apr 2017 21:51:37 +1000
Message-ID: <CAKTCnznab6t9btdz9ZubgO05ju_Zv3uB+h0Z9Y9M3PUBGku8bQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/configs: Enable function trace by default
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 13, 2017 at 6:41 PM, Christophe LEROY
<christophe.leroy@c-s.fr> wrote:
>
>
> Le 13/04/2017 =C3=A0 10:19, Balbir Singh a =C3=A9crit :
>>
>> On Thu, 2017-04-13 at 09:24 +0200, Christophe LEROY wrote:
>>>
>>> Hi Baldir
>>
>>
>> Hi Christophe, It's Balbir
>
>
> Sorry
>
No worries!

>>
>>>
>>> Le 13/04/2017 =C3=A0 09:03, Balbir Singh a =C3=A9crit :
>>>>
>>>> We expect to have these configs on by default, most
>>>> distros turn them off, its always good to have them on
>>>> so that we can use them and hopefully not break them
>>>
>>>
>>> Isn't it the purpose of the target allyesconfig to allow such tests ?
>>>
>>
>> As a developer I don't use allyesconfig for submitting patches or testin=
g
>> the kernel.
>
>
> I do it most of the time to check compilation doesn't fail.
>
>>
>>> FTRACE is quite CPU consumming, shouldn't it really be on by default ?
>>
>>
>> It does some work at boot to NOP out function entry points at _mcount
>> locations. Is that what you are referring to? Or the overhead of the
>> code in terms of size? Most distro kernels have tracing on by default.
>
>
> You said in you patch text: "most distros turn them off".
>

My bad.. sometimes one can type faster than one can think, this is one
of those occasions :)

> If most distros turn it ON (and not OFF as you said), then I can understa=
nd

Yes

Balbir Singh.
