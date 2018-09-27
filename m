Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42LXBg3y7TzF35S
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 21:09:31 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe LEROY <christophe.leroy@c-s.fr>,
 Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jason Wessel <jason.wessel@windriver.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kgdb-bugreport@lists.sourceforge.net,
 stable@vger.kernel.org, me@tobin.cc
Subject: Re: [PATCH] kdb: use correct pointer when 'btc' calls 'btt'
In-Reply-To: <760ed3ff-43d9-75e5-b36c-aaa7871ffe50@c-s.fr>
References: <ff05bd36b338f4f914780176e9eba8138e1b254b.1536927765.git.christophe.leroy@c-s.fr>
 <20180916190610.vzqxwps7zqy2zc6o@holly.lan>
 <5f0e0241-b7ab-b5fa-de0e-01abdbc85770@linaro.org>
 <760ed3ff-43d9-75e5-b36c-aaa7871ffe50@c-s.fr>
Date: Thu, 27 Sep 2018 21:09:28 +1000
Message-ID: <877ej7urh3.fsf@concordia.ellerman.id.au>
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

Christophe LEROY <christophe.leroy@c-s.fr> writes:
> Le 26/09/2018 =C3=A0 13:11, Daniel Thompson a =C3=A9crit=C2=A0:
>> On 16/09/2018 20:06, Daniel Thompson wrote:
>>> On Fri, Sep 14, 2018 at 12:35:44PM +0000, Christophe Leroy wrote:
>>>> On a powerpc 8xx, 'btc' fails as follows:
>>>> Entering kdb (current=3D0x(ptrval), pid 282) due to Keyboard Entry
...
>>>>
>>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>>> Cc: <stable@vger.kernel.org> # 4.15+
>>>
>>> Would a Fixes: be better here?
>>> Fixes: ad67b74d2469d9b82 ("printk: hash addresses printed with %p")
>>=20
>> Christophe, When you add the Fixes: could you also add my
>>=20
>> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
>
> Ok, thanks for the review, but do I have to do anything really ?
>
> The Fixes: and now your Reviewed-by: appear automatically in patchwork=20
> (https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=3D65715),=
=20
> so I believe they'll be automatically included when Jason or someone=20
> else takes the patch, no ?

patchwork won't add the Fixes tag from the reply, it needs to be in the
original mail.

See:
  https://github.com/getpatchwork/patchwork/issues/151


cheers
