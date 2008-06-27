Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 8B5C4DDEFE
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 21:22:56 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [Resend][PATCH 1/8][Version 2] MPC5121 Update MPC5121ADS device
	tree
Date: Fri, 27 Jun 2008 13:22:52 +0200
References: <20080625203051.4FE882F123B@rumpole.eng.lineo.com>
	<20080627014233.GB17621@yookeroo.seuss>
	<4b73d43f0806262040s7993dcb7vd8a3d05793ea8a7@mail.gmail.com>
In-Reply-To: <4b73d43f0806262040s7993dcb7vd8a3d05793ea8a7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806271322.52549.arnd@arndb.de>
Cc: John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 27 June 2008, John Rigby wrote:
> On Thu, Jun 26, 2008 at 7:42 PM, David Gibson <david@gibson.dropbear.id.au> wrote:
> >
> > [snip]
> >>       soc@80000000 {
> >>               compatible = "fsl,mpc5121-immr";
> >> +             device_type = "soc";
> >
> > I realise we still need the unwanted device_type value on the soc in
> > some cases for backwards compatibility, but why are you adding it
> > where it wasn't before..?
> >
> Because get_immrbase in fsl_soc.c does not work without it.
> 

I guess that's not much of a problem in the future any more, since with the
move to arch/powerpc, the few remaining drivers that still use it can
finally be converted to use of_iomap on the actual device instead of
the immrbase hack.

	Arnd <><
