Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D270D67A81
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jan 2005 09:57:31 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <jemzv584yw.fsf@sykes.suse.de>
References: <1106011958.4533.25.camel@gaston> <je7jmaurl0.fsf@sykes.suse.de>
	<1106100264.4534.135.camel@gaston>  <jemzv584yw.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Thu, 20 Jan 2005 09:57:07 +1100
Message-Id: <1106175427.5326.21.camel@gaston>
Mime-Version: 1.0
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

On Wed, 2005-01-19 at 22:49 +0100, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> >> With all your patches applied I'm getting an oops during wakeup inside
> >> pci_bus_read_config_word on my iBook/G3.  Call trace: pci_set_master,
> >> pci_device_resume, resume_device, dpm_resume, device_resume,
> >> pmac_wakeup_devices, pmu_ioctl, sys_ioctl.
> >
> > It would be useful to get some more infos, what is the actual oops text
> > (what error), and if you could add some printk's to figure out what is
> > the culprit PCI device, that would be useful as well...
> 
> I was unable to reproduce the exact oops I got yesterday.  Now I'm getting
> a heap of oopses scrolling by, ending with a panic due to killing
> interrupt handler, without any way to capture them.

Even when building xmon into the kernel ?

Ben.
