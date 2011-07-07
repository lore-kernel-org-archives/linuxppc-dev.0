Return-Path: <glikely@secretlab.ca>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A595CB6F6B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  8 Jul 2011 04:42:16 +1000 (EST)
Received: by pzk26 with SMTP id 26so1136188pzk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 07 Jul 2011 11:42:14 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Thu, 7 Jul 2011 12:42:10 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] powerpc/5200: dts: digsy_mtc.dts: enable both MSCAN nodes
Message-ID: <20110707184210.GF2824@ponder.secretlab.ca>
References: <1310042990-21666-1-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310042990-21666-1-git-send-email-agust@denx.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 07, 2011 at 02:49:50PM +0200, Anatolij Gustschin wrote:
> We use both MSCAN controllers on this board, so do not disable
> them in the device tree.
> 
> Signed-off-by: Anatolij Gustschin <agust@denx.de>

Applied, thanks.

g.

> ---
>  arch/powerpc/boot/dts/digsy_mtc.dts |    8 --------
>  1 files changed, 0 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/digsy_mtc.dts b/arch/powerpc/boot/dts/digsy_mtc.dts
> index 2aad7ae..a7511f2 100644
> --- a/arch/powerpc/boot/dts/digsy_mtc.dts
> +++ b/arch/powerpc/boot/dts/digsy_mtc.dts
> @@ -37,14 +37,6 @@
>  			status = "disabled";
>  		};
>  
> -		can@900 {
> -			status = "disabled";
> -		};
> -
> -		can@980 {
> -			status = "disabled";
> -		};
> -
>  		spi@f00 {
>  			msp430@0 {
>  				compatible = "spidev";
> -- 
> 1.7.1
> 
