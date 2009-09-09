Return-Path: <w.sang@pengutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D95A7B6F34
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Sep 2009 07:23:47 +1000 (EST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 708A8DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 07:23:47 +1000 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-i2c@vger.kernel.org
Date: Wed,  9 Sep 2009 23:22:47 +0200
Message-Id: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
Subject: Removing deprecated drivers from drivers/i2c/chips
Cc: linuxppc-dev@ozlabs.org, uclinux-dist-devel@blackfin.uclinux.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

continuing the quest to clean up and ultimately remove the drivers/i2c/chips
directory, this patch series removes three drivers for GPIO-expanders which are
obsoleted and marked as deprecated for more than a year. The newer (and better)
drivers can be found in drivers/gpio.

As it is ensured that the newer drivers cover the same i2c_device_ids, all
platform_devices will still match. Some defconfig updates may be necessary
though, but according to [1] this is left to the arch|platform-maintainers
(also as most defconfigs are quite outdated). For that reason, I put the
relevant arch-mailing-lists to Cc. Comments are welcome.

Regards,

   Wolfram

[1] http://lkml.org/lkml/2009/5/7/34
