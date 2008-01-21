Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 22696DDDFA
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 03:23:09 +1100 (EST)
Date: Mon, 21 Jan 2008 10:20:29 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] 8xx: Analogue & Micro Adder875 board support.
In-Reply-To: <20080117223140.GA17300@loki.buserror.net>
Message-ID: <Pine.LNX.4.64.0801211020120.14453@blarg.am.freescale.net>
References: <20080117223140.GA17300@loki.buserror.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 17 Jan 2008, Scott Wood wrote:

> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> Removed const/initdata combo, added simple-bus to cpm node,
> and used simple-bus for probing.
>
> Please apply for 2.6.25.
>
>  arch/powerpc/Kconfig                            |    3 +
>  arch/powerpc/boot/.gitignore                    |    1 +
>  arch/powerpc/boot/Makefile                      |    6 +-
>  arch/powerpc/boot/dts/adder875-redboot.dts      |  184 ++++++
>  arch/powerpc/boot/dts/adder875-uboot.dts        |  183 ++++++
>  arch/powerpc/boot/redboot-8xx.c                 |   58 ++
>  arch/powerpc/boot/redboot.h                     |   56 ++
>  arch/powerpc/boot/wrapper                       |    2 +-
>  arch/powerpc/configs/adder875-redboot_defconfig |  798 +++++++++++++++++++++++
>  arch/powerpc/configs/adder875-uboot_defconfig   |  798 +++++++++++++++++++++++
>  arch/powerpc/platforms/8xx/Kconfig              |    9 +
>  arch/powerpc/platforms/8xx/Makefile             |    1 +
>  arch/powerpc/platforms/8xx/adder875.c           |  118 ++++
>  13 files changed, 2215 insertions(+), 2 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/adder875-redboot.dts
>  create mode 100644 arch/powerpc/boot/dts/adder875-uboot.dts
>  create mode 100644 arch/powerpc/boot/redboot-8xx.c
>  create mode 100644 arch/powerpc/boot/redboot.h
>  create mode 100644 arch/powerpc/configs/adder875-redboot_defconfig
>  create mode 100644 arch/powerpc/configs/adder875-uboot_defconfig
>  create mode 100644 arch/powerpc/platforms/8xx/adder875.c
>

applied.

- k
