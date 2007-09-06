Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound6-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0A1D1DDF2E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Sep 2007 04:40:58 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Newbie on embedded linux on PPC: error: cannot find boot.o
Date: Thu, 6 Sep 2007 11:39:45 -0700
In-Reply-To: <20070904213339.D3DB7788046@mail56-fra.bigfish.com>
References: <46DD65BF.5090304@kip.uni-heidelberg.de>
	<20070904213339.D3DB7788046@mail56-fra.bigfish.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Thomas Gerlach" <gerlach@kip.uni-heidelberg.de>
Message-Id: <20070906183821.76198151807F@mail192-dub.bigfish.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

=20
You can also build a ppc405 toolchain using Crosstool, and it works
fine..
http://kegel.com/crosstool

Steve

> -----Original Message-----
> From:=20
> linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
> =20
> [mailto:linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@oz
labs.org] On Behalf Of Wolfgang Reissnegger
> Sent: Tuesday, September 04, 2007 2:33 PM
> To: Thomas Gerlach
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: Newbie on embedded linux on PPC: error: cannot=20
> find boot.o
>=20
> Hi Thomas,
>=20
> Xilinx is building the tools in the EDK to work with VxWorks=20
> and for Standalone systems. In order to compile a Linux=20
> kernel you need to get a toolchain from one of the Third=20
> Party vendors, such as MontaVista. They have the correct=20
> linker scripts for building a kernel.
>=20
> Cheers,
>    Wolfgang
>=20
> Thomas Gerlach wrote:
> > hi folks,
> >=20
> >=20
> > my name is thomas trying to make embedded linux run on a=20
> powerpc, but
> > we've got special boards here, although we use a xilinx virtex4
> > fpga...
> >=20
> > as you said in the nabble-thread (see subject), i set up edk9.1
> > software platform settings und ran libgen to get the xparameters*
> > files. i copied those bsp files into the kernel tree (i use your
> > kernel linux-2.6-virtex from git.secretlabs.ca/git). after
> > configuring the kernel settigs, i try
> >=20
> > $ make ARCH=3Dppc CROSS_COMPILE=3Dpowerpc-eabi-
> >=20
> > what i get is the following output:
> >=20
> >>   CHK     include/linux/version.h
> >>   CHK     include/linux/utsrelease.h
> >>   CALL    scripts/checksyscalls.sh
> >>   CHK     include/linux/compile.h
> >>   LD      init/mounts.o
> >> powerpc-eabi-ld: cannot find boot.o
> >> make[1]: *** [init/mounts.o] Error 1
> >> make: *** [init] Error 2
> >=20
> > so, i searched for boot.o (it exists) and even copied it=20
> into several
> > dirs of the linux kernel tree (where i thought i would make sense),
> > but the problem still remains.
> >=20
> > googling results in
> >=20
> >=20
> http://www.xilinx.com/xlnx/xil_ans_display.jsp?iLanguageID=3D1&g
etPagePath=3D17462&BV_SessionID=3D@@@@1197140711.1188909240>
@@@@&BV_EngineID=3Dcccgaddllgmfkflcefeceihdffhdfkf.0
> >=20
> >=20
> > and this, too, doesn't take me further in solving the problem.
> >=20
> > i hope you can help me.
> >=20
> > many thanks in advance,
> >=20
> > kind regards
> > thomas gerlach
> >=20
> >=20
> >=20
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >=20
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20
