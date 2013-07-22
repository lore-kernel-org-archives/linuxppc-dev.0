Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 77DF82C15C3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jul 2013 22:33:30 +1000 (EST)
Date: Mon, 22 Jul 2013 14:33:24 +0200
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 00/31] add COMMON_CLK support for PowerPC MPC512x
Message-ID: <20130722123324.GE19071@book.gsilab.sittig.org>
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374495298-22019-1-git-send-email-gsi@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1374495298-22019-1-git-send-email-gsi@denx.de>
Cc: Detlev Zundel <dzu@denx.de>, Wolfram Sang <wsa@the-dreams.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>, David Woodhouse <dwmw2@infradead.org>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[ manually added devicetree at vger now ]

On Mon, Jul 22, 2013 at 14:14 +0200, Gerhard Sittig wrote:
> 
> this series
> - fixes several drivers that are used in the MPC512x platform (UART,
>   SPI, ethernet, PCI, USB, CAN, NAND flash, video capture) in how they
>   handle clocks (appropriately acquire and setup them, hold references
>   during use, release clocks after use)
> - introduces support for the common clock framework (CCF, COMMON_CLK
>   Kconfig option) in the PowerPC based MPC512x platform, which brings
>   device tree based clock lookup as well

Haven't noticed before that the ozlabs device tree list started
actively rejecting reception.  And the scope of the series has
widened to include clock related fixes in many more drivers while
the initial submission only introduced CCF for MPC512x.

Shall I resend (with vger devicetree included and more subsystems
lists added)?  Which other lists to include without spamming too
many channels?  Poor moderators have to ACK messages for lists
that I'm not subscribed to.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
