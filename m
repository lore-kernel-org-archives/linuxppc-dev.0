Return-Path: <Horst.KRONSTORFER@frequentis.com>
Received: from mail1.frequentis.com (mail1.frequentis.com [212.186.194.131])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "spamquarantine.frequentis.frq",
	Issuer "Frequentis Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B35FEB70EB
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Oct 2010 21:49:14 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [QUESTION] MPC8343 'internal only' DMA support
Date: Thu, 21 Oct 2010 12:49:07 +0200
Message-ID: <2E0C184B35151B4690232FF6CFE53FE501569CEA@VIECLEX02.frequentis.frq>
In-Reply-To: <AANLkTin7UQQRjQazAVdcjiTyEmwUW5GsZ1Qkv9UOp4cZ@mail.gmail.com>
References: <ActvZb6Wjf+X+L1bSaeyxpan+cSXVQ==>
	<2E0C184B35151B4690232FF6CFE53FE501569473@VIECLEX02.frequentis.frq>
	<AANLkTin7UQQRjQazAVdcjiTyEmwUW5GsZ1Qkv9UOp4cZ@mail.gmail.com>
From: "KRONSTORFER Horst" <Horst.KRONSTORFER@frequentis.com>
To: "Timur Tabi" <timur@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: timur.tabi@gmail.com [mailto:timur.tabi@gmail.com] On Behalf Of =
Timur
Tabi
> Sent: Mittwoch, 20. Oktober 2010 21:45
> To: KRONSTORFER Horst
> Cc: linuxppc-dev@lists.ozlabs.org
> Subject: Re: [QUESTION] MPC8343 'internal only' DMA support
>=20
> On Tue, Oct 19, 2010 at 3:15 AM, KRONSTORFER Horst
<Horst.KRONSTORFER@frequentis.com> wrote:
> > i assume the mpc8343 dma controllers ability to do internally
> > controlled operations (csb/csb) is _not_ affected by deactivating
> > externally controlled operations via pinmultiplexing in sicrl.
> >
> > am I correct?
>=20
> Hmmm... maybe.  In general, if you want an external master for the DMA
controller, I think you need to
> enable that via various registers.  So if you don't enable external =
master,
you won't have one.
>=20
> Does that answer your question?
>=20

no.  i was just wondering if anybody encountered problems with internal =
dma
operations
when external control was 'deactivated' by setting the appropriate pin
functions to
... let's say ... gpio and actually do arbitrary i/o on that pins.

-h

> --
> Timur Tabi
> Linux kernel developer at Freescale
