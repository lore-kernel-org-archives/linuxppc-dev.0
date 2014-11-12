Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 211681A015A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 18:37:42 +1100 (AEDT)
Message-ID: <54630E44.3060702@ozlabs.org>
Date: Wed, 12 Nov 2014 15:37:40 +0800
From: Jeremy Kerr <jk@ozlabs.org>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, minyard@acm.org
Subject: Re: [PATCH 0/2] Add IPMI support for powernv powerpc machines
References: <1415245107.292153.444216242273.0.gpush@pablo>	
 <545B826F.7050501@acm.org> <1415772636.10731.6.camel@concordia>
In-Reply-To: <1415772636.10731.6.camel@concordia>
Content-Type: text/plain; charset=utf-8
Cc: openipmi-developer@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Corey,

>>> Alternatively, they could be merged by one maintainer, pending an ack
>>> from the other.
>>
>> I'm fine either way.
> 
> How about the third option? :)
> 
> I've put patch 1 in a topic branch:
> 
>   https://git.kernel.org/cgit/linux/kernel/git/mpe/linux.git/log/?h=topic/opal-ipmi
> 
> And will merge that into my next, probably by tomorrow.
> 
> If you merge the topic branch and then apply patch 2/2, then it should all go
> in without any hiccups.

OK, and I have an updated IPMI driver patch (ie, 2/2) that will apply on
top of the new ipmi/for-next tree (best done after that merge). Patch
coming shortly...

Cheers,


Jeremy
