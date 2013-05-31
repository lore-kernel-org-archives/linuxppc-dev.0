Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 223032C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Jun 2013 09:41:11 +1000 (EST)
Message-ID: <1370043630.3928.166.camel@pasglop>
Subject: Re: [PATCH v2] can: flexcan: remove HAVE_CAN_FLEXCAN Kconfig symbol
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 01 Jun 2013 09:40:30 +1000
In-Reply-To: <519A4A00.8000109@pengutronix.de>
References: <1368781157-4646-1-git-send-email-mkl@pengutronix.de>
 <20130517090949.GI8607@S2101-09.ap.freescale.net>
 <519A4A00.8000109@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Arnd Bergmann <arnd@arndb.de>, Sascha Hauer <s.hauer@pengutronix.de>,
 U Bhaskar-B22300 <B22300@freescale.com>, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-05-20 at 18:06 +0200, Marc Kleine-Budde wrote:
> On 05/17/2013 11:09 AM, Shawn Guo wrote:
> > On Fri, May 17, 2013 at 10:59:17AM +0200, Marc Kleine-Budde wrote:
> >> This patch removes the Kconfig symbol HAVE_CAN_FLEXCAN from arch/{arm,powerpc}
> >> and allowing compilation unconditionally on all arm and powerpc platforms.
> >>
> >> This brings a bigger compile time coverage and removes the following dependency
> >> warning found by Arnd Bergmann:
> >>
> >>     warning: (SOC_IMX28 && SOC_IMX25 && SOC_IMX35 && IMX_HAVE_PLATFORM_FLEXCAN &&
> >>         SOC_IMX53 && SOC_IMX6Q) selects HAVE_CAN_FLEXCAN
> >>     which has unmet direct dependencies (NET && CAN && CAN_DEV)
> >>
> >> Cc: Arnd Bergmann <arnd@arndb.de>
> >> Cc: Shawn Guo <shawn.guo@linaro.org>
> > 
> > Acked-by: Shawn Guo <shawn.guo@linaro.org>
> 
> Thanks.
> 
> An Acked-by by the powerpc people would be fine. However, if nobody
> doesn't object, I'm sending this patch via linux-can and net-next upstream.

Sorry, missed it, if it's still out there, add my

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Cheers,
Ben.
