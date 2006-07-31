Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 601FE67B61
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Jul 2006 18:23:30 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k6V8Z8pi028263 for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Jul 2006 01:35:08 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k6V8NQ71004017
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Jul 2006 03:23:27 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Host USB on MPC8247
Date: Mon, 31 Jul 2006 16:23:51 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D071159@zch01exm20.fsl.freescale.net>
In-Reply-To: <44CDBBDD.6000401@razvoj-verbic.si>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Uros Borovsak" <boro@razvoj-verbic.si>, <linuxppc-embedded@ozlabs.org>
Cc: linux-usb-devel@lists.sourceforge.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org] On
Behalf Of
> Uros Borovsak
> Sent: Monday, July 31, 2006 4:14 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: Re: Host USB on MPC8247
>=20
> Thanks for reply,
>=20
> I made a mistake while typing the message.
>=20
> In reality I was asking how difficult would it be to port USB part  of
> kernel from 2.6.10 to 2.6.13, but I mixed kernel version's when
typing.

USB subsystem is relatively stand-alone.  So, try replace the whole
drivers/usb/ directory and update usb related header files under
include/.

ps: the question is off-topic on powerpc list.

>=20
> Mike Rapoport wrote:
> > Uros Borovsak wrote:
> >
> >
> >> Hello,
> >>
> >> Can you at least give me some idea how difficult would it be to
patch
> >> USB part of kernel from 2.6.13 to 2.6.10?
> >>
> >>
> >>
> > As far as I know USB core undergone signifcant changes between
2.6.10
> > and 2.6.13. Still it's hard to tell how difficult would it be to
> > backport USB from 2.6.13 to 2.6.10.
> > Besides, it maybe worth upgrading your kernel instead of backporing
> > USB to 2.6.10.
> >
> >
> Upgrading the whole kernel is not a way to go for me here, becouse
> company is using montavista kernel, and if I upgrade the whole kernel,
I
> would have to port all their patches also.
>=20
> I believe that MontaVista will use higher kernel version some time, so
I
> wouldn't go backporting driver to 2.6.10, but I would prefer to port
USB
> part of kernel from 2.6.10 to 2.6.13.
>=20
> Do you think that is possible and how hard would it be?
>=20
> Best regards
>=20
> Uros
> >> Are changes only in usb part of kernel, or are there also some
> >> changes in other parts of kernel, that I would have to port?
> >>
> >> Thanks,
> >>
> >> Best regards
> >>
> >> Uros
