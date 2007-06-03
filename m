Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id D60DCDDFFC
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 05:14:55 +1000 (EST)
Message-ID: <46631389.2060901@ru.mvista.com>
Date: Sun, 03 Jun 2007 23:16:25 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
References: <7fc919fce0761f861be3069a853d3169@bga.com>
	<1180769992.14025.1.camel@localhost.localdomain>
	<4662E7EA.70506@ru.mvista.com>
	<d067769912d2ed5c9e1b4770b77303dd@kernel.crashing.org>
	<46630256.8050909@ru.mvista.com>
	<daa1b6f2e18f06f053d538d28d3c046a@kernel.crashing.org>
	<46630A32.7000403@ru.mvista.com>
	<e85b2d39481e426dcd4c19a3eaaf8238@kernel.crashing.org>
In-Reply-To: <e85b2d39481e426dcd4c19a3eaaf8238@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: ppcdev <linuxppc-dev@ozlabs.org>, linux-mtd@lists.infradead.org,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:

>>>> Nobody's talking about the direct match but making the task of 
>>>> selecting a proper driver more complex by specifying the details 
>>>> that don't help (if not hinder) the correct selection is certainly 
>>>> not a way to go.

>>> Nonsense.  If the kernel doesn't care about certain details,
>>> it can just ignore them.

>>    That's OK, as long as it has the details it needs. Your suggestions 
>> on the "compatible" devoided it of such.

> Sigh.

    There had been no suggestions about other props or using "ranges" at that 
point. That wouldn't have covered all issues anyway.

> [snip]

>>>>    That's the way the cookie crumbles in Linux MTD for now. It's 
>>>> *always* detecting this by probing -- you only can say what [not] to 
>>>> probe.

>>> So go fix that :-)

>>    Wanna pay me for that? ;-)

> You're the one complaining, you go pay yourself.

    I'm lost here. Complaining about what?

> [snip, plunk]

> Segher

WBR, Sergei
