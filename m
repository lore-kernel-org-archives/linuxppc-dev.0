Return-Path: <monstr@seznam.cz>
Received: from smtp.seznam.cz (smtp.seznam.cz [77.75.72.43])
	by ozlabs.org (Postfix) with ESMTP id 80F62DDE1E
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Dec 2008 03:25:45 +1100 (EST)
Message-ID: <493D2B22.4000601@seznam.cz>
Date: Mon, 08 Dec 2008 15:11:46 +0100
From: Michal Simek <monstr@seznam.cz>
MIME-Version: 1.0
To: dhlii@dlasys.net
Subject: Re: Is anyone using the C67x00 USB Host ?
References: <49394978.10905@dlasys.net>
In-Reply-To: <49394978.10905@dlasys.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Reply-To: monstr@seznam.cz
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi David,

currently I am working on backport this driver to 2.6.20 to Microblaze but
a lot of things are the same.

>From HW site. Interrupt goes outside of IP directly to interrupt controller.
And you need to call platform_device_register with proper structure.

Could you send your kernel log?

Thanks,
Michal




> 	I am having two problems with it.
> 
> 	I can not get it working with interrupts,
> 
> 	I can not get the 2nd USB port working.
> 
> 	If someone has it working I would appreciate knowing.
> 
> Thanks
> 
> 	
> 
> 
> 
> 
> 
> 
> 
> 
> 
