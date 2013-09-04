Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 919CE2C00D3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Sep 2013 02:26:03 +1000 (EST)
Message-ID: <1378311953.12204.20.camel@snotra.buserror.net>
Subject: Re: [PATCH V3 2/2] powerpc/85xx: Add TWR-P1025 board support
From: Scott Wood <scottwood@freescale.com>
To: Xie Xiaobo <X.Xie@freescale.com>
Date: Wed, 4 Sep 2013 11:25:53 -0500
In-Reply-To: <1378116699-18826-2-git-send-email-X.Xie@freescale.com>
References: <1378116699-18826-1-git-send-email-X.Xie@freescale.com>
 <1378116699-18826-2-git-send-email-X.Xie@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org,
 Michael Johnston <michael.johnston@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-09-02 at 18:11 +0800, Xie Xiaobo wrote:
> +&soc {
> +	usb@22000 {
> +		phy_type = "ulpi";
> +	};
> +
> +	mdio@24000 {
> +		phy0: ethernet-phy@2 {
> +			interrupt-parent = <&mpic>;
> +			interrupts = <1 1>;
> +			reg = <0x2>;
> +		};
> +
> +		phy1: ethernet-phy@1 {
> +			interrupt-parent = <&mpic>;
> +			interrupts = <2 1>;
> +			reg = <0x1>;
> +		};

Again, #interrupt-cells is 4.

Please respond to feedback rather than ignoring it and reposting the
same thing without comment.

-Scott
