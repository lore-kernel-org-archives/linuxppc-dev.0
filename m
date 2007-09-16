Return-Path: <SRS0=24Qs=OM=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 9CD0BDDDF7
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Sep 2007 19:07:30 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH] i2c: devtree-aware iic support for PPC4xx
Date: Sun, 16 Sep 2007 11:07:23 +0200
References: <200709151108.01849.sr@denx.de>
	<20070915100434.GA4978@gate.ebshome.net>
	<20070915152921.36ccbec7@localhost.localdomain>
In-Reply-To: <20070915152921.36ccbec7@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709161107.23309.sr@denx.de>
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 15 September 2007, Vitaly Bordug wrote:
> > Where is dev->clkdiv initialized?
> >
> > My original version used iic_clkdiv() to calculate correct devider
> > based on OPB frequency. Did you even test this code?

Yes, I tested it successfully on the Sequoia eval board.

> heh, just my $0.02: the upper clearly shows one like missing, maybe during
> cleanup (since there is opb freq pulled in quote):
>
>         dev->clckdiv = iic_clckdiv(*prop); or smth like that

Could be. Thanks for the hint. I'll take a look at it an resubmit.

Best regards,
Stefan
