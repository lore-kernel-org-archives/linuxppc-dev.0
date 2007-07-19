Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AFB50DDE00
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 08:45:43 +1000 (EST)
In-Reply-To: <20070719143020.5e0b7474.akpm@linux-foundation.org>
References: <20070714012033.GC31649@Krystal>
	<20070718223034.7388e59f.akpm@linux-foundation.org>
	<D9805F9D-04B0-4422-81F1-958B15482A93@kernel.crashing.org>
	<20070719131348.170443bb.akpm@linux-foundation.org>
	<E7820A72-36A3-4B4D-A497-974409D3EBDE@kernel.crashing.org>
	<20070719143020.5e0b7474.akpm@linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DF1DBB27-33A8-43E9-8420-DED6ACBA2364@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Powerpc - Include pagemap.h in asm/powerpc/tlb.h
Date: Thu, 19 Jul 2007 17:46:15 -0500
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linuxppc-dev@ozlabs.org, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 19, 2007, at 4:30 PM, Andrew Morton wrote:

> On Thu, 19 Jul 2007 16:04:38 -0500
> Kumar Gala <galak@kernel.crashing.org> wrote:
>
>>>> Andrew,
>>>>
>>>> Are you sending this to linus directly or should this go via  
>>>> paul and
>>>> me?
>>>>
>>>
>>> I queued it up for Paul.  I can send it over to Linus today if we
>>> have a
>>> reason for that.  It's just that I dont understand the patch: does
>>> it fix
>>> -mm-only breakage?  Does it fix something which already got fixed,
>>> or what?
>>
>> I'm seeing the same breakage in my tree.
>
> Oh, OK.  Let's just merge it.

Hmm, depending on the config it goes away.

Lets hold off on this for a little while so understand exactly what's  
going on.

>>> One might think "gee, it's trivial, just slam it in", but these  
>>> nested
>>> includes are often not-trivial and something else can explode as a
>>> result.
>>
>> I'll do a git-bisect and see if I can find the patch that causes this
>> breakage so we know what's going on.
>
> eh, don't bother.

I think I'll poke around a little since it clearly has some config  
dependancy.

- k
