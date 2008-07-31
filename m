Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DC4EDDDF54
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 19:48:26 +1000 (EST)
Subject: Re: ide pmac breakage
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20080731101322.18735e64@lxorguk.ukuu.org.uk>
References: <1217208596.11188.144.camel@pasglop>
	<200807302111.54514.bzolnier@gmail.com>
	<1217458152.11188.355.camel@pasglop>
	<200807310248.29214.bzolnier@gmail.com>
	<20080731094901.062a2602@lxorguk.ukuu.org.uk>
	<1217495493.11188.441.camel@pasglop>
	<20080731101322.18735e64@lxorguk.ukuu.org.uk>
Content-Type: text/plain
Date: Thu, 31 Jul 2008 19:48:08 +1000
Message-Id: <1217497688.11188.446.camel@pasglop>
Mime-Version: 1.0
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org,
	petkovbb@gmail.com, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-07-31 at 10:13 +0100, Alan Cox wrote:
> > I could make the media-bay look like a controller hotplug if it was
> > going to make things easier...
> 
> I'm not sure it will. It may do nowdays, but the older IDE code
> historically was fairly broken for both cases except in 2.4. Also faking
> it as controller hotplug is the wrong path for libata which does real
> drive hot plug.

Yeah, that was my line of thinking initially, also the fact that it has
the nice side effect of keeping the minor number stable.

Ben.
