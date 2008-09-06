Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2E6F8DDDDE
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Sep 2008 19:05:44 +1000 (EST)
Date: Sat, 6 Sep 2008 13:02:54 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][USB] powerpc: Workaround for the PPC440EPX USBH_23 errata
Message-ID: <20080906130254.43848a08@vitb-lp>
In-Reply-To: <Pine.LNX.4.44L0.0809051111220.2493-100000@iolanthe.rowland.org>
References: <20080905170135.07ccbc46@vitb-lp>
	<Pine.LNX.4.44L0.0809051111220.2493-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Cc: USB list <linux-usb@vger.kernel.org>, Mark,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Miesfeld <mmiesfeld@amcc.com>, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

В Fri, 5 Sep 2008 11:17:03 -0400 (EDT)
Alan Stern <stern@rowland.harvard.edu> пишет:

> On Fri, 5 Sep 2008, Vitaly Bordug wrote:
> 
> > > > Not every hub will work (none of available did so far), and it
> > > > is often not an option for embedded device without rewiring.
> > > 
> > > It's odd that your hubs don't work.  What's wrong with them?
> > > 
> > 
> > well, they do not have transaction translators then. Nothing really
> > wrong
> 
> No.  If the hubs run at high speed then they must have transaction 
> translators; it's required by the USB 2.0 specification.
> 
> Did you try using them with ohci-hcd not loaded?

yes, not with every unit though. That seems to be usb hub issue then.


Anyway, the patch is targeted more to
the embedded platforms, that cannot afford work the issue around with
extra devices.

> 
> Alan Stern
