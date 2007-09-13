Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EC36FDDE3C
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 16:46:58 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l8D6kqCf009739
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 23:46:52 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l8D6koGR012357
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 01:46:51 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: 2.6.23-rc3 boot hang on MPC8641D
Date: Thu, 13 Sep 2007 14:46:50 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C85D82D@zch01exm26.fsl.freescale.net>
In-Reply-To: <12648963.post@talk.nabble.com>
References: <12648489.post@talk.nabble.com><46B96294322F7D458F9648B60E15112C85D7FB@zch01exm26.fsl.freescale.net><12648696.post@talk.nabble.com><5850B6F4-61FD-4866-B50E-8F7FEA3FA9AD@kernel.crashing.org><46B96294322F7D458F9648B60E15112C85D808@zch01exm26.fsl.freescale.net>
	<12648963.post@talk.nabble.com>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "sivaji" <rameshmrm@gmail.com>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Sivaji,

I've tested the newest git tree of Paul's, which is aleady updated to
2.6.23-rc4. The kernel is no problem with the u-boot of our released BSP
(Jun, 2007) on MPC8641HPCN board.

Maybe you could update to the newest kernel git tree and try again.

Cheers!
-zw

> -----Original Message-----
> From: linuxppc-dev-bounces+wei.zhang=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+wei.zhang=3Dfreescale.com@ozlabs.or
> g] On Behalf Of sivaji
> Sent: Thursday, September 13, 2007 1:32 PM
> To: linuxppc-dev@ozlabs.org
> Subject: RE: 2.6.23-rc3 boot hang on MPC8641D
>=20
>=20
> Hi,
>           Sorry i specify the wrong version, we r using=20
> 1.2.0. This uboot
> was taken from the BSP which was released by Freescale.=20
> Previously we tested
> linux 2.6.21 kernel, we got linux prompt. For this we are=20
> using the same
> uboot(1.2.0).
> In that version we face some issues in the pci express, at=20
> that time kumar
> suggest to upgrade the kernel verison 2.6.23-rc3.
> Zhang did u suspect the problem is related to uboot?.
> by
> sivaji
>=20
>=20
> Zhang Wei-r63237 wrote:
> >=20
> > Yes, It's too old. Maybe not fully supports FDT. You can=20
> try the version
> > of Kumar said or in the BSP of Freescale released.
> >=20
> > - zw
> >=20
> >> -----Original Message-----
> >> From: linuxppc-dev-bounces+wei.zhang=3Dfreescale.com@ozlabs.org=20
> >> [mailto:linuxppc-dev-bounces+wei.zhang=3Dfreescale.com@ozlabs.or
> >> g] On Behalf Of Kumar Gala
> >> Sent: Thursday, September 13, 2007 1:11 PM
> >> To: sivaji
> >> Cc: linuxppc-dev@ozlabs.org
> >> Subject: Re: 2.6.23-rc3 boot hang on MPC8641D
> >>=20
> >>=20
> >> On Sep 12, 2007, at 11:52 PM, sivaji wrote:
> >>=20
> >> >
> >> >
> >> > Hi,
> >> >           I tired to move the dtb to 0x2000000, but the=20
> result was =20
> >> > same.
> >> > uboot version is 1.1.6
> >>=20
> >> seems like a pretty old u-boot.  Willing to try a 1.3.0-rc1?
> >>=20
> >> - k
> >> _______________________________________________
> >> Linuxppc-dev mailing list
> >> Linuxppc-dev@ozlabs.org
> >> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> >>=20
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> >=20
> >=20
>=20
> --=20
> View this message in context:=20
> http://www.nabble.com/2.6.23-rc3-boot-hang-on-MPC8641D-tf44335
> 08.html#a12648963
> Sent from the linuxppc-dev mailing list archive at Nabble.com.
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>=20
