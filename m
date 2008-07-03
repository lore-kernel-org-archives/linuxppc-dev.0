Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 15D32DDE45
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 09:14:59 +1000 (EST)
Message-Id: <2263A33B-E160-4E51-BD42-13ED72D067E8@freescale.com>
From: Andy Fleming <afleming@freescale.com>
To: Nate Case <ncase@xes-inc.com>
In-Reply-To: <1215098611.7559.551.camel@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: gianfar in SGMII mode
Date: Thu, 3 Jul 2008 18:14:41 -0500
References: <1215039186.7559.548.camel@localhost.localdomain>
	<1215098611.7559.551.camel@localhost.localdomain>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 3, 2008, at 10:23, Nate Case wrote:

> On Wed, 2008-07-02 at 17:53 -0500, Nate Case wrote:
>> I'm looking at gfar_configure_serdes() and I'm at a loss as to why
>> this
>> is always called when the MAC is in SGMII mode.  It looks like it
>> assumes the use of TBI for some reason.  On my board it's just a
>> regular
>> SGMII interface to a bcm5482 PHY in SGMII mode, so there is no TBI
>> involved.
>>
>> I'm guessing this is a case of the driver making incorrect  
>> assumptions
>> based on the existing Freescale boards.  Or am I missing something
>> here?
>
> Answering my own question: I see now that TBI is used internally on  
> the
> chip for the SerDes interface which implements SGMII..  so maybe  
> there's
> no problem with what the driver is doing after all.


Yeah, it's screwy, but that's how the chip works.

Andy
