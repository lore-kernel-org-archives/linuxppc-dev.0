Return-Path: <david-b@pacbell.net>
Received: from smtp124.sbc.mail.sp1.yahoo.com (smtp124.sbc.mail.sp1.yahoo.com
	[69.147.64.97]) by ozlabs.org (Postfix) with SMTP id 8397FDE031
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 06:47:59 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] usb: add Freescale QE/CPM USB peripheral controller driver
Date: Wed, 24 Sep 2008 13:15:26 -0700
References: <Pine.LNX.4.44L0.0808281613540.3844-100000@iolanthe.rowland.org>
	<200808290027.59127.arnd@arndb.de>
In-Reply-To: <200808290027.59127.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200809241315.26794.david-b@pacbell.net>
Cc: greg@kroah.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Alan Stern <stern@rowland.harvard.edu>,
	Scott Wood <scottwood@freescale.com>, Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 28 August 2008, Arnd Bergmann wrote:
> If the gadget hardware drivers were registering the device with a
> gadget_bus_type, you could still enforce the "only one protocol"
> rule by binding every protocol to every device in that bus type.

And you'd have to rewrite all the gadget drivers ("protocol")
to work with multiple upstream ports.

That gets messy with e.g. the Ethernet links ... each would
need to be configured with unique ethernet address pairs.
Likewise with serial numbers.

I've learned to just accept complaints in this area as sort
of a price for existing.  It's all complaints, no patches.
So obviously the complaints don't have any requirements
backing them.  ;)
