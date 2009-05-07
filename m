Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 02D79DDF80
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 16:45:19 +1000 (EST)
Message-ID: <4A02837C.5090608@grandegger.com>
Date: Thu, 07 May 2009 08:45:16 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 09/12] mpc5121ads: Added I2C RTC node to mpc5121ads DTS.
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<1241640919-4650-10-git-send-email-wd@denx.de>
In-Reply-To: <1241640919-4650-10-git-send-email-wd@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfgang Denk wrote:
> From: Piotr Ziecik <kosmo@semihalf.com>
> 
> Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
> Signed-off-by: Wolfgang Denk <wd@denx.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: John Rigby <jcrigby@gmail.com>
> ---
>  arch/powerpc/boot/dts/mpc5121ads.dts |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/mpc5121ads.dts b/arch/powerpc/boot/dts/mpc5121ads.dts
> index 93fe12a..c2d9de9 100644
> --- a/arch/powerpc/boot/dts/mpc5121ads.dts
> +++ b/arch/powerpc/boot/dts/mpc5121ads.dts
> @@ -210,6 +210,11 @@
>  			interrupts = <9 0x8>;
>  			interrupt-parent = < &ipic >;
>  			fsl5200-clocking;

The above line is obsolete since -rc4. Please check the revised bindings
in Documentation/powerpc/dts-bindings/fsl/i2c.txt. You may even want:

                        clock-frequency = <100000>;

Wolfgang.
