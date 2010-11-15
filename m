Return-Path: <cbouatmailru@gmail.com>
Date: Mon, 15 Nov 2010 20:32:50 +0300
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 2/2] powerpc: pcm030/032: add pagesize to dts
Message-ID: <20101115173250.GA22104@oksana.dev.rtsoft.ru>
References: <1289841916-3825-1-git-send-email-w.sang@pengutronix.de>
	<1289841916-3825-2-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1289841916-3825-2-git-send-email-w.sang@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 15, 2010 at 06:25:16PM +0100, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
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

I think you'd better drop the pagesize property altogether, and
instead make the compatible string more specific (if needed at
all. are there any 'catalyst,24c32' chips with pagesize != 32?)

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
