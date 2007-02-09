Return-Path: <ebony.zhu@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id CECBADDECC
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 16:15:19 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l195FF0F002502
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Feb 2007 22:15:15 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l195FD31001086
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Feb 2007 23:15:14 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [patch][0/5] powerpc V2 : Add support to fully comply with
	IEEE-754 standard
Date: Fri, 9 Feb 2007 13:15:12 +0800
Message-ID: <32F3CC26D4DAC44E8ECD07155727A46E8B7F7F@zch01exm20.fsl.freescale.net>
In-Reply-To: <33A3AF2F-7238-4D00-9B3F-9F7D451DF7C9@kernel.crashing.org>
From: "Zhu Ebony-r57400" <ebony.zhu@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
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
> Sent: Friday, February 09, 2007 1:19 AM
> To: Zhu Ebony-r57400
> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
> Subject: Re: [patch][0/5] powerpc V2 : Add support to fully=20
> comply with IEEE-754 standard
>=20
>=20
> On Feb 8, 2007, at 2:08 AM, Zhu Ebony-r57400 wrote:
>=20
> >>>>
> >>>> Did you end up getting testfloat running?  I'd like to see some=20
> >>>> testing results before accepting these patches.  I think
> >> testfloat is
> >>>> our best bet at this point.
> >>>>
> >>> Hi Kumar,
> >>>
> >>> I looked into the testfloat suit, and found all the=20
> instructions it=20
> >>> tests (more than 50)should be implemented based on ASM.
> >>
> >> Don't follow?  Can't you build it with the e500 compiler?
> >>
> > The TestFloat suite provided the target of 386-Win32-gcc and=20
> > SPARC-Solaris-gcc only, and a template for user to porting his own=20
> > processor. Some general instructions are implemented in C, but some=20
> > CPU specific instructions like evfsmul need to be implemented=20
> > assemblely. To build it with e500 compiler we still Have=20
> some porting=20
> > work to do.
>=20
> I wouldn't worry too much about the vector forms.  If the=20
> scalar single fp and double fp test out ok the vectors are=20
> pretty much similar enough.
>=20
> Lets just get the scalar versions tested and work out any=20
> issues there.
>=20
> - k

OK, I will focus on scalar SFPF and DPFP versions first.
