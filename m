Return-Path: <stern+48c922fa@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
	by ozlabs.org (Postfix) with SMTP id 8B92BDE11D
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Sep 2008 01:17:14 +1000 (EST)
Date: Fri, 5 Sep 2008 11:17:03 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [RFC][USB] powerpc: Workaround for the PPC440EPX USBH_23 errata
In-Reply-To: <20080905170135.07ccbc46@vitb-lp>
Message-ID: <Pine.LNX.4.44L0.0809051111220.2493-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: USB list <linux-usb@vger.kernel.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Mark Miesfeld <mmiesfeld@amcc.com>, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 5 Sep 2008, Vitaly Bordug wrote:

> > > Not every hub will work (none of available did so far), and it is
> > > often not an option for embedded device without rewiring.
> > 
> > It's odd that your hubs don't work.  What's wrong with them?
> > 
> 
> well, they do not have transaction translators then. Nothing really
> wrong

No.  If the hubs run at high speed then they must have transaction 
translators; it's required by the USB 2.0 specification.

Did you try using them with ohci-hcd not loaded?

Alan Stern
