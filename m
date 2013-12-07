Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A399B2C007B
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Dec 2013 20:34:43 +1100 (EST)
Date: Sat, 7 Dec 2013 10:34:34 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v6 03/17] dts: mpc512x: add clock related device tree specs
Message-ID: <20131207103434.54a057ab@crub>
In-Reply-To: <1385851897-23475-4-git-send-email-gsi@denx.de>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
 <1385851897-23475-4-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Rob Herring <rob.herring@calxeda.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 30 Nov 2013 23:51:23 +0100
Gerhard Sittig <gsi@denx.de> wrote:

> this addresses the clock driver aka provider's side of clocks
> - introduce a 'clocks' subtree with an 'osc' node for the crystal
>   or oscillator SoC input (fixed frequency)
> - the 'clock@f00' clock-control-module node references the 'osc' for
>   its input, and is another provider for all the clocks which the
>   CCM component manages
> - prepare for future references to clocks from peripheral nodes
>   by means of the <&clks ID> syntax and symbolic ID names which a
>   header file provides
> - provide default values with 33MHz oscillator frequency in the
>   common include (the 66MHz IPS bus already was there), and add
>   override values for the ifm AC14xx board which deviates from
>   the reference design (25MHz xtal, 80MHz IPS bus)
> 
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Ian Campbell <ian.campbell@citrix.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Mike Turquette <mturquette@linaro.org> # for v3, before &osc
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> ---
>  arch/powerpc/boot/dts/ac14xx.dts   |    7 +++++++
>  arch/powerpc/boot/dts/mpc5121.dtsi |   18 +++++++++++++++++-
>  2 files changed, 24 insertions(+), 1 deletion(-)

applied to next. Thanks!

Anatolij
