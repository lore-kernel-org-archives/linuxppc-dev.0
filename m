Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0183.outbound.protection.outlook.com [207.46.163.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4505D2C008F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 10:08:28 +1100 (EST)
Date: Wed, 19 Mar 2014 18:08:13 -0500
From: Scott Wood <scottwood@freescale.com>
To: Valentin Longchamp <valentin.longchamp@keymile.com>
Subject: Re: [v2, 2/2] powerpc/mpc85xx: add support for Keymile's kmcoge4 board
Message-ID: <20140319230813.GA30481@home.buserror.net>
References: <1392119407-29490-3-git-send-email-valentin.longchamp@keymile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1392119407-29490-3-git-send-email-valentin.longchamp@keymile.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 11, 2014 at 12:50:07PM +0100, Valentin Longchamp wrote:
> +		reset_cpld@1,0 {
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			reg = <1 0 0x80>;
> +			interrupt-parent = <&mpic>;
> +			interrupts = <
> +				4 1 0 0
> +				5 1 0 0>;
> +		};
> +
> +		chassis_mgmt@3,0 {
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			reg = <3 0 0x100>;
> +			interrupt-parent = <&mpic>;
> +			interrupts = <6 1 0 0>;
> +		};

Dashes are preferred to underscores in device trees.

More importantly, these nodes need proper compatibles and bindings.  Once
that's done, the name for the nodes should probably be
"board_control@whatever" for both.

-Scott
