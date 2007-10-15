Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 74077DDDF8
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 05:26:11 +1000 (EST)
Message-ID: <4713BCE8.4050307@freescale.com>
Date: Mon, 15 Oct 2007 14:18:00 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: [PATCH 2/2] i2c: Add devtree-aware iic support for PPC4xx
References: <200710151529.11485.sr@denx.de>
	<20071015163216.GA8127@gate.ebshome.net>
	<fa686aa40710150957s74693835g257b376adfdb4e90@mail.gmail.com>
	<20071015185340.GB4474@loki.buserror.net>
	<20071015191118.GA9733@gate.ebshome.net>
In-Reply-To: <20071015191118.GA9733@gate.ebshome.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Jean Delvare <khali@linux-fr.org>, Stefan Roese <sr@denx.de>,
	i2c@lm-sensors.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Eugene Surovegin wrote:
> On Mon, Oct 15, 2007 at 01:53:40PM -0500, Scott Wood wrote:
>> Though, I don't see what the problem with the original approach is,
>> as long as the numbers are chosen in the same way when registering
>> i2c clients based on the children of the adapter node.  There's no
>> concept in the hardware itself of a bus number.
> 
> Huh? As far as I can tell, there is.

Where?  Hardware != Documentation.

> Also, I want messages from the kernel mention something I can map to
> the real hw, e.g. fixed IIC device index, not some random number.

The OF node path should have a unit address that accomplishes that.

> I find it rather puzzling that instead people are trying to make this
> a non-issue as soon as it cannot be implemented easily with their new
> and shiny infrastructure.

"People" are not a monolithic entity.  I never advocated using bus numbers.

-Scott
