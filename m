Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 22C74DDFB2
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 11:46:35 +1100 (EST)
In-Reply-To: <1170116712.26655.293.camel@localhost.localdomain>
References: <OF7EF2F643.75F7008B-ON8625725D.00157658-8625725D.00167CB4@au1.ibm.com>
	<1168236558.22458.187.camel@localhost.localdomain>
	<8ee3d13b73a511a785ac4744c268943e@kernel.crashing.org>
	<1170116712.26655.293.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7BADAAC7-D139-4C1A-A799-93F46508880E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: EMAC OF binding....
Date: Mon, 29 Jan 2007 18:45:30 -0600
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: Christian Rund <Christian.Rund@de.ibm.com>,
	Hartmut Penner <HPENNER@de.ibm.com>, Murali N Iyer <mniyer@us.ibm.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 29, 2007, at 6:25 PM, Benjamin Herrenschmidt wrote:

> On Mon, 2007-01-08 at 07:38 +0100, Segher Boessenkool wrote:
>>>  - compatible        : compatible list, contains 2 entries, first is
>>> "emac-CHIP" where
>>>                        CHIP is the host ASIC (440gx, 405gp, axon)  
>>> and
>>> second is either
>>>                        "emac" or "emac4".
>>>                        For axon, thus, we have: "emac-axon","emac4"
>>
>> "ibm,emac-axon" etc. please.
>
> What would you do for things like 440gx ? ibm,440gx or amcc,440gx ?

Does emac really vary that much between the chips its in?  I know  
chatting with Ben that axon did some evil things, but how much  
difference exists on 4xx implementations?

- k
