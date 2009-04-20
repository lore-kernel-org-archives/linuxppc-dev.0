Return-Path: <Yu.Liu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 50FC1DDF94
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Apr 2009 17:41:15 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n3K7f54Z011322
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Apr 2009 00:41:12 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n3K7f3s5012932
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Apr 2009 02:41:04 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: who know's what is "TestFloat cases" and how to test this feature
	onthe Freescale MPC8536DS board
Date: Mon, 20 Apr 2009 15:41:02 +0800
Message-ID: <0A1FE637C2C7E148B9573BB60CC630E520FC0A@zch01exm26.fsl.freescale.net>
In-Reply-To: <003001c9c0d0$c6919510$53b4bf30$@com>
References: <764365e7af2e476e43cd674738e51f13b306979b.1239874968.git.monstr@monstr.eu>	<74c0088dfda1816c21914c0a8da0c42908526c5e.1239874968.git.monstr@monstr.eu>	<20090417170707.B6C95C4004F@mail150-wa4.bigfish.com><fa686aa40904172249m5e261492w48c8d9d8446600e0@mail.gmail.com>
	<003001c9c0d0$c6919510$53b4bf30$@com>
From: "Liu Yu-B13201" <Yu.Liu@freescale.com>
To: "derekzheng" <zhengxiang9@163.com>,
	"linuxppc-dev" <linuxppc-dev@ozlabs.org>, <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> -----Original Message-----
> From: linuxppc-dev-bounces+b13201=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+b13201=3Dfreescale.com@ozlabs.org]=20
> On Behalf Of derekzheng
> Sent: Sunday, April 19, 2009 5:25 PM
> To: 'linuxppc-dev'; microblaze-uclinux@itee.uq.edu.au;=20
> linux-kernel@vger.kernel.org
> Subject: who know's what is "TestFloat cases" and how to test=20
> this feature onthe Freescale MPC8536DS board
>=20
> Hi all guys:
>=20
> The Freescale MPC8536DS board Integrated TestFloat cases, and=20
> I do not know how to test this feature on this board.
> Please tell me how to test it if you known
>=20

You can find the user manual "E500v2 SPE Floating Point" in BSP iso.
