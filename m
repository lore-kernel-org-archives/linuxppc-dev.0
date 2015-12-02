Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0109.outbound.protection.outlook.com [157.56.111.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 22AB51A0286
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Dec 2015 18:05:18 +1100 (AEDT)
From: Liberman Igal <Igal.Liberman@freescale.com>
To: David Miller <davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Scott Wood
 <scottwood@freescale.com>, Madalin-Cristian Bucur
 <madalin.bucur@freescale.com>, "pebolle@tiscali.nl" <pebolle@tiscali.nl>,
 "joakim.tjernlund@transmode.se" <joakim.tjernlund@transmode.se>,
 "ppc@mindchasers.com" <ppc@mindchasers.com>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>
Subject: RE: [v8, 2/6] fsl/fman: Add FMan support
Date: Wed, 2 Dec 2015 07:05:09 +0000
Message-ID: <DM2PR03MB509F4530CBE707667F711D2E60E0@DM2PR03MB509.namprd03.prod.outlook.com>
References: <1448886062-16962-1-git-send-email-igal.liberman@freescale.com>
 <1448886062-16962-3-git-send-email-igal.liberman@freescale.com>
 <20151201.162810.1750455760429212300.davem@davemloft.net>
In-Reply-To: <20151201.162810.1750455760429212300.davem@davemloft.net>
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

Hi David,
Thank you for your feedback, I'll address it and re-submit.

Regards,
Igal Liberman

> -----Original Message-----
> From: David Miller [mailto:davem@davemloft.net]
> Sent: Tuesday, December 01, 2015 11:28 PM
> To: Liberman Igal-B31950 <Igal.Liberman@freescale.com>
> Cc: netdev@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; linux-
> kernel@vger.kernel.org; Wood Scott-B07421 <scottwood@freescale.com>;
> Bucur Madalin-Cristian-B32716 <madalin.bucur@freescale.com>;
> pebolle@tiscali.nl; joakim.tjernlund@transmode.se; ppc@mindchasers.com;
> stephen@networkplumber.org
> Subject: Re: [v8, 2/6] fsl/fman: Add FMan support
>=20
> From: <igal.liberman@freescale.com>
> Date: Mon, 30 Nov 2015 14:20:58 +0200
>=20
> > +typedef irqreturn_t (fman_exceptions_cb)(struct fman *fman,
> > +					 enum fman_exceptions exception);
>=20
> Function and function pointer declarations and definitions should be
> indented such that the second and subsequent lines begin precisely at the
> first column after the openning parenthesis of the first line.
>=20
> Please audit this and fix it in your entire submission, almost ever new s=
uch
> case is done incorrectly.
>=20
> > +	fman->state->exceptions =3D (EX_DMA_BUS_ERROR                 |
> > +					EX_DMA_READ_ECC              |
> > +					EX_DMA_SYSTEM_WRITE_ECC      |
> > +					EX_DMA_FM_WRITE_ECC          |
> > +					EX_FPM_STALL_ON_TASKS        |
> > +					EX_FPM_SINGLE_ECC            |
> > +					EX_FPM_DOUBLE_ECC            |
> > +
> 	EX_QMI_DEQ_FROM_UNKNOWN_PORTID |
> > +					EX_BMI_LIST_RAM_ECC          |
> > +					EX_BMI_STORAGE_PROFILE_ECC   |
> > +					EX_BMI_STATISTICS_RAM_ECC    |
> > +					EX_MURAM_ECC                 |
> > +					EX_BMI_DISPATCH_RAM_ECC      |
> > +					EX_QMI_DOUBLE_ECC            |
> > +					EX_QMI_SINGLE_ECC);
>=20
> The same applies to multi-line parenthesized expressions like this one.
> Again, please audit and fix this in your entire submission.
>=20
> Thanks.
