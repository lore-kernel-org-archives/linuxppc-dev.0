Return-Path: <Horst.KRONSTORFER@frequentis.com>
Received: from webmail.frequentis.com (webmail.frequentis.com [213.47.210.151])
	by ozlabs.org (Postfix) with ESMTP id 131D767A6B
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 03:22:27 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [QUESTION] MPC834x DMA Support
Date: Thu, 27 Apr 2006 19:22:20 +0200
Message-ID: <C5BA91F04186584EB68FD42BB4993E6BC1B63B@FRQWOLEX01.frequentis.frq>
From: "KRONSTORFER Horst" <Horst.KRONSTORFER@frequentis.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: Donnerstag, 27. April 2006 17:25
> To: KRONSTORFER Horst
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [QUESTION] MPC834x DMA Support
>=20
>=20
> On Apr 27, 2006, at 5:37 AM, KRONSTORFER Horst wrote:
>=20
> > hi!
> >
> > does anyone know if the mpc834x's dma unit supports dma=20
> operation only=20
> > between pci and csb or also between csb and csb, f.e. devices=20
> > connected via the lbc (f.e. ram and a dsp)?
>=20
> You should be able to do csb to csb devices.

thanks for the hint!

-h

>=20
> - kumar
>=20
