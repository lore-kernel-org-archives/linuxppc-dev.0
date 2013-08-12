Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id DF8452C0133
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Aug 2013 04:27:43 +1000 (EST)
Date: Mon, 12 Aug 2013 11:27:42 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v4 21/31] serial: mpc512x: switch to CCF names in clock
 lookup
Message-ID: <20130812182742.GB20233@kroah.com>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
 <1375821851-31609-22-git-send-email-gsi@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1375821851-31609-22-git-send-email-gsi@denx.de>
Cc: devicetree@vger.kernel.org, Mike Turquette <mturquette@linaro.org>,
 Detlev Zundel <dzu@denx.de>, Wolfram Sang <wsa@the-dreams.de>,
 David Woodhouse <dwmw2@infradead.org>, Rob Herring <rob.herring@calxeda.com>,
 Mark Brown <broonie@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
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

On Tue, Aug 06, 2013 at 10:44:01PM +0200, Gerhard Sittig wrote:
> after device tree based clock lookup became available, the peripheral
> driver need no longer construct clock names which include the PSC index,
> remove the "psc%d_mclk" template and unconditionally use 'mclk'
> 
> acquire and release the 'ipg' clock for register access as well
> 
> Signed-off-by: Gerhard Sittig <gsi@denx.de>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
