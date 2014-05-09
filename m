Return-Path: <harninder.rai@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0142.outbound.protection.outlook.com [207.46.163.142])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C972A14009B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 May 2014 18:55:32 +1000 (EST)
From: Harninder Rai <harninder.rai@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: powerpc/mpc85xx: Add BSC9132 QDS Support
Date: Fri, 9 May 2014 08:55:25 +0000
Message-ID: <163808b877f64f2689d8b678e2dc61df@BL2PR03MB177.namprd03.prod.outlook.com>
References: <1395128102-12983-1-git-send-email-harninder.rai@freescale.com>
 <20140503003113.GB20757@home.buserror.net>
In-Reply-To: <20140503003113.GB20757@home.buserror.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "prabhakar@freescale.com" <prabhakar@freescale.com>, Ruchika
 Gupta <ruchika.gupta@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Saturday, May 03, 2014 6:01 AM
> To: Rai Harninder-B01044
> Cc: linuxppc-dev@lists.ozlabs.org; Gupta Ruchika-R66431
> Subject: Re: powerpc/mpc85xx: Add BSC9132 QDS Support
>=20
> On Tue, Mar 18, 2014 at 01:05:02PM +0530, harninder rai wrote:
> > +&ifc {
> > +	#address-cells =3D <2>;
> > +	#size-cells =3D <1>;
> > +	compatible =3D "fsl,ifc", "simple-bus";
> > +	/* FIXME: Test whether interrupts are split */
> > +	interrupts =3D <16 2 0 0 20 2 0 0>;
> > +};
>=20
> Have you done this test yet?
Checked with Prabhakar and he says that on 9132, the IFC interrupts are spl=
it
B4/T4 (and variants), C29x etc onwards are when the interrupts got merged i=
nto single interrupt
>=20
> -Scott
