Return-Path: <CFRIESEN@nortel.com>
Received: from zrtps0kp.nortel.com (zrtps0kp.nortel.com [47.140.192.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id C43CDDDDF9
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 14:47:06 +1100 (EST)
Message-ID: <49068B28.6080302@nortel.com>
Date: Mon, 27 Oct 2008 21:46:48 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] genirq: Set initial default irq affinity to just CPU0
References: <4905FC15.3020702@nortel.com>
	<20081027.112823.178324048.davem@davemloft.net>
	<4906123F.7020802@nortel.com>
	<20081027.122524.147654861.davem@davemloft.net>
In-Reply-To: <20081027.122524.147654861.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, kevdig@hypersurf.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Miller wrote:
> From: "Chris Friesen" <cfriesen@nortel.com>

>>Are there any plans for a mechanism to allow the kernel to figure
>>out (or be told) what packets cpu-affined tasks are interested in
>>and route the interrupts appropriately?
> 
> No, not at all.

> Now there are plans to allow the user to add classification rules into
> the chip for specific flows, on hardware that supports this, via ethtool.

Okay, that sounds reasonable.  Good to know where you're planning on going.

> Your driver is weak and doesn't support the hardware correctly, and you
> want to put the onus on everyone else with sane hardware and drivers?

I'm not expecting any action...I was just objecting somewhat to 
"Networking interrupts should lock onto a single CPU, unconditionally." 
  Add "for a particular flow" into that and I wouldn't have said anything.

>>It's not an ideal situation, but we're sort of stuck unless we do
>>custom driver work.

> Wouldn't want you to get your hands dirty or anything like that now,
> would we?  :-)))

I'd love to.  But other things take time too, so we live with it for now.

Chris
