Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound9-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0FB48DE025
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Jan 2008 08:27:51 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Subject: RE: In PowerPC's feature,
	are there any difference between ML410 and ML403?
Date: Thu, 10 Jan 2008 13:27:47 -0800
In-Reply-To: <147365.85546.qm@web92009.mail.cnb.yahoo.com>
References: <147365.85546.qm@web92009.mail.cnb.yahoo.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "diak sim" <sim.diak@yahoo.com.cn>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20080110212749.3A4D312A804E@mail170-sin.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


There shouldn't be a significant different in the cores themselves, =
however, there are many ways to get the FPGA design slightly wrong where =
it won't boot, or to get the kernel xparameters file out of synch with =
the FPGA design.  This is most likely your problem.

Steve

> -----Original Message-----
> From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org =
[mailto:linuxppc-embedded-
> bounces+stephen=3Dneuendorffer.name@ozlabs.org] On Behalf Of diak sim
> Sent: Thursday, January 10, 2008 5:56 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: In PowerPC's feature,are there any difference between ML410 =
and ML403?
>=20
> Hello everyone,
>=20
> I am using ML410 to port a Linux 2.6 kernel, but init_IRQ() doesn't =
pass.
> Porting Linux 2.6 to ML403 is successful? No such a problem?
> In PowerPC's feature, are there any difference between ML410 and =
ML403?
>=20
> Thanks.
>=20
>=20
> ________________________________
>=20
> =
=D1=C5=BB=A2=D3=CA=CF=E4=B4=AB=B5=DD=D0=C2=C4=EA=D7=A3=B8=A3=A3=AC=B8=F6=D0=
=D4=BA=D8=BF=A8=CB=CD=C7=D7=C5=F3=A3=A1 =
<http://cn.mail.yahoo.com/gc/index.html?entry=3D5&souce=3Dmail_mailletter=
_tagline>
