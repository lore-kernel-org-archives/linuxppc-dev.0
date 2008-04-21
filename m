Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D6E07DDF0A
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 18:41:36 +1000 (EST)
Date: Mon, 21 Apr 2008 10:43:37 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] [POWERPC] mpc5200: Switch mpc5200 dts files to dts-v1
	format
Message-ID: <20080421084337.GB5618@pengutronix.de>
References: <20080418160812.11897.5654.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080418160812.11897.5654.stgit@trillian.secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, m8@semihalf.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 18, 2008 at 09:10:04AM -0700, Grant Likely wrote:
> Update dts files to current format
> 
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> 
>  arch/powerpc/boot/dts/cm5200.dts    |   98 +++++++++++------------
>  arch/powerpc/boot/dts/lite5200.dts  |  132 ++++++++++++++++----------------
>  arch/powerpc/boot/dts/lite5200b.dts |  146 +++++++++++++++++------------------
>  arch/powerpc/boot/dts/motionpro.dts |  118 ++++++++++++++--------------
>  arch/powerpc/boot/dts/tqm5200.dts   |   80 ++++++++++---------
>  5 files changed, 286 insertions(+), 288 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/cm5200.dts b/arch/powerpc/boot/dts/cm5200.dts
> index c6ca631..2f74cc4 100644
> --- a/arch/powerpc/boot/dts/cm5200.dts
> +++ b/arch/powerpc/boot/dts/cm5200.dts
> @@ -10,11 +10,7 @@
>   * option) any later version.
>   */
>  
> -/*
> - * WARNING: Do not depend on this tree layout remaining static just yet.
> - * The MPC5200 device tree conventions are still in flux
> - * Keep an eye on the linuxppc-dev mailing list for more details
> - */
> +/dts-v1/;
>  
>  / {
>  	model = "schindler,cm5200";
> @@ -29,10 +25,10 @@
>  		PowerPC,5200@0 {
>  			device_type = "cpu";
>  			reg = <0>;
> -			d-cache-line-size = <20>;
> -			i-cache-line-size = <20>;
> -			d-cache-size = <4000>;		// L1, 16K
> -			i-cache-size = <4000>;		// L1, 16K
> +			d-cache-line-size = <32>;
> +			i-cache-line-size = <32>;

Has the standard number format changed to decimal lately? Otherwise this
looks wrong. There are more occurences of this in the other dts files.

Sascha

-- 
Pengutronix e.K. - Linux Solutions for Science and Industry
-----------------------------------------------------------
Kontakt-Informationen finden Sie im Header dieser Mail oder
auf der Webseite -> http://www.pengutronix.de/impressum/ <-
