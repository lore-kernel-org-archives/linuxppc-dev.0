Return-Path: <ebony.zhu@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 32A97DDDFE
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2007 20:43:18 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l0G9hHvR028628
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2007 02:43:17 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l0G9hCX9024574
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2007 03:43:13 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Subject: RE: [patch][5/5] powerpc: Add the general support for Embedded
	Floating-Point instructions
Date: Tue, 16 Jan 2007 17:43:10 +0800
Message-ID: <32F3CC26D4DAC44E8ECD07155727A46E816D7C@zch01exm20.fsl.freescale.net>
In-Reply-To: <9F9680DA-DDAD-4DF2-B5FE-6E00CF8A06E2@kernel.crashing.org>
From: "Zhu Ebony-r57400" <ebony.zhu@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>
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
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: 2007=C4=EA1=D4=C213=C8=D5 05:49
> To: Benjamin Herrenschmidt
> Cc: Zhu Ebony-r57400; linuxppc-dev@ozlabs.org; paulus@samba.org
> Subject: Re: [patch][5/5] powerpc: Add the general support=20
> for Embedded Floating-Point instructions
>=20
>=20
> On Jan 12, 2007, at 3:27 PM, Benjamin Herrenschmidt wrote:
>=20
> >> I think its a fair assumption that nothing is going to=20
> interrupt the=20
> >> handling of the exception, so its safe to assume the=20
> process causing=20
> >> the interrupt will be the same one we return to.
> >
> > What about the get_user to get to the faulting instruction=20
> ? I suppose=20
> > if those processors are UP only and we use an exception with EE=20
> > disabled, there should be no way the page has been evicted=20
> since the=20
> > access, so that should work, but will that ever be true ?
>=20
> For UP we are ok, since nothing else can cause an invalidate.
>=20
> How do we handle getting a fault when we are emulating any=20
> other instruction?
>=20
> - k
>=20

Do you think using SRR0 is safer since it contains the exact effective =
address
of the instruction causing the interrupt?

B.R.
Ebony
