Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 46391DDE19
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jun 2007 05:16:47 +1000 (EST)
In-Reply-To: <466492DC.6050708@mvista.com>
References: <1180720112.14219.62.camel@ld0161-tx32>	<dfc15991e31bfc09389461dc443acd7c@kernel.crashing.org>	<1180734314.5674.49.camel@rhino>	<4fb92a9dfccf515bdc1522d08f10f823@kernel.crashing.org>	<20070602085359.GA10333@iram.es>	<3ebd6ca6877ea74925f066ff96ac81db@kernel.crashing.org>	<20070602195308.GA21618@iram.es>	<12ad593bd17f769e44f05bc24eac4d0a@kernel.crashing.org>	<1180828907.14025.37.camel@localhost.localdomain>	<28e0600256815f93db45b2f4eb2d9df5@kernel.crashing.org>	<20070603083339.GB2157@iram.es>
	<02DC2E36-86B1-4458-BB0C-13CF79AC1D11@freescale.com>
	<466492DC.6050708@mvista.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BCDEB9B2-06FF-40DD-B579-A3D5BDBDCF60@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
Date: Tue, 5 Jun 2007 14:16:19 -0500
To: Randy Vinson <rvinson@mvista.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>
>> I take full responsibility for that.  The CDS is a strange beast, so
>> I did some strange things in the DTS.
>>
>> The i8259 is on a subsidiary bus, and so it's one bus #1.
> Actually, that's not strictly true. If a card containing a P2P  
> bridge is
> installed into PCI slot 4, the i8259 will end up on a bus that is not
> numbered bus 1. I've often wondered how something like that is handled
> in the DTS.

*Waves hands distractingly*

Pay no attention to the man behind the dts!

Seriously, though, it's quite fragile right now.  We probably need to  
change u-boot to correctly number those things.  And we should  
probably change the dts files for each board to have any soldered-on  
pci devices.

Right now, though, we'd settle for being able to *use* those devices  
under a default setting.

Andy
