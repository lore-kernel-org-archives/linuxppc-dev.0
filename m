Return-Path: <garsilva@embeddedor.com>
Received: from gateway20.websitewelcome.com (gateway20.websitewelcome.com
 [192.185.62.46])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zYYGL4JXNzDqqR
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Feb 2018 23:35:05 +1100 (AEDT)
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
 by gateway20.websitewelcome.com (Postfix) with ESMTP id 3571D400CD890
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Feb 2018 06:11:09 -0600 (CST)
Date: Sat, 03 Feb 2018 06:11:07 -0600
Message-ID: <20180203061107.Horde.dBz-aI7SC7ZqbG-NQQLPYhF@gator4166.hostgator.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Ellerman <patch-notifications@ellerman.id.au>, Colin Leroy
 <colin@colino.net>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: macintosh: change some data types from int to bool
References: <20180124014228.GA26899@embeddedgus> <3zVGNG6B8Hz9t5Y@ozlabs.org>
 <20180129050920.Horde.QLe9K1M-r7blMvmzflyFRGC@gator4166.hostgator.com>
 <87shao8da3.fsf@concordia.ellerman.id.au>
In-Reply-To: <87shao8da3.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

Quoting Michael Ellerman <mpe@ellerman.id.au>:

> "Gustavo A. R. Silva" <garsilva@embeddedor.com> writes:
>
>> Hi Michael,
>>
>> Quoting Michael Ellerman <patch-notifications@ellerman.id.au>:
>>
>>> On Wed, 2018-01-24 at 01:42:28 UTC, "Gustavo A. R. Silva" wrote:
>>>> Change the data type of the following variables from int to bool
>>>> across all macintosh drivers:
>>>>
>>>> started
>>>> slots_started
>>>> pm121_started
>>>> wf_smu_started
>>>>
>>>> Some of these issues were detected with the help of Coccinelle.
>>>>
>>>> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
>>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>>
>>> Applied to powerpc next, thanks.
>>>
>>> https://git.kernel.org/powerpc/c/4f256d561447c6e1bf8b70e19daae0
>>>
>>> cheers
>>
>> Awesome.
>>
>> If I can help out with anything else, please let me know.
>
> Sure thing.
>
> We have a TODO list of sorts on github, some of them are easy, some are
> not, feel free to ask here or on an individual issue for help:
>
>   https://github.com/linuxppc/linux/issues
>

I'm sorry for the late reply. I was addressing some issues on DRM and  
NET components.

I already took a look into the TODO list. I'll ask you about some of  
the issues on github.

Thanks!
--
Gustavo
