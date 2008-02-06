Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound3-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C180FDDF58
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Feb 2008 06:08:36 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [Virtex4] kernel2.6 or distribution
Date: Wed, 6 Feb 2008 11:06:49 -0800
In-Reply-To: <15291528.post@talk.nabble.com>
References: <15291528.post@talk.nabble.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Desroches L." <ludovic.desroches@gmail.com>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20080206190651.73B5A7D004A@mail142-sin.bigfish.com>
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
> From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org =
[mailto:linuxppc-embedded-
> bounces+stephen=3Dneuendorffer.name@ozlabs.org] On Behalf Of Desroches =
L.
> Sent: Tuesday, February 05, 2008 7:49 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: [Virtex4] kernel2.6 or distribution
>=20
>=20
> Hi,
>=20
> Sorry for my English, I am a French student. For my internship, I have =
to
> implement Linux on a Virtex4.
>=20
> I know a few things about the Virtex4 because I am specialized in =
digital
> electronic (VHDL). I have to choose a solution for the Linux to =
implement.
> At this stage, I have some problems to determine the best solution =
probably
> because things are not clear for me whereas I have read a book about =
Linux
> embedded and seen a lot of websites.
>=20
> I have seen several distributions (maybe my vocable is false) from
> MontaVista, LynuxWorks and others. I have seen also kernel2.6 for =
Virtex4
> =
(http://git.xilinx.com/cgi-bin/gitweb.cgi?p=3Dlinux-2.6-xlnx.git;a=3Dsumm=
ary). I
> would like to understand the difference between these two things.

The distributions contain kernel code that is heavily tested and stable, =
in addition to a toolchain, debuggers, rootfilesystem, etc.  =
git.xilinx.com is just the kernel code, without anything else.  =
git.xilinx.com also contains new code that is under development, rather =
than primarily stable code.

> If I have understood MontaVista for example offers a solution with a C
> library and drivers, isn't it ? So is it a better solution than =
kernel2.6 ?

'better' for what?
development of new code? yes, most distributions use older kernels.
building a sytem? Maybe... it depends on what features you need.
learning? Maybe... It depends on what you already know and what you want =
to learn.

> I prefer to start with the kernel given by xilinx, it is an internship =
so
> the aim is to learn the more I can but I have to convince my tutor =
that it
> is a better solution than MontaVista, BlueCat or =B5C/OSII. Do you =
have some
> arguments ?
>=20
> Thanks for your help
>=20
> Best Regards
>=20
> ---
>=20
> Desroches Ludovic
> ESIEE engineer : http://www.esiee.fr
>=20
>=20
> --
> View this message in context: =
http://www.nabble.com/-Virtex4--kernel2.6-or-distribution-
> tp15291528p15291528.html
> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
