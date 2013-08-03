Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 541A22C0091
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Aug 2013 00:20:01 +1000 (EST)
Date: Sat, 3 Aug 2013 16:19:54 +0200
From: Gerhard Sittig <gsi@denx.de>
To: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v3 15/31] dts: mpc512x: introduce dt-bindings/clock/ header
Message-ID: <20130803141954.GG2580@book.gsilab.sittig.org>
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1374495298-22019-16-git-send-email-gsi@denx.de>
 <20130802224308.6450.55171@quantum>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130802224308.6450.55171@quantum>
Cc: devicetree@vger.kernel.org, Detlev Zundel <dzu@denx.de>,
 Wolfram Sang <wsa@the-dreams.de>, David Woodhouse <dwmw2@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Wolfgang Grandegger <wg@grandegger.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 02, 2013 at 15:43 -0700, Mike Turquette wrote:
> 
> Quoting Gerhard Sittig (2013-07-22 05:14:42)
> > introduce a dt-bindings/ header file for MPC512x clocks,
> > providing symbolic identifiers for those SoC clocks which
> > clients will reference from their device tree nodes
> > 
> > Signed-off-by: Gerhard Sittig <gsi@denx.de>
> > ---
> >  include/dt-bindings/clock/mpc512x-clock.h |   59 +++++++++++++++++++++++++++++
> >  1 file changed, 59 insertions(+)
> >  create mode 100644 include/dt-bindings/clock/mpc512x-clock.h
> > 
> > diff --git a/include/dt-bindings/clock/mpc512x-clock.h b/include/dt-bindings/clock/mpc512x-clock.h
> > new file mode 100644
> > index 0000000..46c560e
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/mpc512x-clock.h
> > @@ -0,0 +1,59 @@
> > +/*
> > + * This header provides constants for MPC512x clock specs in DT bindings.
> > + *
> > + * Unfortunately the clock number declaration cannot be an enum but
> > + * needs to be a list of #define directives since when referenced from
> > + * within DTS files they need to get resolved "at compile time".
> 
> Above comment is not really necessary. Otherwise,
> 
> Reviewed-by: Mike Turquette <mturquette@linaro.org>

OK, the next update of the series will remove this comment.


> > + */
> > +
> > +#ifndef _DT_BINDINGS_CLOCK_MPC512x_CLOCK_H
> > +#define _DT_BINDINGS_CLOCK_MPC512x_CLOCK_H
> > +
> > +#define MPC512x_CLK_DUMMY              0
> > +#define MPC512x_CLK_REF                        1
> > +#define MPC512x_CLK_SYS                        2
> > +#define MPC512x_CLK_DIU                        3
> > +#define MPC512x_CLK_VIU                        4
> > +#define MPC512x_CLK_CSB                        5
> > +#define MPC512x_CLK_E300               6
> > +#define MPC512x_CLK_IPS                        7
> > +#define MPC512x_CLK_FEC                        8
> > +#define MPC512x_CLK_SATA               9
> > +#define MPC512x_CLK_PATA               10
> > +#define MPC512x_CLK_NFC                        11
> > +#define MPC512x_CLK_LPC                        12
> > +#define MPC512x_CLK_MBX_BUS            13
> > +#define MPC512x_CLK_MBX                        14
> > +#define MPC512x_CLK_MBX_3D             15
> > +#define MPC512x_CLK_AXE                        16
> > +#define MPC512x_CLK_USB1               17
> > +#define MPC512x_CLK_USB2               18
> > +#define MPC512x_CLK_I2C                        19
> > +#define MPC512x_CLK_MSCAN0_MCLK                20
> > +#define MPC512x_CLK_MSCAN1_MCLK                21
> > +#define MPC512x_CLK_MSCAN2_MCLK                22
> > +#define MPC512x_CLK_MSCAN3_MCLK                23
> > +#define MPC512x_CLK_SDHC               24
> > +#define MPC512x_CLK_PCI                        25
> > +#define MPC512x_CLK_PSC_MCLK_IN                26
> > +#define MPC512x_CLK_SPDIF_TX           27
> > +#define MPC512x_CLK_SPDIF_RX           28
> > +#define MPC512x_CLK_SPDIF_MCLK         29
> > +#define MPC512x_CLK_AC97               30
> > +#define MPC512x_CLK_PSC0_MCLK          31
> > +#define MPC512x_CLK_PSC1_MCLK          32
> > +#define MPC512x_CLK_PSC2_MCLK          33
> > +#define MPC512x_CLK_PSC3_MCLK          34
> > +#define MPC512x_CLK_PSC4_MCLK          35
> > +#define MPC512x_CLK_PSC5_MCLK          36
> > +#define MPC512x_CLK_PSC6_MCLK          37
> > +#define MPC512x_CLK_PSC7_MCLK          38
> > +#define MPC512x_CLK_PSC8_MCLK          39
> > +#define MPC512x_CLK_PSC9_MCLK          40
> > +#define MPC512x_CLK_PSC10_MCLK         41
> > +#define MPC512x_CLK_PSC11_MCLK         42
> > +#define MPC512x_CLK_PSC_FIFO           43
> > +
> > +#define MPC512x_CLK_LAST_PUBLIC                43
> > +
> > +#endif
> > -- 
> > 1.7.10.4


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
