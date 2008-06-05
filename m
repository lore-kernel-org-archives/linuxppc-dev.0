Return-Path: <sean.maclennan@pikatech.com>
Received: from mail.pikatech.com (dns.pikatech.com [207.107.229.10])
	by ozlabs.org (Postfix) with ESMTP id C1A3EDE4E6
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 07:37:49 +1000 (EST)
Date: Thu, 5 Jun 2008 17:37:16 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Stefan Roese" <sr@denx.de>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
Message-ID: <20080605173716.3fd28837@wally.pikatech.com>
In-Reply-To: <200806050822.00797.sr@denx.de>
References: <200806041706.21557.sr@denx.de>
	<20080604220555.658ab13e@vader.jdub.homelinux.org>
	<20080604231641.786bb2dd@lappy.seanm.ca>
	<200806050822.00797.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Jean Delvare <khali@linux-fr.org>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 5 Jun 2008 08:22:00 +0200
"Stefan Roese" <sr@denx.de> wrote:

> So what should we do now? Currently I2C doesn't work at all on 4xx
> since the driver expects the "index" property and no dts sets this
> property. Personally I would like to move to using cell-index here,
> since this seems to be more common. But I could also life with
> removing the index property and using the "static index" if this is
> preferred and/or acceptable.

The warp DTS does ;)

Cheers,
   Sean
