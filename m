Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0D360DE36D
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 May 2008 05:41:08 +1000 (EST)
Message-ID: <4820B485.1020506@freescale.com>
Date: Tue, 06 May 2008 14:41:57 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Mike Timmons <mike_timmons@trimble.com>
Subject: Re: porting pci driverfrom arch=ppc on kernel 2.6.16 to arch=powerpc
	on	2.6.24...
References: <161B3BAD77161449A144FF054231C3D6020D6A5D@uss-am-xch-01.am.trimblecorp.net>
	<48209F79.70506@freescale.com>
	<161B3BAD77161449A144FF054231C3D6020D6B08@uss-am-xch-01.am.trimblecorp.net>
In-Reply-To: <161B3BAD77161449A144FF054231C3D6020D6B08@uss-am-xch-01.am.trimblecorp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Mark Gibson <Mark_Gibson@trimble.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Mike Timmons wrote:
> If I'm not supposed to read the interrupt using config_read, should I
> also not be writing to the host register on the coral P to clear the
> interrupt?
> 
> Should I instead be using some PCI helper functions? 

No, clearing interrupts is device-specific.

Have you verified that the device does not think it's generating an 
interrupt during the interrupt storm?  Do other PCI cards work?

-Scott
