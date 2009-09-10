Return-Path: <vapier.adi@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 15B6FB6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Sep 2009 17:55:59 +1000 (EST)
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id 737F6DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 17:55:58 +1000 (EST)
Received: by yxe8 with SMTP id 8so6748558yxe.17
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 00:55:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090910062609.GA26454@pengutronix.de>
References: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
	<8bd0f97a0909091654h290180e5ob79178583aca143f@mail.gmail.com>
	<20090910062609.GA26454@pengutronix.de>
From: Mike Frysinger <vapier.adi@gmail.com>
Date: Thu, 10 Sep 2009 03:55:36 -0400
Message-ID: <8bd0f97a0909100055n3192deeka93dc853f0139bfc@mail.gmail.com>
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

On Thu, Sep 10, 2009 at 02:26, Wolfram Sang wrote:
>> the Blackfin defconfigs refer to an input driver for the PCF8574, not
>> the I2C client driver
>
> Yup, I am aware of that. With the exception of:
>
> blackfin/configs/PNAV-10_defconfig:773:CONFIG_SENSORS_PCF8574=m

thanks for double checking.  i'm not sure this board even has this
device.  i'll review the hardware.
-mike
