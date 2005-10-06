Return-Path: <jgeissel@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 2624868420
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Oct 2005 17:32:04 +1000 (EST)
From: Johannes Geissel <jgeissel@gmx.net>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 6 Oct 2005 07:57:44 +0200
References: <OFAF025B3B.4E7DEDE8-ON48257092.0018E543@uk.marconicomms.com>
In-Reply-To: <OFAF025B3B.4E7DEDE8-ON48257092.0018E543@uk.marconicomms.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200510060757.44884.jgeissel@gmx.net>
Subject: Re: kernel.org's kernel: building and root file system
Reply-To: jgeissel@gmx.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Am Donnerstag, 6. Oktober 2005 06:53 schrieb KokHow Teh:
> Hi;
>       I am new to this and I have some questions of "what's next?" after
> having downloaded the latest kernel from kernel.org:
>
> (1)   Since I am going to build the kernel for PPC platform and
> architecture, running `make xconfig` won't bring up the right set of
> configurations for your target but the default which is a generic X86
> architecture and platform. What is the usual step so that I will have the
> configuration set for my target? I think of 2:
>
>       (i) copy arch/ppc/configs/<foo>_defconfig to $SRC_BASE/.config; `make
> xconfig`
Don't copy anything, just do a make <foo>_config. Before that you have 
to do export CROSS_COMPILE=ppc_xxx-

>       (ii) `make xconfig`; and inside the X-window, open the
> arch/ppc/configs/<foo>_defconfig and save it for your architecture.
>
>       I tried (ii) but after having opened the <foo>_defconfig, it is not
> reflected at all in the X-window. It is still showing the default
> configurations.
>
> (2)   Ok, you have the kernel running on your PPC target. How about the
> root file system? Where and how can I have/build a generic root file system
> that works with kernels running from kernel.org?
>
> (3)   Toolchain. What cross-toolchain is generally used to build the kernel
> for your target? For PPC, I come across this
> http://penguinppc.org/dev/crosstool.php... Is that popularly used to build
> kernel from kernel.org for PPC architecture and platform?
I'm using ELDK from www.denx.de and also a linuxppc_2_4_devel kernel
from there.

>
>       Thanks for any comment and insight.
>
> Regards,
> TEH
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
