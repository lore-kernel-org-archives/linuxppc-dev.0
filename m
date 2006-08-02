Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 4415567B6F
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Aug 2006 13:34:46 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k723kR3P017642
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Aug 2006 20:46:27 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k723YgY7014173
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Aug 2006 22:34:44 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: RFC: Location for Device Tree Sources?
Date: Wed, 2 Aug 2006 11:35:07 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D0713DB@zch01exm20.fsl.freescale.net>
In-Reply-To: <20060802003504.GA20439@mag.az.mvista.com>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Mark A. Greer" <mgreer@mvista.com>,
	"McClintock Matthew-R56630" <msm@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org
> [mailto:linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org] On =
Behalf
Of Mark A.
> Greer
> Sent: Wednesday, August 02, 2006 8:35 AM
> To: McClintock Matthew-R56630
> Cc: linuxppc-dev@ozlabs.org; Guennadi Liakhovetski
> Subject: Re: RFC: Location for Device Tree Sources?
>=20
> On Tue, Aug 01, 2006 at 04:01:33PM -0500, Matthew McClintock wrote:
> > On Tue, 2006-08-01 at 23:00 +0200, Guennadi Liakhovetski wrote:
> > >
> > > Mark A. Greer in his patch to port sandpoint to arch/powerpc put
> > > sandpoint.dts under arch/powerpc/boot/dts/sandpoint.dts
> >
> > I believe in his latest patches he removed this part. The device
trees
> > were not included at all and he left this point open for discussion.
>=20
> That's correct.
>=20
> TBH, I think its wrong to keep them in the kernel source at all--yes,
> the same argument could be made for arch/powerpc/boot but that's been
> settled.
>=20
> We already have dtc kept externally to the kernel source.  Why not
> keep a single site where all things necessary to powerpc linux are
kept?
> It could house dtc, the dt attach tool, and all the dt source files.

We already have gcc out of the kernel source, but we need to have all
the source code in.  :)  I strongly agree to keep dts in tree, or it
will be hard to find out what the driver really does.

>=20
> I doesn't matter to me where as long as its highly available and has
> reasonable bandwidth.  jdl.com?  source.mvista.com?  penguinppc.org?
> other?
>=20
-Leo
