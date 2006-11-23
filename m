Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A051367BAC
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Nov 2006 01:28:11 +1100 (EST)
In-Reply-To: <1164224548.2769.4.camel@localhost>
References: <1164141715.9752.5.camel@localhost>
	<1164214098.5704.1.camel@localhost> <20061122130507.477dfe2c@pb15>
	<1164224548.2769.4.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b7365926065b2cd18fd8e15589f417c6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Make 970MP detectable by oprofile
Date: Thu, 23 Nov 2006 15:28:07 +0100
To: Mike Wolf <mjw@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>> Just out of curiosity, what are those?  I never saw any,
>>>> but I'd love to know :-)
>>>
>>> They are the IBM JS21 blades
>>
>> I think Segher might have had "what are the new counters" in mind 
>> when he asked that, not where the processors are used. :-)

Yes indeed :-)

> They are different MMCRx settings for counting certain events.

Heh of course.  I meant _which_ events, of course.

But nm, I'll look it up myself :-)


Segher
