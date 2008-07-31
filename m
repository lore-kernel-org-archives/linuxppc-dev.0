Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 00922DDF83
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 19:30:39 +1000 (EST)
Date: Thu, 31 Jul 2008 10:13:22 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: benh@kernel.crashing.org
Subject: Re: ide pmac breakage
Message-ID: <20080731101322.18735e64@lxorguk.ukuu.org.uk>
In-Reply-To: <1217495493.11188.441.camel@pasglop>
References: <1217208596.11188.144.camel@pasglop>
	<200807302111.54514.bzolnier@gmail.com>
	<1217458152.11188.355.camel@pasglop>
	<200807310248.29214.bzolnier@gmail.com>
	<20080731094901.062a2602@lxorguk.ukuu.org.uk>
	<1217495493.11188.441.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org,
	petkovbb@gmail.com, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I could make the media-bay look like a controller hotplug if it was
> going to make things easier...

I'm not sure it will. It may do nowdays, but the older IDE code
historically was fairly broken for both cases except in 2.4. Also faking
it as controller hotplug is the wrong path for libata which does real
drive hot plug.


Alan
