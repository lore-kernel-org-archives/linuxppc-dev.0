Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EE46EDE2D1
	for <linuxppc-dev@ozlabs.org>; Fri, 30 May 2008 01:52:50 +1000 (EST)
Date: Thu, 29 May 2008 17:52:26 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCHv2] i2c: adds support for i2c bus on Freescale CPM1/CPM2
	controllers
Message-ID: <20080529175226.273f9d49@hyperion.delvare>
In-Reply-To: <4834504E.6060205@scram.de>
References: <4834504E.6060205@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Wolfram Sang <w.sang@pengutronix.de>, "Kernel,
	Linux" <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linux I2C <i2c@lm-sensors.org>, Scott Wood <scottwood@freescale.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Boris Shteinbock <bshtein@yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 21 May 2008 18:39:42 +0200, Jochen Friedrich wrote:
> This driver uses the port of 2.4 code from Vitaly Bordug
> <vitb@kernel.crashing.org> and the actual algorithm used by the i2c
> driver of the DBox code on cvs.tuxboc.org from Felix Domke
> (tmbinc@gmx.net) and Gillem (htoa@gmx.net) converted to an
> of_platform_driver. Tested on CPM1 (MPC823 on dbox2 hardware) and
> CPM2 (MPC8272).
> 
> Signed-off-by: Jochen Friedrich <jochen@scram.de>
> ---
>  drivers/i2c/busses/Kconfig   |   10 +
>  drivers/i2c/busses/Makefile  |    1 +
>  drivers/i2c/busses/i2c-cpm.c |  745 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 756 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/i2c/busses/i2c-cpm.c
> 
> Changes since last version:
> - change bus-frequency -> clock-frequency to comply to OF standard.
> 

Applied, thanks. And thanks a lot to Wolfram for the review :)

-- 
Jean Delvare
