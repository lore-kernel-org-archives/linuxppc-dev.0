Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CBA01DDE28
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 May 2008 04:11:21 +1000 (EST)
Message-ID: <48209F79.70506@freescale.com>
Date: Tue, 06 May 2008 13:12:09 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Mike Timmons <mike_timmons@trimble.com>
Subject: Re: porting pci driverfrom arch=ppc on kernel 2.6.16 to arch=powerpc
	on	2.6.24...
References: <161B3BAD77161449A144FF054231C3D6020D6A5D@uss-am-xch-01.am.trimblecorp.net>
In-Reply-To: <161B3BAD77161449A144FF054231C3D6020D6A5D@uss-am-xch-01.am.trimblecorp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
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
> pci_read_config_byte(pci_dev, PCI_INTERRUPT_LINE, &irqnum).

Don't do this; use pci_dev->irq instead.

If that value doesn't work, check your interrupt-map in the pci node of 
the device tree.

-Scott
