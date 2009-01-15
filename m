Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 23293474C3
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 08:57:57 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] mmc: Add driver for Freescale eSDHC controllers
Date: Thu, 15 Jan 2009 22:52:31 +0100
References: <20090114194631.GA25978@oksana.dev.rtsoft.ru>
In-Reply-To: <20090114194631.GA25978@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901152252.32480.arnd@arndb.de>
Cc: Joe D'Abbraccio <Joe.D'abbraccio@freescale.com>,
	linux-kernel@vger.kernel.org, Konjin Lai <Konjin.Lai@freescale.com>,
	Xie Xiaobo <X.Xie@freescale.com>, Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 14 January 2009, Anton Vorontsov wrote:
>=20
> +config MMC_ESDHC
> +=A0=A0=A0=A0=A0=A0=A0tristate "Freescale Enhanced SD Host Controller Int=
erface support"
> +=A0=A0=A0=A0=A0=A0=A0depends on FSL_SOC
> +=A0=A0=A0=A0=A0=A0=A0help
> +=A0=A0=A0=A0=A0=A0=A0 =A0This selects the Freescale Enhanced SD Host Con=
troller Interface
> +=A0=A0=A0=A0=A0=A0=A0 =A0as found in some Freescale PowerPC microprocess=
ors.
> +
> +=A0=A0=A0=A0=A0=A0=A0 =A0If unsure, say N.


The naming could be improved, calling it ESDHC instead of ESDHCI is very
confusing: SDHCI is the controller chip while SDHC is a type of card (high
capacity SD). This driver clearly does not refer to the card type but
rather to the controller.

	Arnd <><
