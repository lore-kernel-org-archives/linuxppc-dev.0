Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A90C367A70
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jan 2005 09:45:55 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1106142344.26551.517.camel@hades.cambridge.redhat.com>
References: <1106011958.4533.25.camel@gaston>
	<1106142344.26551.517.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Date: Thu, 20 Jan 2005 09:44:18 +1100
Message-Id: <1106174658.5326.7.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] ppc32: pmac sleep support update
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2005-01-19 at 13:45 +0000, David Woodhouse wrote:
> On Tue, 2005-01-18 at 12:32 +1100, Benjamin Herrenschmidt wrote:
> > This patch updates the PowerMac sleep support. The ability to sleep is now broken
> > into 2 different flags, one, "may sleep" is set for all motherboards that we know
> > how to put to sleep and wakeup. It gets turned into "can sleep" upon a call from
> > the video driver indicating the ability to wakeup the video card. 
> 
> Why do it like this? Drivers already have the ability to veto sleep
> requests, surely?

But they don't, besides, you may just not have a driver for the card
(that is things like offb don't register as a pci_driver, etc...)

It's a mecanism that can/will be improved in the future, but for now,
it suits my needs perfectly.

Ben.
