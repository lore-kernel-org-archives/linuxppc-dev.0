Return-Path: <ebony.zhu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 2D293DDED6
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 19:16:06 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l0F8G66j013676
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 01:16:06 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l0F8G3n2002270
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 02:16:05 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Subject: RE: [patch][0/5] powerpc: Add support to fully comply with
	IEEE-754standard
Date: Mon, 15 Jan 2007 16:16:02 +0800
Message-ID: <32F3CC26D4DAC44E8ECD07155727A46E816BEC@zch01exm20.fsl.freescale.net>
In-Reply-To: <009dcf6d65c2d14067471cb2df09fae2@kernel.crashing.org>
From: "Zhu Ebony-r57400" <ebony.zhu@freescale.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
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
> Sent: 2007=C4=EA1=D4=C212=C8=D5 20:04
> To: Zhu Ebony-r57400
> Cc: Paul Mackerras; linuxppc-dev@ozlabs.org
> Subject: Re: [patch][0/5] powerpc: Add support to fully=20
> comply with IEEE-754standard
>=20
> > When floating-point underflow exceptions are disabled=20
> (SPEFSCR[FUNFE]=20
> > is cleared) and the result of a floating-point operation=20
> underflows, a=20
> > signed zero result is produced.
>=20
> You probably want to make at least this one tweakable=20
> per-process; on some important algorithms (some FFTs
> etc.) the results are perfectly acceptable with underflow-=20
> to-zero and the performance difference is huge.  AltiVec can=20
> do this per-process too, for example -- it has a user=20
> register for setting this, you need some other interface though.
>=20
>=20
> Segher

Do you mean we can make a switch in order to let user choose
whether to enable exception handling or just use default value? If so,
a separate CONFIG_SPE_MATH_EMU in Kconfig is reasonable...

Ebony
