Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 54905DE097
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Aug 2008 00:18:34 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org,
 avorontsov@ru.mvista.com
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
Date: Tue, 12 Aug 2008 16:18:21 +0200
References: <48A05152.7020508@harris.com> <48A19788.6050502@harris.com>
	<20080812140457.GA9103@oksana.dev.rtsoft.ru>
In-Reply-To: <20080812140457.GA9103@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808121618.21876.sr@denx.de>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, "Sparks,
	Sam" <SSparks@aclaratech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 12 August 2008, Anton Vorontsov wrote:
> > > Another possibility is that you got the wrong interrupt number
> > > in the device-tree...
> > >
> > > Ben.
> >
> > The platform is the AMCC Sequoia board.  We've built a little adapter to
> > connect a compact flash card to the processor bus.  I believe the
> > interrupt selection in the device tree is correct, and I've checked over
> > the u-boot settings for the IRQ line (active high, level sensitive).
>
> IDE IRQs are active-low.

IIRC, the CompactFlash interrupt is active-high.

Best regards,
Stefan
