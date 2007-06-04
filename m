Return-Path: <rvinson@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id ABC9DDDF69
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 08:50:54 +1000 (EST)
Message-ID: <466492DC.6050708@mvista.com>
Date: Mon, 04 Jun 2007 15:31:56 -0700
From: Randy Vinson <rvinson@mvista.com>
MIME-Version: 1.0
To: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
References: <1180720112.14219.62.camel@ld0161-tx32>	<dfc15991e31bfc09389461dc443acd7c@kernel.crashing.org>	<1180734314.5674.49.camel@rhino>	<4fb92a9dfccf515bdc1522d08f10f823@kernel.crashing.org>	<20070602085359.GA10333@iram.es>	<3ebd6ca6877ea74925f066ff96ac81db@kernel.crashing.org>	<20070602195308.GA21618@iram.es>	<12ad593bd17f769e44f05bc24eac4d0a@kernel.crashing.org>	<1180828907.14025.37.camel@localhost.localdomain>	<28e0600256815f93db45b2f4eb2d9df5@kernel.crashing.org>	<20070603083339.GB2157@iram.es>
	<02DC2E36-86B1-4458-BB0C-13CF79AC1D11@freescale.com>
In-Reply-To: <02DC2E36-86B1-4458-BB0C-13CF79AC1D11@freescale.com>
Content-Type: text/plain; charset=us-ascii
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andy Fleming wrote:
> On Jun 3, 2007, at 03:33, Gabriel Paubert wrote:
> 
[snippage]
>>
>> This said, I'm looking at device trees right now, and I can understand
>> that interrupt-parent of the 8259 is &mpic in mpc8641_hpcn.dts, but
>> I don't understand at all why it is &pci1 on the mpc85??cds.dts.
>>
>> But the definition of the ISA bridge in these files is very strange to
>> start with: I've never seen an ISA bridge with only an interrupt  
>> controller
>> on it, no interrupts are connected to it and its reg property is
>> almost certainly wrong. Maybe it is an example of things that should
>> not be done.
> 
> 
> I take full responsibility for that.  The CDS is a strange beast, so  
> I did some strange things in the DTS.
> 
> The i8259 is on a subsidiary bus, and so it's one bus #1.
Actually, that's not strictly true. If a card containing a P2P bridge is
installed into PCI slot 4, the i8259 will end up on a bus that is not
numbered bus 1. I've often wondered how something like that is handled
in the DTS.

Randy V.
