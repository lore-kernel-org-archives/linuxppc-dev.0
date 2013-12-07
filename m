Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3AE242C0090
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Dec 2013 20:41:23 +1100 (EST)
Date: Sat, 7 Dec 2013 10:41:16 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v6 06/17] dts: mpc512x: add clock specs for client lookups
Message-ID: <20131207104116.58889373@crub>
In-Reply-To: <1385851897-23475-7-git-send-email-gsi@denx.de>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
 <1385851897-23475-7-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Mike Turquette <mturquette@linaro.org>, linuxppc-dev@lists.ozlabs.org,
 Rob Herring <rob.herring@calxeda.com>, devicetree@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 30 Nov 2013 23:51:26 +0100
Gerhard Sittig <gsi@denx.de> wrote:

> this addresses the client side of device tree based clock lookups
> 
> add clock specifiers to the mbx, nfc, mscan, sdhc, i2c, axe, diu, viu,
> mdio, fec, usb, pata, psc, psc fifo, and pci nodes in the shared
> mpc5121.dtsi include
> 
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Ian Campbell <ian.campbell@citrix.com>
> Cc: devicetree@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Reviewed-by: Mike Turquette <mturquette@linaro.org>	# for v3: w/o bdlc, PSC ipg
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> ---
>  arch/powerpc/boot/dts/mpc5121.dtsi |   95 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)

applied to next. Thanks!

Anatolij
