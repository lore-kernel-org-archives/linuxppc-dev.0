Return-Path: <ebony.zhu@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id E3724DDE22
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 19:27:35 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l0C8RYZE009187
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 01:27:34 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0C8RWif026446
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 02:27:33 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Subject: RE: [patch][0/5] powerpc: Add support to fully comply with IEEE-754
	standard
Date: Fri, 12 Jan 2007 16:27:30 +0800
Message-ID: <32F3CC26D4DAC44E8ECD07155727A46E816A6B@zch01exm20.fsl.freescale.net>
In-Reply-To: <5B8622DA-17D0-4232-954F-B72C1FCC0300@kernel.crashing.org>
From: "Zhu Ebony-r57400" <ebony.zhu@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Kumar,

I wrote some cases for testing. For SPFP and DPFP exception testing,
the test cases included plus, minus, multiply, divide, comparisons, =
conversions,
DBZ... for Nan/Denorm/Inf numbers. I also tested the cases that=20
the operation result would generate Nan/Denorm/Inf/overflow/underflow
numbers. For Vector SPFP exception testing, I wrote inline asm based =
testing
program to test the instructions directly.

Ebony

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: 2007=C4=EA1=D4=C212=C8=D5 13:46
> To: Paul Mackerras
> Cc: Zhu Ebony-r57400; linuxppc-dev@ozlabs.org
> Subject: Re: [patch][0/5] powerpc: Add support to fully=20
> comply with IEEE-754 standard
>=20
>=20
> On Jan 11, 2007, at 11:29 PM, Paul Mackerras wrote:
>=20
> > Zhu Ebony-r57400 writes:
> >
> >> This series of patch add support to fully comply with IEEE-754=20
> >> standard for E500/E500v2 core when hardware floating point=20
> compiling=20
> >> is used.
> >
> > Your patch descriptions need to explain in detail in what way the=20
> > current code doesn't comply with the IEEE-754 standard, and what=20
> > approach you have taken to make it comply.  If there are=20
> alternative=20
> > approaches, explain why the approach you have taken is the best.
> >
> > Thanks,
> > Paul.
>=20
> In addition, this is something that we need to know how it=20
> was tested for IEEE-754 compliance.
>=20
> - k
>=20
