Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id E7629B7C98
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2010 02:21:45 +1100 (EST)
Received: by gyf1 with SMTP id 1so725263gyf.15
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Feb 2010 07:21:43 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <fa686aa41002172237l1d3976avc7f88fd38755ca5e@mail.gmail.com>
References: <fa686aa41002172237l1d3976avc7f88fd38755ca5e@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 24 Feb 2010 08:21:22 -0700
Message-ID: <fa686aa41002240721s43755142ma702692aa61b8941@mail.gmail.com>
Subject: Re: Please pull mpc5xxx support for -next
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ernst Schwab <eschwab@online.de>, Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

Just sending a reminder on this pull request.  I haven't seen these
commits show up in your -next branch yet.

Thanks,
g.

On Wed, Feb 17, 2010 at 11:37 PM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> Hi Ben,
>
> Here's all the stuff I've got queued up for 2.6.34. =A0Mostly mpc5121
> support, but some 5200 stuff too. =A0These commits have already had some
> time in linux-next.
>
> Cheers,
> g.
>
> The following changes since commit 724e6d3fe8003c3f60bf404bf22e4e331327c5=
96:
> =A0Linus Torvalds (1):
> =A0 =A0 =A0 =A0Linux 2.6.33-rc8
>
> are available in the git repository at:
>
> =A0git://git.secretlab.ca/git/linux-2.6.git next
>
> Anatolij Gustschin (10):
> =A0 =A0 =A0powerpc/mpc5121: avoid using arch_initcall for clock init
> =A0 =A0 =A0powerpc/mpc5121: Add machine restart support
> =A0 =A0 =A0rtc: Add MPC5121 Real time clock driver
> =A0 =A0 =A0powerpc/mpc5121: create and register NFC device
> =A0 =A0 =A0powerpc/mpc5121: update mpc5121ads DTS
> =A0 =A0 =A0powerpc/mpc5121: Add default config for MPC5121
> =A0 =A0 =A0serial: mpc52xx_uart: re-enable mpc5121 PSC UART support
> =A0 =A0 =A0powerpc: doc/dts-bindings: document mpc5121 psc uart dts-bindi=
ngs
> =A0 =A0 =A0powerpc/mpc5121: enable support for more PSC UARTs
> =A0 =A0 =A0powerpc/mpc5121: correct DIU compatible property
>
> Ernst Schwab (1):
> =A0 =A0 =A0powerpc/of: added documentation for spi chipselects
>
> =A0.../powerpc/dts-bindings/fsl/mpc5121-psc.txt =A0 =A0 =A0 | =A0 70 +
> =A0Documentation/powerpc/dts-bindings/fsl/spi.txt =A0 =A0 | =A0 =A07 +
> =A0arch/powerpc/boot/dts/mpc5121ads.dts =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 55 +-
> =A0arch/powerpc/configs/mpc512x_defconfig =A0 =A0 =A0 =A0 =A0 =A0 | 1694 =
++++++++++++++++++++
> =A0arch/powerpc/include/asm/mpc5121.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 24 +
> =A0arch/powerpc/include/asm/mpc52xx_psc.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A04 +
> =A0arch/powerpc/platforms/512x/clock.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A06 +-
> =A0arch/powerpc/platforms/512x/mpc5121_ads.c =A0 =A0 =A0 =A0 =A0| =A0 =A0=
3 +-
> =A0arch/powerpc/platforms/512x/mpc5121_generic.c =A0 =A0 =A0| =A0 =A03 +-
> =A0arch/powerpc/platforms/512x/mpc512x.h =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A03 +
> =A0arch/powerpc/platforms/512x/mpc512x_shared.c =A0 =A0 =A0 | =A0 43 +
> =A0drivers/rtc/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0| =A0 10 +
> =A0drivers/rtc/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 | =A0 =A01 +
> =A0drivers/rtc/rtc-mpc5121.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0387 +++++
> =A0drivers/serial/mpc52xx_uart.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0251 +++-
> =A0drivers/video/fsl-diu-fb.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A05 +
> =A016 files changed, 2522 insertions(+), 44 deletions(-)
> =A0create mode 100644 Documentation/powerpc/dts-bindings/fsl/mpc5121-psc.=
txt
> =A0create mode 100644 arch/powerpc/configs/mpc512x_defconfig
> =A0create mode 100644 arch/powerpc/include/asm/mpc5121.h
> =A0create mode 100644 drivers/rtc/rtc-mpc5121.c
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
