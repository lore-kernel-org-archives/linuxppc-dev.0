Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3DF4368A3A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jan 2006 06:38:31 +1100 (EST)
Message-ID: <43D7D334.3070709@ovro.caltech.edu>
Date: Wed, 25 Jan 2006 11:36:20 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: Yosemite/440EP why are readl()/ioread32() setup to read
	little-endian?
References: <43CC3E37.4040707@softadvances.com>
	<43D66D06.9090904@ovro.caltech.edu> <200601251057.47619.sr@denx.de>
	<43D7C2EF.5060508@ovro.caltech.edu>
	<20060125185131.GA7425@gate.ebshome.net>
In-Reply-To: <20060125185131.GA7425@gate.ebshome.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Eugene,

> 
> use in_/out_ accessors, not pointers. Look at other 4xx drivers (i2c, 
> emac)
> 
> Also, you don't have worry about this code being non-portable, because 
> every chip has it's own GPIO impl anyway.
> 

Thanks for the feedback.

I haven't looked for it yet, but do you know if there is a driver
for the Yosemite board I2C temperature sensor already written?

If its not, that might be a nice little exercise for me.

Thanks,
Dave
