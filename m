Return-Path: <vapier.adi@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D4D3FB6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 Aug 2009 14:34:05 +1000 (EST)
Received: from mail-gx0-f212.google.com (mail-gx0-f212.google.com
	[209.85.217.212]) by ozlabs.org (Postfix) with ESMTP id 3C267DDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2009 14:34:04 +1000 (EST)
Received: by gxk8 with SMTP id 8so4946179gxk.9
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2009 21:34:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090729170510.GD4803@oksana.dev.rtsoft.ru>
References: <20090729170345.GA26787@oksana.dev.rtsoft.ru>
	<20090729170510.GD4803@oksana.dev.rtsoft.ru>
From: Mike Frysinger <vapier.adi@gmail.com>
Date: Wed, 12 Aug 2009 00:12:55 -0400
Message-ID: <8bd0f97a0908112112m2e97c71do722199fdce476231@mail.gmail.com>
Subject: Re: [PATCH 4/7] spi: Prefix modalias with "spi:"
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Content-Type: text/plain; charset=UTF-8
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Jean Delvare <khali@linux-fr.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 29, 2009 at 13:05, Anton Vorontsov wrote:
> This makes it consistent with other buses (platform, i2c, vio, ...).
> I'm not sure why we use the prefixes, but there must be a reason.
>
> This was easy enough to do it, and I did it.

acked-by-me for misc blackfin/adi drivers, thanks
-mike
