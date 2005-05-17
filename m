Return-Path: <jmasel@arabellasw.com>
Received: from gold.webfusion.co.uk (gold.webfusion.co.uk [212.67.202.159])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F09E1679E2
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 May 2005 17:28:35 +1000 (EST)
From: "Jonathan Masel" <jmasel@arabellasw.com>
To: "'Kylo Ginsberg'" <kylo.ginsberg@gmail.com>
Date: Tue, 17 May 2005 10:28:00 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <0d07fbd5d90d129227b4f579067f2d16@embeddededge.com>
Message-Id: <E1DXwV3-0001Yd-00@gold.webfusion.co.uk>
Cc: 'PPC_LINUX' <linuxppc-embedded@ozlabs.org>
Subject: RE: MPC885 - USB HCI drivers.
Reply-To: jmasel@arabellasw.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

CPM USB controllers have their quirks and erratas, but they do work. Most
erratas are documented but I'm not sure all are - we identified a couple and
reported them back to Freescale, but I don't know if they've updated their
web site in this regard.

I'm not sure what "software hacks" means but they don't require CPM
downloads or hardware modifications to work. It is also not true that they
can only support one device at a time (though yes, you do need an external
hub).

Bottom line: it's not easy getting them to work, but I can assure you that
there are software packages that do so (we have one). They're not free - but
neither are the USB controllers. Your choice!

Jonathan Masel


On May 16, 2005, at 6:39 PM, Kylo Ginsberg wrote:

> Are there known problems with CPM-based USB controllers?

The original CPM USB controller was only supposed to be
a device side controller.  With some software hacks, CPM
microcode downloads, and even some hardware modifications,
you can often get it to work as a host in some static situations.
It doesn't have a built in root hub, you usually concentrate
on making it work with one specific device for a particular
product.  You may find some application notes on the
Freescale web site, but I haven't seem them lately.

Take Wolfgang's advice, it's easier to find a way to
attach a real USB controller than to make this one
work as you probably expect.

Thanks.

	-- Dan
