Return-Path: <shawn.guo@linaro.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B077F2C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 May 2013 12:04:04 +1000 (EST)
Date: Fri, 17 May 2013 10:03:52 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: allow compilation on arm and powerpc
Message-ID: <20130517020351.GE3893@S2101-09.ap.freescale.net>
References: <1368711756-22324-1-git-send-email-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1368711756-22324-1-git-send-email-mkl@pengutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Sascha Hauer <s.hauer@pengutronix.de>,
 U Bhaskar-B22300 <B22300@freescale.com>, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Marc,

On Thu, May 16, 2013 at 03:42:36PM +0200, Marc Kleine-Budde wrote:
> This patch removes the Kconfig symbols HAVE_CAN_FLEXCAN and
> IMX_HAVE_PLATFORM_FLEXCAN from arch/{arm,powerpc} and allowing compilation on
> all arm and powerpc platforms.

I'm generally fine with the approach.  But with Kconfig symbol
IMX_HAVE_PLATFORM_FLEXCAN removed, how does the build of
platform-flexcan.o work?

arch/arm/mach-imx/devices/Makefile:obj-$(CONFIG_IMX_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o

Shawn
