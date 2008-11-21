Return-Path: <david-b@pacbell.net>
Received: from smtp125.sbc.mail.sp1.yahoo.com (smtp125.sbc.mail.sp1.yahoo.com
	[69.147.65.184]) by ozlabs.org (Postfix) with SMTP id 96564DDE3A
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 14:17:41 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: "Jason Hanna" <jason.m.hanna.at.coincident@gmail.com>
Subject: Re: [spi-devel-general] [PATCH v3] spi: Add PPC4xx SPI driver
Date: Thu, 20 Nov 2008 19:17:37 -0800
References: <1225000124-29366-1-git-send-email-sr@denx.de>
	<20081029145305.GA3676@yoda.jdub.homelinux.org>
	<8f9e78f00810301624k5925a52ah924960f869388233@mail.gmail.com>
In-Reply-To: <8f9e78f00810301624k5925a52ah924960f869388233@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200811201917.38148.david-b@pacbell.net>
Cc: spi-devel-general@lists.sourceforge.net, Stefan Roese <sr@denx.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 30 October 2008, Jason Hanna wrote:
> Also, any pointers to sample/test code incorporating a spi protocol
> driver would be incredibly helpful.

Look at Documentation/spi/*.c ... for user mode code
hooking up through "spidev".


> I'm very new to device driver 
> programming and don't really know what I'm doing yet. I seem to be
> getting the spi_ppc4xx and spi_bitbang modules loaded, but am unsure
> how to verify proper initialization and what next steps I need to
> follow in order to develop and associate a protocol driver.

Documentation/spi/spi-summary should help.
And sticking a 'scope on the outputs (as you
said you plan) is a decent place to start,
if you don't have something to talk to yet.

- dave
