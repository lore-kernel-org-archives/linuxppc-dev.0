Return-Path: <schwab@suse.de>
Received: from Cantor.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail.suse.de",
	Issuer "SuSE Linux AG internal IMAP-Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 883B767A78
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jan 2005 08:49:16 +1100 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1106011958.4533.25.camel@gaston> <je7jmaurl0.fsf@sykes.suse.de>
	<1106100264.4534.135.camel@gaston>
From: Andreas Schwab <schwab@suse.de>
Date: Wed, 19 Jan 2005 22:49:11 +0100
In-Reply-To: <1106100264.4534.135.camel@gaston> (Benjamin Herrenschmidt's
	message of "Wed, 19 Jan 2005 13:04:24 +1100")
Message-ID: <jemzv584yw.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] ppc32: pmac sleep support update
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

>> With all your patches applied I'm getting an oops during wakeup inside
>> pci_bus_read_config_word on my iBook/G3.  Call trace: pci_set_master,
>> pci_device_resume, resume_device, dpm_resume, device_resume,
>> pmac_wakeup_devices, pmu_ioctl, sys_ioctl.
>
> It would be useful to get some more infos, what is the actual oops text
> (what error), and if you could add some printk's to figure out what is
> the culprit PCI device, that would be useful as well...

I was unable to reproduce the exact oops I got yesterday.  Now I'm getting
a heap of oopses scrolling by, ending with a panic due to killing
interrupt handler, without any way to capture them.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
