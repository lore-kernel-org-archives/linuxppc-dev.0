Return-Path: <david-b@pacbell.net>
Received: from smtp119.sbc.mail.sp1.yahoo.com (smtp119.sbc.mail.sp1.yahoo.com
	[69.147.64.92]) by ozlabs.org (Postfix) with SMTP id A38E6DDF7F
	for <linuxppc-dev@ozlabs.org>; Tue, 27 May 2008 08:26:58 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: avorontsov@ru.mvista.com
Subject: Re: [RFC PATCH 2/2] mmc: add OpenFirmware bindings for the mmc_spi
	driver
Date: Mon, 26 May 2008 15:19:01 -0700
References: <20080523182754.GA26891@polina.dev.rtsoft.ru>
	<fa686aa40805232219x7e888d80y394958f1c0a0fad0@mail.gmail.com>
	<20080526114914.GA26288@polina.dev.rtsoft.ru>
In-Reply-To: <20080526114914.GA26288@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200805261519.01735.david-b@pacbell.net>
Cc: Gary Jennejohn <garyj@denx.de>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 26 May 2008, Anton Vorontsov wrote:
> David, would you [not] suggest us to use platform_data with
> container_of, that is, are there any plans to make SPI core copy
> the platform_data instead of passing a pointer directly?

No such plans.  How could it copy, not knowing the size?
