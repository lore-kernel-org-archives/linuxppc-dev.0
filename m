Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9ABD2DDD0C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Feb 2008 02:27:10 +1100 (EST)
Message-ID: <47BD9815.9020002@freescale.com>
Date: Thu, 21 Feb 2008 09:26:13 -0600
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: MPC8641D PCI-Express error
References: <47BC51B5.50204@coritel.it>	<BA5ADBDE-BDE5-4126-B012-DA6C5A8F8EF3@kernel.crashing.org>	<47BD3001.2020004@coritel.it>
	<47BD96F8.4090406@freescale.com>
In-Reply-To: <47BD96F8.4090406@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Marco Stornelli <marco.stornelli@coritel.it>,
	LinuxPPC-Embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> Marco Stornelli wrote:
> 
>> No, it didn't. I have the same problem even with the 2.6.18 plus the
>> 2.6.24 PCI-Express code. I performed this action because I can't change
>> kernel version but I can modify it.
> 
> Please try 2.6.24 (or even better, 2.6.25-rc2).  You may have done something 
> wrong in back-porting the code to 2.6.18.  There's no reason why you can't at 
> least try the latest version of the code for testing purposes, even if you can't 
> use it in production.
> 

Also, once you back-ported it and all the DTS changes, and all
the fsl_soc.c changes needed and , and, and otherwise made it
look _like_, 2.6.24 but still called it 2.6.18, after all that,
can you remind us what was the error or failure mode that you saw?

jdl
