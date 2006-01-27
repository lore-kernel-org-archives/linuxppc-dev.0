Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 482096891D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Jan 2006 11:12:27 +1100 (EST)
Message-ID: <43D964E2.4070007@ovro.caltech.edu>
Date: Thu, 26 Jan 2006 16:10:10 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: Yosemite/440EP why are readl()/ioread32() setup to read
	little-endian?
References: <43CC3E37.4040707@softadvances.com>
	<20060125185131.GA7425@gate.ebshome.net>
	<43D7D334.3070709@ovro.caltech.edu> <200601261120.48251.sr@denx.de>
In-Reply-To: <200601261120.48251.sr@denx.de>
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


>>I haven't looked for it yet, but do you know if there is a driver
>>for the Yosemite board I2C temperature sensor already written?
> 
> The Analog Devices AD7414 is used on Yosemite/Yellowstone and it doesn't seem 
> to be supported from the lm-sensors project right now. Shouldn't be that 
> difficult to write a driver for it though.

Thanks Stefan, I'll take a shot at it then.

Dave
