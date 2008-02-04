Return-Path: <bgholikh@cisco.com>
Received: from sj-iport-3.cisco.com (sj-iport-3.cisco.com [171.71.176.72])
	by ozlabs.org (Postfix) with ESMTP id F17B1DE046
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Feb 2008 05:15:19 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: build is broken
Date: Mon, 4 Feb 2008 10:15:08 -0800
Message-ID: <F795765B112E7344AF36AA911279641502D1AA2C@xmb-sjc-212.amer.cisco.com>
In-Reply-To: <20080204165144.GB19264@ld0162-tx32.am.freescale.net>
References: <F795765B112E7344AF36AA911279641502D1AA28@xmb-sjc-212.amer.cisco.com>
	<20080204165144.GB19264@ld0162-tx32.am.freescale.net>
From: "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com>
To: "Scott Wood" <scottwood@freescale.com>
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

> -----Original Message-----
> From: Scott Wood [mailto:scottwood@freescale.com]=20
> Sent: Monday, February 04, 2008 8:52 AM
> To: Bizhan Gholikhamseh (bgholikh)
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: build is broken
>=20
> On Fri, Feb 01, 2008 at 03:23:21PM -0800, Bizhan Gholikhamseh=20
> (bgholikh) wrote:
> >   AS      .tmp_kallsyms2.o
> >   LD      vmlinux
> >   SYSMAP  System.map
> >   SYSMAP  .tmp_System.map
> >   BOOTCC  arch/powerpc/boot/treeboot-walnut.o
> > Assembler messages:
> > Error: Internal assembler error for instruction icbt=20
> Internal error,=20
> > aborting at=20
> >=20
> /usr/src/RPM/BUILD/crosstool/source/binutils-2.15/gas/config/tc-ppc.c
> > line 1300 in ppc_setup_opcodes
> > Please report this bug.
>=20
> Try using a newer toolchain.
>=20
> -Scott
>
Thanks Scott,=20
That did it, I upgraded the toolchain to the 4.1 and worked fine.

Thanks again,
Bizhan=20
