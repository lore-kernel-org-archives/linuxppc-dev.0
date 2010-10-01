Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
	by ozlabs.org (Postfix) with ESMTP id 7B021B70A3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  2 Oct 2010 02:30:42 +1000 (EST)
Subject: Re: Introduce support for little endian PowerPC
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1285935283.2463.78.camel@pasglop>
References: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
	<2C5357FA-F87F-457E-B5C1-0DCC5A842DE7@kernel.crashing.org>
	<AANLkTinSDMvBb7rnnfwYMkEVOgDUqRetZg86rh-UmSAg@mail.gmail.com>
	<1285935283.2463.78.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 01 Oct 2010 18:20:41 +0200
Message-ID: <1285950041.15020.272.camel@thor.local>
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

On Fre, 2010-10-01 at 22:14 +1000, Benjamin Herrenschmidt wrote:=20
>=20
> Now, the main reasons in practice are anything touching graphics.
>=20
> There's quite a few IP cores out there for SoCs that don't have HW
> swappers, and -tons- of more or less ugly code that can't deal with non
> native pixel ordering (hell, even Xorg isn't good at it, we really only
> support cards that have HW swappers today).

That's not true. Even the radeon driver doesn't really need the HW
swappers anymore with KMS.


> There's an even bigger pile of application code that deals with graphics
> without any regard for endianness and is essentially unfixable.

Out of curiosity, what kind of APIs are those apps using? X11 and OpenGL
have well-defined semantics wrt endianness, allowing the drivers to
handle any necessary byte swapping internally, and IME the vast majority
of apps handle this correctly.


--=20
Earthling Michel D=C3=A4nzer           |                http://www.vmware.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
