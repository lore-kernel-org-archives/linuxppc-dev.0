Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A93AE1A0D9E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 19:56:37 +1100 (AEDT)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Fri, 16 Jan 2015 01:56:35 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id C794519D803E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 01:47:44 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0G8uV2M45940886
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 01:56:31 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0G8uUm8012986
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 01:56:31 -0700
Message-ID: <54B8D228.4000407@linux.vnet.ibm.com>
Date: Fri, 16 Jan 2015 14:26:08 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: offlining cpus breakage
References: <54ACFE6D.3070308@ozlabs.ru> <54B7BEF9.8090603@linux.vnet.ibm.com>
 <54B85B3C.1030000@ozlabs.ru> <1421377482.18166.5.camel@ellerman.id.au>
In-Reply-To: <1421377482.18166.5.camel@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/16/2015 08:34 AM, Michael Ellerman wrote:
> On Fri, 2015-01-16 at 13:28 +1300, Alexey Kardashevskiy wrote:
>> On 01/16/2015 02:22 AM, Preeti U Murthy wrote:
>>> Hi Alexey,
>>>
>>> Can you let me know if the following patch fixes the issue for you ?
>>> It did for us on one of our machines that we were investigating on.
>>
>> This fixes the issue for me as well, thanks!
>>
>> Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>	
> 
> OK, that's great.
> 
> But, I really don't think we can ask upstream to merge this patch to generic
> code when we don't have a good explanation for why it's necessary. At least I'm
> not going to ask anyone to do that :)
> 
> So Pretti can you either write a 100% convincing explanation of why this patch
> is correct in the general case, or (preferably) do some more investigating to
> work out what Alexey's bug actually is.

Yes will do so. Its better to investigate where precisely is the bug.
This patch helped me narrow down on the buggy scenario.

Regards
Preeti U Murthy
> 
> cheers
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
