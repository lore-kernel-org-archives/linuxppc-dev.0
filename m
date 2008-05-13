Return-Path: <Jason.Jin@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 29F7BDDE1F
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 12:18:15 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m4D2I94x010194
	for <linuxppc-dev@ozlabs.org>; Mon, 12 May 2008 19:18:09 -0700 (MST)
Received: from zch01exm27.fsl.freescale.net (zch01exm27.ap.freescale.net
	[10.192.129.223])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m4D2I7DF020549
	for <linuxppc-dev@ozlabs.org>; Mon, 12 May 2008 21:18:08 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 2/4 V4] MSI support on 83xx/85xx/86xx board
Date: Tue, 13 May 2008 10:18:04 +0800
Message-ID: <CC27DED0F8F39E48A7E75FD768688B7A8C18C0@zch01exm27.fsl.freescale.net>
In-Reply-To: <1210335719.11689.5.camel@localhost>
References: <1210323810-24833-1-git-send-email-Jason.jin@freescale.com>
	<1210323810-24833-2-git-send-email-Jason.jin@freescale.com>
	<1210335719.11689.5.camel@localhost>
From: "Jin Zhengxiong" <Jason.Jin@freescale.com>
To: <michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>=20
> ...
>=20
> > +static int fsl_msi_host_match(struct irq_host *h, struct=20
> device_node=20
> > +*node) {
> > +	/* Exact match*/
> > +	return h->of_node =3D=3D node;
> > +}
>=20
> This is the default behaviour, so technically you don't need=20
> this routine - but I'm not fussed.

You are right, I noticed there is the default match function in=20
current kernel. I can try to remove this in my driver. Thanks.

> Acked-by: Michael Ellerman <michael@ellerman.id.au>

Thanks

Jason
