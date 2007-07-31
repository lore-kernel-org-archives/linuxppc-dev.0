Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 19850DDE19
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2007 09:43:16 +1000 (EST)
In-Reply-To: <1185923183.5380.0.camel@concordia.ozlabs.ibm.com>
References: <11851892302391-git-send-email-g.chen@freescale.com>
	<11851892311178-git-send-email-g.chen@freescale.com>
	<1185228277.5439.141.camel@localhost.localdomain>
	<1185232974.13740.11.camel@concordia.ozlabs.ibm.com>
	<f55fea27ac3a248cc99d52462d413e1e@kernel.crashing.org>
	<1185918267.5495.505.camel@localhost.localdomain>
	<91856a9e02132d2deb4368eee954c931@kernel.crashing.org>
	<1185923183.5380.0.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c18c835d8538e7412d36d9ddf5b62eb6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/3] Add a new member name to structure irq_host
Date: Wed, 1 Aug 2007 01:42:58 +0200
To: michael@ellerman.id.au
Cc: linuxppc-dev@ozlabs.org, Chen Gong <g.chen@freescale.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> In that case, I would display the node full path.
>>
>> Those tend to be quite long, in the cases where there are
>> multiple interrupt controllers in the system; and really
>> useless otherwise.  I think the interrupt controllers should
>> still just fill in the names "manually".
>
> They tend to be long, but they're unique, which is what you want,

Yeah -- easy enough to add a sequence number to just about
anything though.

> and they're only for debugging anyway.

Oh, I thought it would be used wherever the user gets told something
about the interrupt controller -- like when the interrupt tree would
be shown in sysfs (yes that's hypothetical still ;-) )

>> It's a good thing to have an of_node in the irq_host struct
>> anyway, though :-)
>
> I posted patches for that last week.

I know, and thank you :-)


Segher
