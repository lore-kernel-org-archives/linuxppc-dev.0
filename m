Return-Path: <ebony.zhu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 328E8DDE2B
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 13:36:27 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l6V3a6mu002090
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2007 20:36:08 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6V3a4o8019345
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2007 22:36:05 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [patch][0/5] powerpc V2 : Add support to fully comply
	with	IEEE-754 standard
Date: Tue, 31 Jul 2007 11:36:03 +0800
Message-ID: <32F3CC26D4DAC44E8ECD07155727A46EC7E6A6@zch01exm20.fsl.freescale.net>
In-Reply-To: <46ADFC36.5060709@ru.mvista.com>
From: "Zhu Ebony-r57400" <ebony.zhu@freescale.com>
To: "Sergei Shtylyov" <sshtylyov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 Hi Sergei,

I did some further tests and some development work in past several
months,
but due to project schedule and limited bandwidth, no patches can be
submitted
to the list by now. Anyway, I will keep you and the community updated
once there
is some progress.

Thanks.

B.R.
Ebony

> -----Original Message-----
> From: Sergei Shtylyov [mailto:sshtylyov@ru.mvista.com]=20
> Sent: Monday, July 30, 2007 10:57 PM
> To: Zhu Ebony-r57400
> Cc: Kumar Gala; linuxppc-dev@ozlabs.org; paulus@samba.org
> Subject: Re: [patch][0/5] powerpc V2 : Add support to fully=20
> comply with IEEE-754 standard
>=20
> Hello.
>=20
> Zhu Ebony-r57400 wrote:
>=20
> >>>>>>Did you end up getting testfloat running?  I'd like to see some=20
> >>>>>>testing results before accepting these patches.  I=20
> think estfloat=20
> >>>>>>is our best bet at this point.
>=20
> >>>>>Hi Kumar,
>=20
> >>>>>I looked into the testfloat suit, and found all the=20
> instructions it=20
> >>>>>tests (more than 50)should be implemented based on ASM.
>=20
> >>>>Don't follow?  Can't you build it with the e500 compiler?
>=20
> >>>The TestFloat suite provided the target of 386-Win32-gcc and=20
> >>>SPARC-Solaris-gcc only, and a template for user to porting his own=20
> >>>processor. Some general instructions are implemented in C,=20
> but some=20
> >>>CPU specific instructions like evfsmul need to be implemented=20
> >>>assemblely. To build it with e500 compiler we still Have=20
> some porting=20
> >>>work to do.
>=20
> >>I wouldn't worry too much about the vector forms.  If the scalar=20
> >>single fp and double fp test out ok the vectors are pretty much=20
> >>similar enough.
>=20
> >>Lets just get the scalar versions tested and work out any issues=20
> >>there.
>=20
> > OK, I will focus on scalar SFPF and DPFP versions first.
>=20
>     Any progress with this patchset?
>=20
> WBR, Sergei
>=20
