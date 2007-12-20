Return-Path: <david-b@pacbell.net>
Received: from smtp123.sbc.mail.sp1.yahoo.com (smtp123.sbc.mail.sp1.yahoo.com
	[69.147.64.96]) by ozlabs.org (Postfix) with SMTP id C35A9DDDEA
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 10:04:57 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: spi-devel-general@lists.sourceforge.net
Subject: Re: [spi-devel-general] [PATCH v2 3/4] [POWERPC][SPI] use
	brg-frequency for SPI in QE
Date: Thu, 20 Dec 2007 15:04:54 -0800
References: <20071220202714.GA18471@localhost.localdomain>
	<20071220203322.GC19553@localhost.localdomain>
In-Reply-To: <20071220203322.GC19553@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712201504.54836.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 20 December 2007, Anton Vorontsov wrote:
> In case of QE we can use brg-frequency (which is qeclk/2).
> Thus no need to divide sysclk in the spi_mpc83xx.
> 
> This patch also adds code to use get_brgfreq() on QE chips.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  arch/powerpc/sysdev/fsl_soc.c |   37 ++++++++++++++++++++++++-------------
>  drivers/spi/spi_mpc83xx.c     |    6 +-----
>  2 files changed, 25 insertions(+), 18 deletions(-)

For the SPI parts:

Acked-by: David Brownell <dbrownell@users.sourceforge.net>

Though it all looks a bit confusing to me, and I wonder
if the OF docs would make it less so.
