Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4EA97DDEDC
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 01:24:18 +1000 (EST)
Message-Id: <C786174A-78C1-40B6-ABC9-24E7419FA182@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org
In-Reply-To: <1216958433.11188.70.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [RFC] 4xx hardware watchpoint support
Date: Fri, 25 Jul 2008 10:23:44 -0500
References: <1211391577.6232.15.camel@gargoyle>
	<18484.60888.981390.893747@cargo.ozlabs.ibm.com>
	<1213992894.6635.41.camel@gargoyle>
	<20080719093752.5aada45c@zod.rchland.ibm.com>
	<1216658194.5727.36.camel@gargoyle>
	<20080721130551.23a06006@zod.rchland.ibm.com>
	<1216777678.5727.82.camel@gargoyle>
	<20080723115321.53aa655b@zod.rchland.ibm.com>
	<1216829442.5727.97.camel@gargoyle>
	<1216958433.11188.70.camel@pasglop>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 24, 2008, at 11:00 PM, Benjamin Herrenschmidt wrote:

> On Wed, 2008-07-23 at 13:10 -0300, Luis Machado wrote:
>> On Wed, 2008-07-23 at 11:53 -0400, Josh Boyer wrote:
>>> Shouldn't this (and other places) be:
>>>
>>> #if defined(CONFIG_44x) || defined(CONFIG_BOOKE)
>>>
>>> if you are going to exclude 40x for now?  Otherwise this is still
>>> enabled on 405 and setting the wrong register.
>>>
>>> josh
>>
>> Yes, sorry. I wasn't aware of this specific define value. It makes
>> things easier to support 405's later.
>>
>> Like so?
>
> Please, next time, when you re-send a patch like that, re-include
> the full subject and patch description. You can add then blurbs after
> the --- line if you want to add things that won't make it to git.
>
> I'll deal with that specific one for now.

Ben,  I want to make sure this works on FSL Book-E before it gets into  
tree and I need to think about what SMP issues it might have.

I talked to Josh about this at OLS and if you are ok I can deal with  
acceptance of this patch via my tree.

- k
