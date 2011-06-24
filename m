Return-Path: <lethal@linux-sh.org>
Received: from linux-sh.org (linux-sh.org [111.68.239.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6D07FB6F85
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Jun 2011 18:59:45 +1000 (EST)
Date: Fri, 24 Jun 2011 17:10:03 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] fsl-diu-fb: remove check for pixel clock ranges
Message-ID: <20110624081003.GE24184@linux-sh.org>
References: <1308860426-17920-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308860426-17920-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-fbdev@vger.kernel.org, agust@denx.de,
	yorksun@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 23, 2011 at 03:20:26PM -0500, Timur Tabi wrote:
> The Freescale DIU framebuffer driver defines two constants, MIN_PIX_CLK and
> MAX_PIX_CLK, that are supposed to represent the lower and upper limits of
> the pixel clock.  These values, however, are true only for one platform
> clock rate (533MHz) and only for the MPC8610.  So the actual range for
> the pixel clock is chip-specific, which means the current values are almost
> always wrong.  The chance of an out-of-range pixel clock being used are also
> remote.
> 
> Rather than try to detect an out-of-range clock in the DIU driver, we depend
> on the board-specific pixel clock function (e.g. p1022ds_set_pixel_clock)
> to clamp the pixel clock to a supported value.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

Applied, thanks.
