Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429nW61tR9zF3RN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 15:38:26 +1000 (AEST)
Subject: Re: [PATCH v2] powerpc: Avoid code patching freed init sections
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>, mpe@ellerman.id.au
Cc: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
 linuxppc-dev@lists.ozlabs.org, Haren Myneni <haren@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20180912052058.10062-1-mikey@neuling.org>
 <0922624b-6c6f-1afd-a9e2-cde5a9a8a1e4@c-s.fr>
 <29d3467a9314f5b80f93d241ae2566c48b546bfe.camel@neuling.org>
 <e8a68da4-1c58-b30b-ccd0-f37a9e7c330c@linux.vnet.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <7d32de2e-b390-527d-cd5c-2c5eacc19a2c@c-s.fr>
Date: Thu, 13 Sep 2018 07:38:21 +0200
MIME-Version: 1.0
In-Reply-To: <e8a68da4-1c58-b30b-ccd0-f37a9e7c330c@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 13/09/2018 à 03:21, Tyrel Datwyler a écrit :
> On 09/12/2018 05:36 PM, Michael Neuling wrote:
>>
>>>
>>>> +			(unsigned long)patch_addr);
>>>
>>> Please align second line as per Codying style.
>>
>> Sorry I can't see what's wrong. You're (or Cody :-P) going to have to spell it
>> this out for me...
> 
> I suspect that the suggestion is the opening parenthesis of "(unsigned long)" should sit directly under the "K" of "KERN_DEBUG". I'm pretty sure Documentation/process/coding-style.rst is very adamant that all identation is always 8 characters and spaces should never be used, but there still seems to be a lot of places/suggestions that argument lists that spill over multiple lines should be space indented to align with the very first argument at the top level. So, I guess I'm not sure what the desire is here. Although moving to pr_debug might fit it to a single line anyways. ;)

It is exactly that, as reported by checkpatch, look at 
https://patchwork.ozlabs.org/patch/968850/

Christophe
