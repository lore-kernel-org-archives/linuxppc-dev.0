Return-Path: <ebony.zhu@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 062D7DDE4A
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 17:45:23 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l0F6jNms021282
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Jan 2007 23:45:23 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l0F6jKGM006903
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 00:45:22 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Subject: RE: [patch][0/5] powerpc: Add support to fully comply with IEEE-754
	standard
Date: Mon, 15 Jan 2007 14:45:19 +0800
Message-ID: <32F3CC26D4DAC44E8ECD07155727A46E816B9F@zch01exm20.fsl.freescale.net>
In-Reply-To: <044bc5d89a68ac70c37f1796fb4547c1@kernel.crashing.org>
From: "Zhu Ebony-r57400" <ebony.zhu@freescale.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Segher Boessenkool [mailto:segher@kernel.crashing.org]=20
> Sent: 2007=C4=EA1=D4=C212=C8=D5 20:05
> To: Zhu Ebony-r57400
> Cc: Kumar Gala; paulus@samba.org; linuxppc-dev@ozlabs.org
> Subject: Re: [patch][0/5] powerpc: Add support to fully=20
> comply with IEEE-754 standard
>=20
> >> * Why isn't there any handling of SPEFloatingPointRound exceptions?
> >
> > I think the SPEFloatingPointRound exception is not=20
> necessary to handle=20
> > if we handle floating point exception this way.
>=20
> Some more explanation than "I don't think so" would be nice ;-)
>=20

Thanks for your reminder, I would like to correct what I said before.
FP round interrupt may be taken on some circumstance that FP
data interrupt doesn't take place, so we may still have to handle round
interrupt to fully comply IEEE-754. Do you think using the same way to
handle FP round interrupt as FP data interrupt is a reasonable approach?

Ebony
