Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vWxtm6GY2zDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 20:56:32 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: Add translation mode information in
 /proc/cpuinfo
In-Reply-To: <8ec533a5-daf6-4644-ffea-e940fe3e77f9@linux.vnet.ibm.com>
References: <1487499469-15284-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <874lzmn5h1.fsf@concordia.ellerman.id.au>
 <8ec533a5-daf6-4644-ffea-e940fe3e77f9@linux.vnet.ibm.com>
Date: Mon, 27 Feb 2017 20:56:28 +1100
Message-ID: <87tw7gq7n7.fsf@concordia.ellerman.id.au>
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

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> On Wednesday 22 February 2017 11:15 AM, Michael Ellerman wrote:
>> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
>>> diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
>>> index d50c7d99baaf..d38571e289bb 100644
>>> --- a/arch/powerpc/platforms/powernv/setup.c
>>> +++ b/arch/powerpc/platforms/powernv/setup.c
>>> @@ -95,6 +95,10 @@ static void pnv_show_cpuinfo(struct seq_file *m)
>>>   	else
>>>   		seq_printf(m, "firmware\t: BML\n");
>>>   	of_node_put(root);
>>> +	if (radix_enabled())
>>> +		seq_printf(m, "translation\t: Radix\n");
>>> +	else
>>> +		seq_printf(m, "translation\t: Hash\n");
>>>   }
>> Can we just call it "MMU" ?
...
>
> Do you want me to send an updated patch ? or you can update it when you 
> apply it to your tree ?

I'll fix it up.

cheers
