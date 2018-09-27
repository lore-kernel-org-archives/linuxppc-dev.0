Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42LXfq4J21zDrTQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 21:30:27 +1000 (AEST)
Subject: Re: [PATCH] kdb: use correct pointer when 'btc' calls 'btt'
To: Michael Ellerman <mpe@ellerman.id.au>,
 Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jason Wessel <jason.wessel@windriver.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kgdb-bugreport@lists.sourceforge.net,
 stable@vger.kernel.org, me@tobin.cc
References: <ff05bd36b338f4f914780176e9eba8138e1b254b.1536927765.git.christophe.leroy@c-s.fr>
 <20180916190610.vzqxwps7zqy2zc6o@holly.lan>
 <5f0e0241-b7ab-b5fa-de0e-01abdbc85770@linaro.org>
 <760ed3ff-43d9-75e5-b36c-aaa7871ffe50@c-s.fr>
 <877ej7urh3.fsf@concordia.ellerman.id.au>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <7cf2d115-a58b-4585-37fc-7e58169a43a3@c-s.fr>
Date: Thu, 27 Sep 2018 13:30:22 +0200
MIME-Version: 1.0
In-Reply-To: <877ej7urh3.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 27/09/2018 à 13:09, Michael Ellerman a écrit :
> Christophe LEROY <christophe.leroy@c-s.fr> writes:
>> Le 26/09/2018 à 13:11, Daniel Thompson a écrit :
>>> On 16/09/2018 20:06, Daniel Thompson wrote:
>>>> On Fri, Sep 14, 2018 at 12:35:44PM +0000, Christophe Leroy wrote:
>>>>> On a powerpc 8xx, 'btc' fails as follows:
>>>>> Entering kdb (current=0x(ptrval), pid 282) due to Keyboard Entry
> ...
>>>>>
>>>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>>>> Cc: <stable@vger.kernel.org> # 4.15+
>>>>
>>>> Would a Fixes: be better here?
>>>> Fixes: ad67b74d2469d9b82 ("printk: hash addresses printed with %p")
>>>
>>> Christophe, When you add the Fixes: could you also add my
>>>
>>> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
>>
>> Ok, thanks for the review, but do I have to do anything really ?
>>
>> The Fixes: and now your Reviewed-by: appear automatically in patchwork
>> (https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=65715),
>> so I believe they'll be automatically included when Jason or someone
>> else takes the patch, no ?
> 
> patchwork won't add the Fixes tag from the reply, it needs to be in the
> original mail.
> 
> See:
>    https://github.com/getpatchwork/patchwork/issues/151
> 

Ok, so it accounts it and adds a '1' in the F column in the patches 
list, but won't take it into account.

Then I'll send a v2 with revised commit text.

Christophe
