Return-Path: <vapier.adi@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5558CB707B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Sep 2009 10:00:50 +1000 (EST)
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id B495EDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 10:00:48 +1000 (EST)
Received: by yxe8 with SMTP id 8so6413087yxe.17
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Sep 2009 17:00:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
References: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
From: Mike Frysinger <vapier.adi@gmail.com>
Date: Wed, 9 Sep 2009 19:54:34 -0400
Message-ID: <8bd0f97a0909091654h290180e5ob79178583aca143f@mail.gmail.com>
Subject: Re: [Uclinux-dist-devel] Removing deprecated drivers from
	drivers/i2c/chips
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, linux-mips@linux-mips.org,
	linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	uclinux-dist-devel@blackfin.uclinux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 9, 2009 at 17:22, Wolfram Sang wrote:
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

the Blackfin defconfigs refer to an input driver for the PCF8574, not
the I2C client driver
-mike
