Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
	by ozlabs.org (Postfix) with ESMTP id EE17CB6F11
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  4 Oct 2010 21:30:53 +1100 (EST)
Subject: Re: Introduce support for little endian PowerPC
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1285966204.2463.137.camel@pasglop>
References: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
	<2C5357FA-F87F-457E-B5C1-0DCC5A842DE7@kernel.crashing.org>
	<AANLkTinSDMvBb7rnnfwYMkEVOgDUqRetZg86rh-UmSAg@mail.gmail.com>
	<1285935283.2463.78.camel@pasglop>
	<1285950041.15020.272.camel@thor.local>
	<1285966204.2463.137.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 04 Oct 2010 12:30:42 +0200
Message-ID: <1286188242.15020.349.camel@thor.local>
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sam, 2010-10-02 at 06:50 +1000, Benjamin Herrenschmidt wrote:=20
> On Fri, 2010-10-01 at 18:20 +0200, Michel D=C3=A4nzer wrote:
> > On Fre, 2010-10-01 at 22:14 +1000, Benjamin Herrenschmidt wrote:=20
> > >=20
> > > Now, the main reasons in practice are anything touching graphics.
> > >=20
> > > There's quite a few IP cores out there for SoCs that don't have HW
> > > swappers, and -tons- of more or less ugly code that can't deal with n=
on
> > > native pixel ordering (hell, even Xorg isn't good at it, we really on=
ly
> > > support cards that have HW swappers today).
> >=20
> > That's not true. Even the radeon driver doesn't really need the HW
> > swappers anymore with KMS.
>=20
> And last I looked X still pukes if you give it a pixmap in non native
> byte order but that might have been fixed.

I'm not sure what exactly you mean by that, but I'm not aware of any
such issues offhand.


> > > There's an even bigger pile of application code that deals with graph=
ics
> > > without any regard for endianness and is essentially unfixable.
> >=20
> > Out of curiosity, what kind of APIs are those apps using? X11 and OpenG=
L
> > have well-defined semantics wrt endianness, allowing the drivers to
> > handle any necessary byte swapping internally, and IME the vast majorit=
y
> > of apps handle this correctly.
>=20
> So why is it so hard to get any video card working on ppc ? :-)

I didn't say anything about that, just that IME it should be mostly
possible to deal with endianness within the driver stack.


Note that I'm not arguing against these changes, just pointing out some
apparent inaccuracies in the reasoning for them.


--=20
Earthling Michel D=C3=A4nzer           |                http://www.vmware.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
