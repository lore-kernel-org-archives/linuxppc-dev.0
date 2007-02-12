Return-Path: <claus.gindhart@kontron.com>
Received: from mail.kontron-modular.com (mail.kontron-modular.com
	[62.159.155.200]) by ozlabs.org (Postfix) with ESMTP id 62876DDDE7
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Feb 2007 18:19:13 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: can crosstool cross-compile Any kernel or specific one ?
Date: Mon, 12 Feb 2007 08:06:46 +0100
Message-ID: <DADA32856852FC458E0F96B664A6F55E011E290F@kom-mailsrv1.kontron-modular.com>
From: "Claus Gindhart" <claus.gindhart@kontron.com>
To: "patel nirav" <indianirav@yahoo.com>,
	"linux ppc" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Niral,

Yes !
look into the Kernel Makefile, and you will recognize, that its already =
prepared for Cross-Compiling.

Just create a small script, which exports the variable CROSS_COMPILE and =
ARCH, e.g.
------------8-<------------
export =
CROSS_COMPILE=3D/opt/crosstool/powerpc-e300-linux-gnu/gcc-3.4.1-glibc-2.3=
.3/bin/powerpc-e300-linux-gnu-
export ARCH=3Dppc
------------8-<------------
After sourcing this script, you can use all the kernel Make-features for =
your cross-compile environment.

Additionally, you might want to export INSTALL_PATH and =
INSTALL_MOD_PATH, which defines, where Kernel image and modules should =
be installed.

--=20
Mit freundlichen Gruessen / Best regards

Claus Gindhart
Kontron Modular Computers GmbH
Sudetenstra=DFe 7, 87600 Kaufbeuren, Germany
Phone: +49 (8341) 803 374
Fax: +49 (8341) 803 40 374
www.kontron.com
=20
Kontron Modular Computers GmbH
Gesch=E4ftsf=FChrer: Ulrich Gehrmann, Thomas Sabisch=20
Sitz der Gesellschaft: Kaufbeuren / Rechtsform: GmbH=20
Amtsgericht Kempten / HRB Nr. 6195
=20
Kontron Modular Computers GmbH
Managing Directors: Ulrich Gehrmann, Thomas Sabisch=20
Registered Office: Kaufbeuren, Germany / Legal Form: GmbH
Local District Court: Kempten / Trade Register No. 6195=20




-----Original Message-----
From: linuxppc-embedded-bounces+claus.gindhart=3Dkontron.com@ozlabs.org =
[mailto:linuxppc-embedded-bounces+claus.gindhart=3Dkontron.com@ozlabs.org=
]On Behalf Of patel nirav
Sent: Montag, 12. Februar 2007 07:51
To: linux ppc
Subject: can crosstool cross-compile Any kernel or specific one ?


I have installed crosstool from kegel.com in /opt/crosstool dictionary.

Now here my question is
" Can I cross compile any kernel from this cross tool or any specific =
kernel " ?



Nirav J Patel
M.Tech(CSE),
Nirma University,
Ahmedabad-382481.
9925138959


Don't pick lemons.
See all the new 2007 cars at Yahoo! Autos.
