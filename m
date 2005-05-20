Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 67B1C679FE
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 May 2005 03:50:59 +1000 (EST)
In-Reply-To: <428E2049.4010907@ru.mvista.com>
References: <1114609634.30649.14.camel@ad.doubleclick.net>
	<428E2049.4010907@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4ab1a586a6835c2436e992f6e2bf7e5a@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Fri, 20 May 2005 13:51:06 -0400
To: Andrei Konovalov <akonovalov@ru.mvista.com>
Cc: PPC_LINUX <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC8xx Platformization
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 20, 2005, at 1:37 PM, Andrei Konovalov wrote:

> But it still doesn't distinguish between e.g. MPC885, MPC880, MPC875, 
> and MPC870
> - though the set of on-chip devices is different for the four.

I don't believe you can reliably distinguish among many of these parts.
I've had parts stamped with a number on them, but it looks like it had
remnants of other, probably non-working, peripherals from another.
Just poking at some peripheral locations to determine processor
type isn't likely to always be accurate.

I don't think we should be writing any code that relies on the proper
identification of the parts.  When building the code for a real product,
you always configure specifically for it to reduce code size and run 
time
start up.  As a development engineer, you should know the configuration
you are using as well.  The only difference is in the peripherals 
supported,
so just configure what you want to use.

Thanks.

	-- Dan
