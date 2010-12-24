Return-Path: <glikely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Date: Fri, 24 Dec 2010 02:15:45 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 3/3] powerpc: pcm030/032: add pagesize to dts
Message-ID: <20101224091545.GM5544@angua.secretlab.ca>
References: <1289995250-17927-1-git-send-email-w.sang@pengutronix.de>
	<1289995250-17927-4-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289995250-17927-4-git-send-email-w.sang@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 17, 2010 at 01:00:50PM +0100, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>

Applied for -next, thanks.

g.

> ---
>  arch/powerpc/boot/dts/pcm030.dts |    1 +
>  arch/powerpc/boot/dts/pcm032.dts |    3 ++-
>  2 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/pcm030.dts b/arch/powerpc/boot/dts/pcm030.dts
> index 8a4ec30..e7c36bc 100644
> --- a/arch/powerpc/boot/dts/pcm030.dts
> +++ b/arch/powerpc/boot/dts/pcm030.dts
> @@ -259,6 +259,7 @@
>  			eeprom@52 {
>  				compatible = "catalyst,24c32";
>  				reg = <0x52>;
> +				pagesize = <32>;
>  			};
>  		};
>  
> diff --git a/arch/powerpc/boot/dts/pcm032.dts b/arch/powerpc/boot/dts/pcm032.dts
> index 85d857a..e175e2c 100644
> --- a/arch/powerpc/boot/dts/pcm032.dts
> +++ b/arch/powerpc/boot/dts/pcm032.dts
> @@ -257,8 +257,9 @@
>  				reg = <0x51>;
>  			};
>  			eeprom@52 {
> -				compatible = "at24,24c32";
> +				compatible = "catalyst,24c32";
>  				reg = <0x52>;
> +				pagesize = <32>;
>  			};
>  		};
>  
> -- 
> 1.7.2.3
> 
