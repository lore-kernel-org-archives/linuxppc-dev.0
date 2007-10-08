Return-Path: <david-b@pacbell.net>
Received: from smtp120.sbc.mail.re3.yahoo.com (smtp120.sbc.mail.re3.yahoo.com
	[66.196.96.93]) by ozlabs.org (Postfix) with SMTP id F3B93DE01B
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 05:45:07 +1000 (EST)
Date: Mon, 08 Oct 2007 12:45:11 -0700
From: David Brownell <david-b@pacbell.net>
To: vbarshak@ru.mvista.com, galak@kernel.crashing.org
Subject: Re: [linux-usb-devel] [PATCH] OHCI: add PowerPC 440EP/440EPx support
References: <20071008142554.GA15175@ru.mvista.com>
	<20071008150125.26C802393C7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<470A55A2.5050606@ru.mvista.com>
	<20071008161927.84C601915AE@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<7363E251-62FF-4574-9FF7-8E5719012BAD@kernel.crashing.org>
	<470A6C07.3020805@ru.mvista.com>
In-Reply-To: <470A6C07.3020805@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20071008194511.C14EB19715E@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> >> However, based on one other post, I suspect at least one Freescale
> >> part will need to declare a chip quirk for this case.
> > 
> > Which Freescale part do you think needs this?
>
> I've looked at drivers/usb/host/Kconfig
> It seems to be MPC52xx.
> David, is that the one you mentioned?

I wasn't the one to mention it.  It was someone else in this thread.
