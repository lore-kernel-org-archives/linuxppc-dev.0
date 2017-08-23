Return-Path: <madalin.bucur@nxp.com>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0085.outbound.protection.outlook.com [104.47.1.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcZQR1n9XzDqlw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 14:37:02 +1000 (AEST)
From: Madalin-cristian Bucur <madalin.bucur@nxp.com>
To: David Miller <davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/6] fsl/fman: enable FMan Keygen
Date: Wed, 23 Aug 2017 04:36:56 +0000
Message-ID: <AM5PR0402MB2691CF2AC9555829EC89C59CEC850@AM5PR0402MB2691.eurprd04.prod.outlook.com>
References: <1503423066-15420-1-git-send-email-madalin.bucur@nxp.com>
 <1503423066-15420-2-git-send-email-madalin.bucur@nxp.com>
 <20170822.143510.1048652578169181274.davem@davemloft.net>
In-Reply-To: <20170822.143510.1048652578169181274.davem@davemloft.net>
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

> -----Original Message-----
> From: netdev-owner@vger.kernel.org [mailto:netdev-owner@vger.kernel.org]
> On Behalf Of David Miller
> Sent: Wednesday, August 23, 2017 12:35 AM
> Subject: Re: [PATCH v2 1/6] fsl/fman: enable FMan Keygen
>=20
> From: Madalin Bucur <madalin.bucur@nxp.com>
> Date: Tue, 22 Aug 2017 20:31:01 +0300
>=20
> >  /**
> > + * fman_get_keygen
> > + *
> > + * @fman:	A Pointer to FMan device
> > + *
> > + * Get the handle to KeyGen module part of FM driver
> > + *
> > + * Return: Handle to KeyGen
> > + */
> > +struct fman_keygen *fman_get_keygen(struct fman *fman)
> > +{
> > +	return fman->keygen;
> > +}
> > +EXPORT_SYMBOL(fman_get_keygen);
>=20
> Please don't do this.
>=20
> Just directly derefence the pointer in the source code to
> get the keygen.
>=20
> Thank you.

Hi,

The struct fman is only visible in the fman file, the fman port module uses=
 struct
fman as an opaque pointer, thus this export.

Madalin
