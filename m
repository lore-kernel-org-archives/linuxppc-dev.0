Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 85FA9DDF13
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 11:09:31 +1000 (EST)
Subject: Re: ide pmac breakage
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
In-Reply-To: <200807310248.29214.bzolnier@gmail.com>
References: <1217208596.11188.144.camel@pasglop>
	<200807302111.54514.bzolnier@gmail.com>
	<1217458152.11188.355.camel@pasglop>
	<200807310248.29214.bzolnier@gmail.com>
Content-Type: text/plain
Date: Thu, 31 Jul 2008 11:09:19 +1000
Message-Id: <1217466559.11188.378.camel@pasglop>
Mime-Version: 1.0
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org,
	petkovbb@gmail.com, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-07-31 at 02:48 +0200, Bartlomiej Zolnierkiewicz wrote:
> There seems to be some confusion between warm-plugging of IDE devices
> and hot-plugging of IDE devices.
> 
> > not a single piece of HW to exercise those code path ? I don't ask you
> > to get a powermac with a media-bay, but ide_cs seems to be a pretty
> > important one that's part of what the ide maintainer should take care
> > of... And I suspect it's going to exercise the same code path as
> > mediabay.
> 
> I'm open for offers of co-maintaince of the code (which includes taking
> over particular host drivers) and since you seem to have pretty good
> insight into what ide maintainer should be doing I presume that you want
> to be added to MAINTAINERS?

Should I laugh ?

Seriously here. Those things used to work, you broke them.

It may be worthwile cleanup / improvements, but at the end of the day,
if you are the maintainer for drivers/ide, and things as fundamental as
supporting proper ide_cs seems to be totally part of your job. I'm not
saying ide_cs is broken today (though I suspect it -may- be suffering
from similar breakage to media-bay), however, I'm reacting to your
apparent lack of interest in making sure these things work.

Ben.
