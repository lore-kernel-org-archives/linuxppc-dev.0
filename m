Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 24FB9DDFC7
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 06:10:37 +1100 (EST)
Message-ID: <47B1EF39.5000703@freescale.com>
Date: Tue, 12 Feb 2008 13:10:49 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Could the DTS experts look at this?
References: <47ACE630.8090101@pikatech.com>	
	<20080211001451.GA11572@localhost.localdomain>	
	<47AFB593.30805@pikatech.com>	
	<20080211031110.GD11572@localhost.localdomain>	
	<47AFC5E3.20101@pikatech.com>	
	<20080211235958.GD18348@localhost.localdomain>	
	<47B0F142.40206@pikatech.com>	
	<20080212002030.GE18348@localhost.localdomain>	
	<47B0EB23.9040101@pikatech.com>	
	<20080212185251.GB4042@loki.buserror.net>
	<fa686aa40802121103s650fc10by197e9d5b65f09ceb@mail.gmail.com>
In-Reply-To: <fa686aa40802121103s650fc10by197e9d5b65f09ceb@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Feb 12, 2008 11:52 AM, Scott Wood <scottwood@freescale.com> wrote:
>> It'd be nice if we could pass in a flag to tell it not to try to find
>> additional consecutive chips in the mapping...  It's a shame to have
>> probable chips, and still have to know how big they are anyway.
> 
> That is the job of the boot loader or wrapper.

Hmm?  All I meant was that it'd be nice if there were an option in the 
Linux mtd code to disable the "look for another chip and cause a machine 
check if it isn't there" functionality.  It was an aside from the 
dts-variant issue.

> The whole concept of
> the device tree is that by the time it gets to the kernel it is an
> accurate representation of the hardware; not a list of things which
> might or might not be present.

But we don't generally include things which can be probed in a standard 
manner... which includes flash size.

-Scott
