Return-Path: <ebony.zhu@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id BB690DDE3D
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 18:04:49 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l2874j2q029093
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Mar 2007 00:04:46 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l2874iHS009057
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Mar 2007 01:04:45 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [patch][5/5] powerpc V2: Add the general support for Embedded
	Floating-Point instructions
Date: Thu, 8 Mar 2007 15:04:42 +0800
Message-ID: <32F3CC26D4DAC44E8ECD07155727A46E92B1E8@zch01exm20.fsl.freescale.net>
In-Reply-To: <543c39e820836fcfe2d93681a0657d57@kernel.crashing.org>
From: "Zhu Ebony-r57400" <ebony.zhu@freescale.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>,
	"Kumar Gala" <galak@kernel.crashing.org>
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
> Sent: Friday, February 09, 2007 10:40 PM
> To: Kumar Gala
> Cc: paulus@samba.org; Zhu Ebony-r57400; linuxppc-dev@ozlabs.org
> Subject: Re: [patch][5/5] powerpc V2: Add the general support=20
> for Embedded Floating-Point instructions
>=20
> >>> I thought we were going to have some general Kconfig option to=20
> >>> enable all this?  EMDEDDED_FP_IEEE or something like that
> >>
> >> So that users have chance to enable/disable fully IEEE compliance?
> >> Segher
> >> had mentioned this, and it sounds reasonable.
> >
> > Its alot of code to bring in if you don't care about IEEE=20
> compliance.
>=20
> Yes certainly, and that's important for embedded applications.
>=20
> My point however is that this should be selectable *per=20
> process* at runtime.  Compare to the AltiVec situation (where=20
> processes can select (non-)IEEE behaviour by themselves);=20
> most tasks do
> *not* want IEEE behaviour as it is just too expensive (and=20
> not necessary for many applications).
>=20
>=20
> Segher

Sorry for the delaying response since I just came back from vacation.

Agreed with you that the IEEE handler is expensive for processes.  Do
you
think adding a switch to the Kconfig option is not enough?  I'm
wondering how
to make it selectable *per process* at runtime.

Ebony
