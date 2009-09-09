Return-Path: <gardner.ben@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 69117B707B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Sep 2009 09:28:46 +1000 (EST)
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.25])
	by ozlabs.org (Postfix) with ESMTP id 95F47DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 09:28:44 +1000 (EST)
Received: by ey-out-2122.google.com with SMTP id 25so1203937eya.33
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Sep 2009 16:28:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1252531371-14866-4-git-send-email-w.sang@pengutronix.de>
References: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
	<1252531371-14866-4-git-send-email-w.sang@pengutronix.de>
Date: Wed, 9 Sep 2009 18:28:42 -0500
Message-ID: <808c8e9d0909091628v3681c0cch50759d24393e570a@mail.gmail.com>
Subject: Re: [PATCH 3/4] i2c/chips: Remove deprecated pca9539-driver
From: Ben Gardner <gardner.ben@gmail.com>
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

On Wed, Sep 9, 2009 at 4:22 PM, Wolfram Sang<w.sang@pengutronix.de> wrote:
> The pca9539-driver in drivers/i2c/chips which just exports its registers to
> sysfs is superseeded by drivers/gpio/pca953x.c which properly uses the gpiolib.
> As this driver has been deprecated for more than a year, finally remove it.
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Ben Gardner <gardner.ben@gmail.com>
> Cc: Jean Delvare <khali@linux-fr.org>

Acked-by: Ben Gardner <gardner.ben@gmail.com>

Thanks for taking care of this.
Ben
