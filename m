Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D7913DDF8B
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 02:37:40 +1100 (EST)
Message-Id: <3DBA85C8-9096-48B0-9771-D381E507909E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jon Loeliger <jdl@jdl.com>
In-Reply-To: <E1JPIT1-0001ke-GR@jdl.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] [POWERPC] Fix initial lmb add region with a non-zero base
Date: Wed, 13 Feb 2008 09:37:19 -0600
References: <Pine.LNX.4.64.0802130719330.14428@blarg.am.freescale.net>
	<E1JPIT1-0001ke-GR@jdl.com>
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, davem@davemloft.net,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 13, 2008, at 8:20 AM, Jon Loeliger wrote:

> So, like, the other day Kumar Gala mumbled:
>> If we add to an empty lmb region with a non-zero base we will not  
>> coalesce
>> the number of regions done to one.  This causes problems on ppc32  
>> for the
>
> s/done/down

will fix.

>> memory region as its assumed to only have one region.
>>
>> We can fix this be easily specially casing the initial add to just  
>> replace
>> the dummy region.
>>
>> ---
>>
>> Posting this since Dave's looking a pulling the lmb code out into  
>> lib/ and
>> sharing it between powerpc and sparc.
>
> Did you want to S-o-b: this patch?  Or was this just informational?

this was info/for review, the git tree has a s-o-b.

- k
