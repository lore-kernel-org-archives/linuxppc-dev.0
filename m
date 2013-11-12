Return-Path: <mark.rutland@arm.com>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50]) by ozlabs.org (Postfix) with ESMTP id E6B2F2C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Nov 2013 20:11:52 +1100 (EST)
Date: Tue, 12 Nov 2013 09:11:29 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Adam Borowski <kilobyte@angband.pl>
Subject: Re: [PATCH] powerpc/85xx: typo in dts: "interupt" (four devices)
Message-ID: <20131112091128.GA2976@e106331-lin.cambridge.arm.com>
References: <1384206727-11880-1-git-send-email-kilobyte@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384206727-11880-1-git-send-email-kilobyte@angband.pl>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Stephen Warren <swarren@wwwdotorg.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 11, 2013 at 09:52:07PM +0000, Adam Borowski wrote:
> These lines were inoperative for four years, which puts some doubt into
> their importance, and it's possible the fixed version will regress, but
> at the very least they should be removed instead.
> 
> Signed-off-by: Adam Borowski <kilobyte@angband.pl>
> ---
>  arch/powerpc/boot/dts/xcalibur1501.dts | 4 ++--
>  arch/powerpc/boot/dts/xpedite5301.dts  | 4 ++--
>  arch/powerpc/boot/dts/xpedite5330.dts  | 4 ++--
>  arch/powerpc/boot/dts/xpedite5370.dts  | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/xcalibur1501.dts b/arch/powerpc/boot/dts/xcalibur1501.dts
> index cc00f4d..f151426 100644
> --- a/arch/powerpc/boot/dts/xcalibur1501.dts
> +++ b/arch/powerpc/boot/dts/xcalibur1501.dts
> @@ -637,14 +637,14 @@
>  		tlu@2f000 {
>  			compatible = "fsl,mpc8572-tlu", "fsl_tlu";
>  			reg = <0x2f000 0x1000>;
> -			interupts = <61 2 >;
> +			interrupts = <61 2 >;

While you're fixing the typo, could you get rid of the extraneous space
before the closing bracket? It seems to be duplicated across the other 3
dts fragments you fix up also.

Cheers,
Mark.
