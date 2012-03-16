Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C2D28B6EE7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 03:20:56 +1100 (EST)
Subject: Re: [PATCH v3 4/4] powerpc: Board support for GE IMP3A
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1331572380-1064-5-git-send-email-martyn.welch@ge.com>
Date: Fri, 16 Mar 2012 11:14:00 -0500
Message-Id: <613D20C2-EBE3-435C-89F0-8C858A344DED@kernel.crashing.org>
References: <1331572380-1064-1-git-send-email-martyn.welch@ge.com>
 <1331572380-1064-5-git-send-email-martyn.welch@ge.com>
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


On Mar 12, 2012, at 12:13 PM, Martyn Welch wrote:

> Initial board support for the GE IMP3A, a 3U compactPCI card with a =
p2020
> processor.
>=20
> Signed-off-by: Martyn Welch <martyn.welch@ge.com>
> ---
>=20
> v2: Rebase patch onto powerpc/next, taking work by Kyle Moffett into
>    account.
>=20
> v3: Correct detection of interrupt controller.
>=20
> arch/powerpc/boot/dts/ge_imp3a.dts      |  255 =
++++++++++++++++++++++++++++++
> arch/powerpc/configs/ge_imp3a_defconfig |  257 =
+++++++++++++++++++++++++++++++
> arch/powerpc/platforms/85xx/Kconfig     |   15 ++
> arch/powerpc/platforms/85xx/Makefile    |    1 +
> arch/powerpc/platforms/85xx/ge_imp3a.c  |  246 =
+++++++++++++++++++++++++++++
> drivers/gpio/gpio-ge.c                  |   28 ++++
> 6 files changed, 802 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/ge_imp3a.dts
> create mode 100644 arch/powerpc/configs/ge_imp3a_defconfig
> create mode 100644 arch/powerpc/platforms/85xx/ge_imp3a.c

applied, moved defconfig to configs/85xx/

- k=
