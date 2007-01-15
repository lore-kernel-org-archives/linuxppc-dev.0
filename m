Return-Path: <ebony.zhu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 6F16EDDE41
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 18:59:00 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l0F7ww5Y009427
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 00:58:58 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l0F7wufj027793
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 01:58:57 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Subject: RE: [patch][5/5] powerpc: Add the general support for Embedded
	Floating-Point instructions
Date: Mon, 15 Jan 2007 15:58:55 +0800
Message-ID: <32F3CC26D4DAC44E8ECD07155727A46E816BDF@zch01exm20.fsl.freescale.net>
In-Reply-To: <89913836fb5b7a4de773ee13c27977c8@kernel.crashing.org>
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
> Sent: 2007=C4=EA1=D4=C212=C8=D5 20:37
> To: Zhu Ebony-r57400
> Cc: Christoph Hellwig; paulus@samba.org; linuxppc-dev@ozlabs.org
> Subject: Re: [patch][5/5] powerpc: Add the general support=20
> for Embedded Floating-Point instructions
>=20
> > CONFIG_SPE doesn't force the whole math emulation to be built. If=20
> > CONFIG_SPE is set, only the new SPFP/DPFP/VSPFP instructions in=20
> > arch/powerpc/math-emu will be built, while the previous FPU=20
> > instructions won't.
>=20
> And the other way around I suppose.
>=20
> > Therefore, what I'm trying to do is to build directory=20
> > arch/powerpc/math-emu if CONFIG_MATH_EMULATION or=20
> CONFIG_SPE is set.=20
> > Do you have any idea?
>=20
> Maybe you should really have a separate CONFIG_SPE_MATH_EMU?
> Or that might complicate things more than it solves, dunno.
>=20
>=20
> Segher
>=20
>=20

If there is an statement that can express "CONFIG_MATH_EMULATION or
CONFIG_SPE", things would become simpler.

Ebony
