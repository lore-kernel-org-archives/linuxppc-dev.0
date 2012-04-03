Return-Path: <grant.likely@secretlab.ca>
Received: from mail-pz0-f42.google.com (mail-pz0-f42.google.com
 [209.85.210.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 01669B6FBC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2012 09:01:39 +1000 (EST)
Received: by mail-pz0-f42.google.com with SMTP id g27so245598dan.15
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Apr 2012 16:01:39 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/5] powerpc: dts: klondike: Add UART nodes
To: Tanmay Inamdar <tinamdar@apm.com>, benh@kernel.crashing.org,
 jwboyer@gmail.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 devicetree-discuss@lists.ozlabs.org
In-Reply-To: <1333348747-12713-3-git-send-email-tinamdar@apm.com>
References: <1333348747-12713-1-git-send-email-tinamdar@apm.com>
 <1333348747-12713-2-git-send-email-tinamdar@apm.com>
 <1333348747-12713-3-git-send-email-tinamdar@apm.com>
Date: Tue, 03 Apr 2012 09:57:03 -0600
Message-Id: <20120403155703.3B0593E053F@localhost>
Cc: Tanmay Inamdar <tinamdar@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon,  2 Apr 2012 12:09:05 +0530, Tanmay Inamdar <tinamdar@apm.com> wrote:
> Adding UART nodes in Klondike device tree file.
> 
> Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
> ---
> :100644 100644 4ff2852... d5bf2e1... M	arch/powerpc/boot/dts/klondike.dts
>  arch/powerpc/boot/dts/klondike.dts |   24 ++++++++++++++++++++++++
>  1 files changed, 24 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/klondike.dts b/arch/powerpc/boot/dts/klondike.dts
> index 4ff2852..d5bf2e1 100644
> --- a/arch/powerpc/boot/dts/klondike.dts
> +++ b/arch/powerpc/boot/dts/klondike.dts
> @@ -222,6 +222,30 @@
>  				#size-cells = <1>;
>  				ranges;
>  				clock-frequency = <0>;
> +
> +				UART0: serial@50001000 {
> +				       device_type = "serial";
> +				       compatible = "ns16550";
> +				       reg = <0x50001000 0x00000100>;
> +				       virtual-reg = <0x50001000>;

Why do you need virtual-reg?  The kernel should handle all iomapping
properly without this.

g.
