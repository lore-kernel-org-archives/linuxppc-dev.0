Return-Path: <SRS0=LhWK=TL=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 7A257DDEBE
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 08:55:03 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] [POWERPC] AMCC Kilauea (405EX): Disable EMAC loopback mode
Date: Fri, 22 Feb 2008 22:54:51 +0100
References: <1203669132-9385-1-git-send-email-sr@denx.de>
	<1203715656.6976.7.camel@pasglop>
In-Reply-To: <1203715656.6976.7.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200802222254.52273.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 22 February 2008, Benjamin Herrenschmidt wrote:
> On Fri, 2008-02-22 at 09:32 +0100, Stefan Roese wrote:
> > 405EX(r) has SDR0_MFR[E0CS/E1CS] set after reset. This selects
> > the internal loopback mode. Clear these bits so that both EMACs
> > don't use loopback mode as default.
> >
> > Signed-off-by: Stefan Roese <sr@denx.de>
> > ---
> > I'm not sure if this should be done here in the board platform code,
> > or in the newemac driver or perhaps in some code common for 405EX.
> >
> > Any thoughts on this welcome.
>
> This should be done in EMAC since we also need to force internal
> loopback & clocking when probing the PHY or we might not probe
> it properly (and fail reset) if there is no link.

Yes. Valentines patches are a first step to this.

> I need to work on that.

That would be great. Thanks.

BTW: Any news on the generic phy-lib plans for ibm_newemac?

Best regards,
Stefan
