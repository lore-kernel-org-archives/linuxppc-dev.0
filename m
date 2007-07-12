Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7E489DDDFF
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 18:17:59 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6C8Hrne013433
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 01:17:54 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l6C8HqSg011942
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 03:17:52 -0500 (CDT)
Subject: Re: [PATCH] Fix mpc7448hpc2 tsi108 device_type bug
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <C0041903-5892-4B77-962E-A5877667BBEE@kernel.crashing.org>
References: <1184135957.23157.6.camel@localhost.localdomain>
	<C0041903-5892-4B77-962E-A5877667BBEE@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1184228259.27622.3.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 12 Jul 2007 16:17:40 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-07-12 at 15:39, Kumar Gala wrote:
> On Jul 11, 2007, at 1:39 AM, Zang Roy-r61911 wrote:
> 
> > From: Roy Zang <tie-fei.zang@freescale.com>
> >
> > Fix mpc7448hpc2 tsi108 device_type bug.
> > Wrong device type will break the board startup.
> >
> > Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> > ---
> > Please apply this patch. The bug breaks the board
> > startup.
> > Please copy patches about 74xx and tsi bridge
> > to me.
> >
> >  arch/powerpc/boot/dts/mpc7448hpc2.dts |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/powerpc/boot/dts/mpc7448hpc2.dts b/arch/powerpc/ 
> > boot/dts/mpc7448hpc2.dts
> > index 0e3d314..b9158eb 100644
> > --- a/arch/powerpc/boot/dts/mpc7448hpc2.dts
> > +++ b/arch/powerpc/boot/dts/mpc7448hpc2.dts
> > @@ -45,7 +45,7 @@
> >               #address-cells = <1>;
> >               #size-cells = <1>;
> >               #interrupt-cells = <2>;
> > -             device_type = "tsi108-bridge";
> > +             device_type = "tsi-bridge";
> 
> Is there a reason we don't add:
> 
>                  compatible = "tsi108-bridge";
> 
> like the holly dts has?
I noticed it.
Until now, it does not affect the function.
I plan to update the mpc7448hpc2 dts file reflecting tsi109 chip.
I will add the compatible field in that patch.
Please apply this one first.
Roy
