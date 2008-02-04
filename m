Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 469CADDE2C
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Feb 2008 03:52:24 +1100 (EST)
Date: Mon, 4 Feb 2008 10:51:44 -0600
From: Scott Wood <scottwood@freescale.com>
To: "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com>
Subject: Re: build is broken
Message-ID: <20080204165144.GB19264@ld0162-tx32.am.freescale.net>
References: <F795765B112E7344AF36AA911279641502D1AA28@xmb-sjc-212.amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F795765B112E7344AF36AA911279641502D1AA28@xmb-sjc-212.amer.cisco.com>
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

On Fri, Feb 01, 2008 at 03:23:21PM -0800, Bizhan Gholikhamseh (bgholikh) wrote:
>   AS      .tmp_kallsyms2.o
>   LD      vmlinux
>   SYSMAP  System.map
>   SYSMAP  .tmp_System.map
>   BOOTCC  arch/powerpc/boot/treeboot-walnut.o
> Assembler messages:
> Error: Internal assembler error for instruction icbt
> Internal error, aborting at
> /usr/src/RPM/BUILD/crosstool/source/binutils-2.15/gas/config/tc-ppc.c
> line 1300 in ppc_setup_opcodes
> Please report this bug.

Try using a newer toolchain.

-Scott
