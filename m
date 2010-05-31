Return-Path: <khali@linux-fr.org>
Received: from poutre.nerim.net (poutre.nerim.net [62.4.16.124])
	by ozlabs.org (Postfix) with ESMTP id 56F41B7D16
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jun 2010 07:04:24 +1000 (EST)
Date: Mon, 31 May 2010 22:57:50 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] drivers: remove all i2c_set_clientdata(client, NULL)
Message-ID: <20100531225750.0dc18950@hyperion.delvare>
In-Reply-To: <20100531190911.GC30712@core.coreip.homeip.net>
References: <1275310552-14685-1-git-send-email-w.sang@pengutronix.de>
	<20100531190911.GC30712@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	linux-i2c@vger.kernel.org, devel@driverdev.osuosl.org,
	Samuel Ortiz <sameo@linux.intel.com>, lm-sensors@lm-sensors.org,
	linux-input@vger.kernel.org, linux-media@vger.kernel.org,
	Paul Gortmaker <p_gortmaker@yahoo.com>,
	Riku Voipio <riku.voipio@iki.fi>, rtc-linux@googlegroups.com,
	Alessandro Rubini <rubini@ipvvis.unipv.it>,
	Mauro Carvalho Chehab <mchehab@infradead.org>, "Ben Dooks \(embedded
	platforms\)" <ben-linux@fluff.org>, Liam Girdwood <lrg@slimlogic.co.uk>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Guillaume Ligneul <guillaume.ligneul@gmail.com>,
	George Joseph <george.joseph@fairview5.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Richard Purdie <rpurdie@rpsys.net>, Colin Leroy <colin@colino.net>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Dmitry,

On Mon, 31 May 2010 12:09:12 -0700, Dmitry Torokhov wrote:
> Frankly I'd prefer taking input stuff through my tree with the goal of
> .36 merge window just to minimize potential merge issues. This is a
> simple cleanup patch that has no dependencies, so there is little gain
> from doing it all in one go.

If I take the patch in my i2c tree, the aim is to merge it upstream
immediately, so merge issues won't exist.

-- 
Jean Delvare
