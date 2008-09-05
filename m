Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BD625DDEE3
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 11:35:41 +1000 (EST)
Subject: Re: [RFC][USB] powerpc: Workaround for the PPC440EPX USBH_23 errata
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Stern <stern@rowland.harvard.edu>
In-Reply-To: <Pine.LNX.4.44L0.0809041737160.23455-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0809041737160.23455-100000@iolanthe.rowland.org>
Content-Type: text/plain
Date: Fri, 05 Sep 2008 11:35:08 +1000
Message-Id: <1220578508.4879.94.camel@pasglop>
Mime-Version: 1.0
Cc: USB list <linux-usb@vger.kernel.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Mark Miesfeld <mmiesfeld@amcc.com>, Stefan Roese <sr@denx.de>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I assume that's the reason the suggested approach failed.

I think (hope) that Vitaly actually fixed that before trying it :-)

> I don't mind doing that, provided the changes are cleaned up so that 
> they don't affect people who aren't building kernels for 44x systems.

I also find the CONFIG_PM approach not terribly reliable... too timing
sensitive, and it forces boards to add CONFIG_PM which is not
necessarily the nicest thing to do in embedded space.

Sounds better to me to clean up the initial patch to ensure it's not
going to introduce bloat for other platforms and use that, ie just
consider it as yet another HW errata.

Cheers,
Ben.
