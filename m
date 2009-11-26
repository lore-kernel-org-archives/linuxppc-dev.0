Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 55760B6EF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 05:42:00 +1100 (EST)
Date: Thu, 26 Nov 2009 21:41:57 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: spi_mpc8xxx.c: chip select polarity problem
Message-ID: <20091126184157.GA16607@oksana.dev.rtsoft.ru>
References: <200911161742.46663.to-fleischer@t-online.de>
	<200911211708.47253.to-fleischer@t-online.de>
	<fa686aa40911241633q38dc0cf8x8b23038fe2fdf10d@mail.gmail.com>
	<200911252141.59549.to-fleischer@t-online.de>
	<fa686aa40911251411t13dd0131od6b497399641ce3d@mail.gmail.com>
	<20091126121204.GA3558@oksana.dev.rtsoft.ru>
	<fa686aa40911261016p489981a2g1fac393264c4d1c7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <fa686aa40911261016p489981a2g1fac393264c4d1c7@mail.gmail.com>
Cc: Torsten Fleischer <to-fleischer@t-online.de>,
	spi-devel-general@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 26, 2009 at 11:16:34AM -0700, Grant Likely wrote:
[...]
> The spi-cs-high property is defined in
> Documentation/powerpc/dts-bindings/spi-bus.txt, but it definitely was
> a mistake

Yup.

> Currently the spi-cs-high property is parsed in the
> of_register_spi_devices() function, but the CS polarity needs to be
> known before registering devices.  It needs to be factored out into
> another utility function callable by spi bus drivers so that it can
> get polarity data at probe time.

Untill we have this, Torsten's patch is a real improvement, and
works for non-broken hw/fw.

So I think it should be applied.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
