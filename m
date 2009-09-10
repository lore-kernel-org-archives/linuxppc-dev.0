Return-Path: <bart.vanassche@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3AE63B6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Sep 2009 20:52:23 +1000 (EST)
Received: from mail-ew0-f227.google.com (mail-ew0-f227.google.com
	[209.85.219.227]) by ozlabs.org (Postfix) with ESMTP id 6C839DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 20:52:20 +1000 (EST)
Received: by ewy27 with SMTP id 27so5519891ewy.40
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 03:52:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1252531371-14866-3-git-send-email-w.sang@pengutronix.de>
References: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
	<1252531371-14866-3-git-send-email-w.sang@pengutronix.de>
Date: Thu, 10 Sep 2009 12:52:17 +0200
Message-ID: <e2e108260909100352l2a30438fj9f0297c1974c0192@mail.gmail.com>
Subject: Re: [PATCH 2/4] i2c/chips: Remove deprecated pcf8575-driver
From: Bart Van Assche <bart.vanassche@gmail.com>
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-mips@linux-mips.org, linuxppc-dev@ozlabs.org,
	linux-i2c@vger.kernel.org, Jean Delvare <khali@linux-fr.org>,
	uclinux-dist-devel@blackfin.uclinux.org,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 9, 2009 at 11:22 PM, Wolfram Sang <w.sang@pengutronix.de> wrote=
:
>
> The pcf8575-driver in drivers/i2c/chips which just exports its register t=
o
> sysfs is superseeded by drivers/gpio/pcf857x.c which properly uses the gp=
iolib.
> As this driver has been deprecated for more than a year, finally remove i=
t.
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Bart Van Assche <bart.vanassche@gmail.com>
> Cc: Jean Delvare <khali@linux-fr.org>
> ---
> =A0Documentation/i2c/chips/pcf8575 | =A0 69 --------------
> =A0drivers/i2c/chips/Kconfig =A0 =A0 =A0 | =A0 18 ----
> =A0drivers/i2c/chips/Makefile =A0 =A0 =A0| =A0 =A01 -
> =A0drivers/i2c/chips/pcf8575.c =A0 =A0 | =A0198 -------------------------=
--------------
> =A04 files changed, 0 insertions(+), 286 deletions(-)
> =A0delete mode 100644 Documentation/i2c/chips/pcf8575
> =A0delete mode 100644 drivers/i2c/chips/pcf8575.c

This patch removes the documentation file
Documentation/i2c/chips/pcf8575 while there is no documentation under
Documentation/ for the drivers/gpio/pcf857x.c driver. Shouldn't proper
documentation for the pcf857x driver be added to the kernel tree
before the pcf8575 driver is removed ?

Bart.
