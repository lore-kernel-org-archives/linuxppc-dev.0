Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0197DB6FBB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 03:16:12 +1100 (EST)
Subject: Re: [PATCH v3 2/4] gpio: Move GE GPIO driver to reside within GPIO
 subsystem
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1331572380-1064-3-git-send-email-martyn.welch@ge.com>
Date: Fri, 16 Mar 2012 11:13:47 -0500
Message-Id: <EE34B23A-E2D0-4F49-B59A-F52B786E9020@kernel.crashing.org>
References: <1331572380-1064-1-git-send-email-martyn.welch@ge.com>
 <1331572380-1064-3-git-send-email-martyn.welch@ge.com>
To: Martyn Welch <martyn.welch@ge.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 12, 2012, at 12:12 PM, Martyn Welch wrote:

> The GE GPIO driver provides basic support (set direction, read/write =
state)
> for the GPIO provided on some GE single board computers. This patch =
moves
> the driver from the 86xx specific platform directrory to the GPIO =
subsystem
> so that it can be used on non-86xx boards.
>=20
> Signed-off-by: Martyn Welch <martyn.welch@ge.com>
> ---
>=20
> v3: Split out from patch moving PIC and GPIO driver. Moving to gpio =
subsystem
>    instead of sysdev.
>=20
> arch/powerpc/configs/86xx/gef_ppc9a_defconfig      |    1 +
> arch/powerpc/configs/86xx/gef_sbc310_defconfig     |    1 +
> arch/powerpc/configs/86xx/gef_sbc610_defconfig     |    2 ++
> arch/powerpc/platforms/86xx/Makefile               |    3 +--
> drivers/gpio/Kconfig                               |   11 +++++++++++
> drivers/gpio/Makefile                              |    1 +
> .../86xx/gef_gpio.c =3D> drivers/gpio/gpio-ge.c      |    2 +-
> 7 files changed, 18 insertions(+), 3 deletions(-)
> rename arch/powerpc/platforms/86xx/gef_gpio.c =3D> =
drivers/gpio/gpio-ge.c (98%)

applied

- k=
