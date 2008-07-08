Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 79B1DDDE0F
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 16:08:09 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] i2c-ibm_iic: Remove deprecated OCP style part of thedriver
Date: Tue, 8 Jul 2008 08:07:53 +0200
References: <1212592932-24031-1-git-send-email-sr@denx.de>
	<20080604210400.0d7abb8e@hyperion.delvare>
	<20080707185544.7335b108@lappy.seanm.ca>
In-Reply-To: <20080707185544.7335b108@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807080807.53577.sr@denx.de>
Cc: Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 08 July 2008, Sean MacLennan wrote:
> On Wed, 4 Jun 2008 21:04:00 +0200
>
> "Jean Delvare" <khali@linux-fr.org> wrote:
> > On Wed,  4 Jun 2008 17:22:12 +0200, Stefan Roese wrote:
> > > The deprecated OCP style driver part is used by the "old" arch/ppc
> > > platform. This platform is scheduled for removal in June/July this
> > > year. This patch now removes the OCP driver part from the IBM I2C
> > > driver.
> > >
> > > Signed-off-by: Stefan Roese <sr@denx.de>
> > > ---
> > >  drivers/i2c/busses/i2c-ibm_iic.c |  181
> > > -------------------------------------- 1 files changed, 0
> > > insertions(+), 181 deletions(-)
> >
> > Applied, queued for 2.6.27, thanks Stefan.
> >
> > BTW, would you happen to know if read-only EEPROMs such as SPD or EDID
> > can be found on the i2c-ibm_iic adapters?
>
> Jean, where is this patch queued? I have a patch for the iic driver and
> it would probably be easiest if I diffed against what you have.

Those patches are in linux-next.

Best regards,
Stefan
