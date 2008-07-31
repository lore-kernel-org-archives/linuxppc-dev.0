Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 24063DE25F
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 19:06:38 +1000 (EST)
Date: Thu, 31 Jul 2008 09:49:01 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ide pmac breakage
Message-ID: <20080731094901.062a2602@lxorguk.ukuu.org.uk>
In-Reply-To: <200807310248.29214.bzolnier@gmail.com>
References: <1217208596.11188.144.camel@pasglop>
	<200807302111.54514.bzolnier@gmail.com>
	<1217458152.11188.355.camel@pasglop>
	<200807310248.29214.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, petkovbb@gmail.com,
	linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> There seems to be some confusion between warm-plugging of IDE devices
> and hot-plugging of IDE devices.
> 
> > not a single piece of HW to exercise those code path ? I don't ask you
> > to get a powermac with a media-bay, but ide_cs seems to be a pretty
> > important one that's part of what the ide maintainer should take care
> > of... And I suspect it's going to exercise the same code path as
> > mediabay.

That confuses people sometimes - ide_cs is a controller hotplug not a
device hotplug ...
