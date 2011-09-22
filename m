Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 8803CB6F85
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Sep 2011 09:03:43 +1000 (EST)
Date: Fri, 23 Sep 2011 01:03:24 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V2 1/2] gpio: move mpc8xxx/512x gpio driver to drivers/gpio
Message-ID: <20110923010324.74819a2b@wker>
In-Reply-To: <1316602161-12546-1-git-send-email-w.sang@pengutronix.de>
References: <1316602161-12546-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 21 Sep 2011 12:49:20 +0200
Wolfram Sang <w.sang@pengutronix.de> wrote:

> Move the driver to the place where it is expected to be nowadays. Also
> rename its CONFIG-name to match the rest and adapt the defconfigs.
> Finally, move selection of REQUIRE_GPIOLIB or WANTS_OPTIONAL_GPIOLIB to
> the platforms, because this option is per-platform and not per-driver.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Anatolij Gustschin <agust@denx.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> I'd think this should go via ppc, so it is in sync with the defconfig update of
> patch 2/2.

applied both patches to next, thanks.

Anatolij
