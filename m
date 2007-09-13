Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 19272DDE19
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 14:38:40 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l8D4cZ8R022722
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 21:38:36 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l8D4cYvv024583
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 23:38:35 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: 2.6.23-rc3 boot hang on MPC8641D
Date: Thu, 13 Sep 2007 12:38:33 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C85D7FB@zch01exm26.fsl.freescale.net>
In-Reply-To: <12648489.post@talk.nabble.com>
References: <12648489.post@talk.nabble.com>
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

Hi,=20

Your flat device tree address seems too low. Try to move the dtb to
higher address such as 0x2000000.

And which version of your u-boot?

Cheers!
- zw

> -----Original Message-----
> From: linuxppc-dev-bounces+wei.zhang=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+wei.zhang=3Dfreescale.com@ozlabs.or
> g] On Behalf Of sivaji
> Sent: Thursday, September 13, 2007 12:18 PM
> To: linuxppc-dev@ozlabs.org
> Subject: 2.6.23-rc3 boot hang on MPC8641D
>=20
>=20
> Hi,
>         I am try to boot the 2.6.23-rc3 kernel to my custom=20
> board based on
> 8641D Processor. After uncompressing the kernel it was hang. I got the
> following messages.
>=20
>    Uncompressing Kernel Image ... OK
>    Booting using flat device tree at 0x600000.=20
>=20
>        Then i tried to debug with GDB. In my source path i=20
> given the command
> ${CROSS_COMPILE}gdb vmlinux, I got GDB Prompt after i tried to set the
> breakpoint at start_kernel. I got follwing messages
>=20
> gdb) b start_kernel
> Cannot access memory at address 0xc02b44ec
>=20
> Processor Information:
> 8641D processor and the silicon revision is 2.0.
> Part : MPC8641D
> Revision:  2.0
> e600 Core Revision:  2.2
> DeviceMarking:  B
> Processor Version Register Value: 0x8004_0202
> System Version Register Value:   0x8090_0120
>=20
>      I don't know how to proceed. Please tell the way how to=20
> start kernel
> debug in this situation.
>=20
> By
> Sivaji
> --=20
> View this message in context:=20
> http://www.nabble.com/2.6.23-rc3-boot-hang-on-MPC8641D-tf44335
> 08.html#a12648489
> Sent from the linuxppc-dev mailing list archive at Nabble.com.
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>=20
