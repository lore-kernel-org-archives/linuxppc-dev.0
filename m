Return-Path: <Shengzhou.Liu@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0115.outbound.protection.outlook.com [207.46.100.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 74F721A004D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jun 2015 18:57:22 +1000 (AEST)
From: Liu Shengzhou <Shengzhou.Liu@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [2/4,v3] powerpc/fsl-booke: Add T1024 QDS board support
Date: Mon, 1 Jun 2015 08:23:39 +0000
Message-ID: <DM2PR03MB398E053EB9A4BE50EE67B7FF8B60@DM2PR03MB398.namprd03.prod.outlook.com>
References: <1428566865-35732-2-git-send-email-Shengzhou.Liu@freescale.com>
 <20150529002436.GA4248@home.buserror.net>
In-Reply-To: <20150529002436.GA4248@home.buserror.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Subject: Re: [2/4,v3] powerpc/fsl-booke: Add T1024 QDS board support
>=20
> On Thu, Apr 09, 2015 at 04:07:43PM +0800, Shengzhou Liu wrote:
> > +			flash@2 {
> > +				#address-cells =3D <1>;
> > +				#size-cells =3D <1>;
> > +				compatible =3D "eon,en25s64";   /* 8MB */
> > +				reg =3D <2>;
> > +				spi-max-frequency =3D <10000000>;
> > +			};
>=20
> AFAICT the vendor is phyton, not eon.

How do you think the vendor is phyton?
Per en25s64 data sheet, it's really EON (Eon Silicon Solution, Inc,  www.eo=
nssi.com)
I had sent a patch for EON http://patchwork.ozlabs.org/patch/367810/ last y=
ear.
There is no 'phyton' in binding document.=20
