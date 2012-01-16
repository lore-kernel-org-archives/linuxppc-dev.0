Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe002.messaging.microsoft.com
 [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2DE221007D2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2012 06:37:24 +1100 (EST)
Message-ID: <4F147C49.40008@freescale.com>
Date: Mon, 16 Jan 2012 13:36:41 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Xu Jiucheng <B37781@freescale.com>
Subject: Re: [PATCH 1/2 v2] powerpc/85xx: Add dts for P1021RDB-PC board
References: <1326697208-1519-1-git-send-email-B37781@freescale.com>
In-Reply-To: <1326697208-1519-1-git-send-email-B37781@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Matthew McClintock <msm@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/16/2012 01:00 AM, Xu Jiucheng wrote:
> +	mdio@24000 {
> +		phy0: ethernet-phy@0 {
> +			interrupt-parent = <&mpic>;
> +			interrupts = <3 1>;
> +			reg = <0x0>;
> +		};
> +
> +		phy1: ethernet-phy@1 {
> +			interrupt-parent = <&mpic>;
> +			interrupts = <2 1>;
> +			reg = <0x1>;
> +		};

pq3-mpic.dtsi (included by p1021si-post.dtsi) uses 4-cell interrupt
specifiers, so they need to be used everywhere.

-Scott
