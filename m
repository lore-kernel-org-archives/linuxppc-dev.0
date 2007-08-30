Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DAF21DDE0F
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 00:54:01 +1000 (EST)
In-Reply-To: <20070830055644.GA21604@ld0162-tx32.am.freescale.net>
References: <20070828201929.GH24329@ld0162-tx32.am.freescale.net>
	<66A3DBEB-412D-4229-88DA-B47F3256CEF6@kernel.crashing.org>
	<20070830055644.GA21604@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <573185B5-2B02-4D97-BAC8-D508C16D6093@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 8/9] mpc82xx: Update mpc8272ads,
	and factor out PCI and reset.
Date: Thu, 30 Aug 2007 09:56:16 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 30, 2007, at 12:56 AM, Scott Wood wrote:

> On Wed, Aug 29, 2007 at 05:41:17PM -0500, Kumar Gala wrote:
>> NACK.
>>
>> I don't want pq2 to be the only platform that has the PCI bus
>> separate from the PCI controller.
>
> Could you articulate the reasons why you'd rather have a mishmash  
> of crap
> in the soc node's ranges property?

It don't feel its a mishmash of crap its just how things are  
defined.  Maybe the SOC node was a mistake, but I think we are past  
the point of return on that.

Having one platform's device tree be different just creates confusion  
to our customers.  While there isn't anything technically wrong with  
what your proposing it will cause support issues down the line which  
I want to avoid.

- k
