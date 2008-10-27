Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 933C2DDE1D
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 07:47:02 +1100 (EST)
Message-Id: <6F732DEE-4F04-4A9C-A607-56F47B1F96C0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20081027.124922.116478297.davem@davemloft.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] genirq: Set initial default irq affinity to just CPU0
Date: Mon, 27 Oct 2008 15:46:49 -0500
References: <4905FC15.3020702@nortel.com>
	<20081027.112823.178324048.davem@davemloft.net>
	<B6F01D86-7B36-40E8-9440-CA371B08B1C8@kernel.crashing.org>
	<20081027.124922.116478297.davem@davemloft.net>
Cc: kevdig@hypersurf.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 27, 2008, at 2:49 PM, David Miller wrote:

> From: Kumar Gala <galak@kernel.crashing.org>
> Date: Mon, 27 Oct 2008 14:43:29 -0500
>
>> I haven't been following the netdev patches, but what about HW that  
>> does flow separation w/o multiple interrupts?
>>
>> We (Freescale) are working on such a device:
>>
>> http://www.freescale.com/webapp/sps/site/prod_summary.jsp?fastpreview=1&code=P4080
>
> It could probably tie into the software based flow seperation support.

Will have to look at the code.. we might be able to fit in the HW irq  
scheme.  We effective have a way of getting a per cpu interrupt for  
the flow.

- k
