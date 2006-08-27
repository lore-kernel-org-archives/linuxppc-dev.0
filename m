Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 64BF067B7C
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2006 08:34:42 +1000 (EST)
Subject: Re: [PATCH] Keyboard backlight driver for Oct 2005 PowerBooks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
In-Reply-To: <20060827123015.GA4697@hansmi.ch>
References: <20060827123015.GA4697@hansmi.ch>
Content-Type: text/plain; charset=utf-8
Date: Mon, 28 Aug 2006 08:34:23 +1000
Message-Id: <1156718063.8433.358.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, johannes@sipsolutions.net, rpurdie@rpsys.net,
	linux-kernel@killerfox.forkbomb.ch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2006-08-27 at 14:30 +0200, Michael Hanselmann wrote:
> This driver provides an interface to the keyboard backlight on Oct 2005
> PowerBooks, which have the backlight behind the PMU. This driver doesn't
> support the I²C variant used in earlier PowerBooks.
> 
> Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>

Why would we need a driver ? Userland can emit PMU commands directly...
At least, if we do a driver, it should provide a common interface to
both PMU and i2c based LMUs

Ben.
