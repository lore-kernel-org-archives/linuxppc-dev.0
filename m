Return-Path: <khali@linux-fr.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8D60DB6F56
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Sep 2009 20:56:09 +1000 (EST)
Received: from bamako.nerim.net (bamako.nerim.net [62.4.17.28])
	by ozlabs.org (Postfix) with ESMTP id 30F91DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 20:56:08 +1000 (EST)
Date: Thu, 10 Sep 2009 12:49:37 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: Removing deprecated drivers from drivers/i2c/chips
Message-ID: <20090910124937.7b3df062@hyperion.delvare>
In-Reply-To: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
References: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, uclinux-dist-devel@blackfin.uclinux.org,
	linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mips@linux-mips.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Wolfram,

On Wed,  9 Sep 2009 23:22:47 +0200, Wolfram Sang wrote:
> continuing the quest to clean up and ultimately remove the drivers/i2c/chips
> directory, this patch series removes three drivers for GPIO-expanders which are
> obsoleted and marked as deprecated for more than a year. The newer (and better)
> drivers can be found in drivers/gpio.
> 
> As it is ensured that the newer drivers cover the same i2c_device_ids, all
> platform_devices will still match. Some defconfig updates may be necessary
> though, but according to [1] this is left to the arch|platform-maintainers
> (also as most defconfigs are quite outdated). For that reason, I put the
> relevant arch-mailing-lists to Cc. Comments are welcome.

Looks very good, I'll apply the 3 patches removing the legacy drivers.

Not sure about the patch to drivers/gpio/pcf857x.c, as there is no gpio
tree and no maintainer either AFAIK, I guess I shall pick it too?

Thanks,
-- 
Jean Delvare
