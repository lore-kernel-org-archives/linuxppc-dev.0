Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id C938F67A77
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Mar 2005 08:39:33 +1100 (EST)
In-Reply-To: <422C30CF.5010906@anagramm.de>
References: <422C30CF.5010906@anagramm.de>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <05a5deac85b4c2e53abeec11bf816bbe@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 7 Mar 2005 15:39:28 -0600
To: "Clemens Koller" <clemens.koller@anagramm.de>
Cc: ppcembed Mailing List <linuxppc-embedded@ozlabs.org>
Subject: Re: gcc-3.3.3 from YDL4 problems?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks,

The problem I'm having is that it builds fine, when running it fails.

- kumar

On Mar 7, 2005, at 4:45 AM, Clemens Koller wrote:

> Hello, Kumar!
>
> > Has anyone else had any issues with building kernels (2.6.11) with
> > gcc-3.3.3 from YDL4.=A0 Ran into a problem today were a 2.6.11 build=20=

> for
> > MPC8540 ADS breaks with gcc-3.3.3 but works ok with a 3.4.3.
>
> You know that I build the mpc8540_ads also.
>  I use the Denx ELDK 3.1 with gcc 3.3.3 and it breaks due to an =
unknown
> rfci instruction:
>
> $ make
>  =A0=A0 CHK=A0=A0=A0=A0 include/linux/version.h
> =A0=A0 CC=A0=A0=A0=A0=A0 scripts/mod/empty.o
> =A0=A0 MKELF=A0=A0 scripts/mod/elfconfig.h
> =A0=A0 HOSTCC=A0 scripts/mod/file2alias.o
> =A0=A0 HOSTCC=A0 scripts/mod/modpost.o
> =A0=A0 HOSTCC=A0 scripts/mod/sumversion.o
> =A0=A0 HOSTLD=A0 scripts/mod/modpost
> =A0=A0 CC=A0=A0=A0=A0=A0 arch/ppc/kernel/asm-offsets.s
>  =A0=A0 CHK=A0=A0=A0=A0 include/asm-ppc/offsets.h
>  =A0=A0 CC=A0=A0=A0=A0=A0 init/main.o
>  =A0=A0 CHK=A0=A0=A0=A0 include/linux/compile.h
> =A0=A0 UPD=A0=A0=A0=A0 include/linux/compile.h
> =A0=A0 CC=A0=A0=A0=A0=A0 init/version.o
>  =A0=A0 CC=A0=A0=A0=A0=A0 init/do_mounts.o
> =A0=A0 CC=A0=A0=A0=A0=A0 init/do_mounts_devfs.o
> =A0=A0 CC=A0=A0=A0=A0=A0 init/do_mounts_rd.o
> =A0=A0 CC=A0=A0=A0=A0=A0 init/do_mounts_initrd.o
> =A0=A0 LD=A0=A0=A0=A0=A0 init/mounts.o
>  =A0=A0 CC=A0=A0=A0=A0=A0 init/initramfs.o
>  =A0=A0 CC=A0=A0=A0=A0=A0 init/calibrate.o
>  =A0=A0 LD=A0=A0=A0=A0=A0 init/built-in.o
>  =A0=A0 CHK=A0=A0=A0=A0 usr/initramfs_list
> =A0=A0 AS=A0=A0=A0=A0=A0 usr/initramfs_data.o
> =A0=A0 LD=A0=A0=A0=A0=A0 usr/built-in.o
>  =A0=A0 AS=A0=A0=A0=A0=A0 arch/ppc/kernel/entry.o
> arch/ppc/kernel/entry.S: Assembler messages:
>  arch/ppc/kernel/entry.S:800: Error: Unrecognized opcode: `rfci'
>  make[1]: *** [arch/ppc/kernel/entry.o] Error 1
>  make: *** [arch/ppc/kernel] Error 2
>
> But if I use your powerpc-linux-gnuspe-* (cross-)toolchain it
>  builds fine. Maybe some compile options for 3.3.3 might be sufficient
>  to fix that... my way is to use 3.4.3.
>
> Best greets,
>
> Clemens Koller
> _______________________________
> R&D Imaging Devices
>  Anagramm GmbH
>  Rupert-Mayer-Str. 45/1
>  81379 Muenchen
>  Germany
>
> http://www.anagramm.de
> Phone: +49-89-741518-50
>  Fax: +49-89-741518-19
