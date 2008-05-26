Return-Path: <cbouatmailru@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id 01E67DDF49
	for <linuxppc-dev@ozlabs.org>; Tue, 27 May 2008 09:16:08 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id j3so545042ugf.0
	for <linuxppc-dev@ozlabs.org>; Mon, 26 May 2008 16:16:06 -0700 (PDT)
Date: Tue, 27 May 2008 03:15:56 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC PATCH 2/2] mmc: add OpenFirmware bindings for the mmc_spi
	driver
Message-ID: <20080526231556.GA7777@zarina>
References: <20080523182754.GA26891@polina.dev.rtsoft.ru>
	<fa686aa40805232219x7e888d80y394958f1c0a0fad0@mail.gmail.com>
	<20080526114914.GA26288@polina.dev.rtsoft.ru>
	<200805261519.01735.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <200805261519.01735.david-b@pacbell.net>
Cc: Gary Jennejohn <garyj@denx.de>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	Pierre Ossman <drzeus-mmc@drzeus.cx>
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 26, 2008 at 03:19:01PM -0700, David Brownell wrote:
> On Monday 26 May 2008, Anton Vorontsov wrote:
> > David, would you [not] suggest us to use platform_data with
> > container_of, that is, are there any plans to make SPI core copy
> > the platform_data instead of passing a pointer directly?
> 
> No such plans.

Ok, great.

> How could it copy, not knowing the size?

Platform bus usually knows the size via platform_device_add_data()...
anyway, we're in safe if there are no plans for this in SPI.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
