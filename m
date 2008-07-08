Return-Path: <dgibson@ozlabs.org>
Date: Tue, 8 Jul 2008 13:44:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andre Schwarz <andre.schwarz@matrix-vision.de>
Subject: Re: [PATCH v2] Add MPC5200B base board mvBC-P
Message-ID: <20080708034427.GD1549@yookeroo.seuss>
References: <4871D065.8080709@matrix-vision.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4871D065.8080709@matrix-vision.de>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 07, 2008 at 10:14:29AM +0200, Andre Schwarz wrote:
> The mvBlueCOUGAR-P is a MPC5200B based camera system with Intel Gigabit ethernet
> controller (using e1000). It's just another MPC5200_simple board.

[snip]
> +		timer@600 {	// General Purpose Timer
> +			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
> +			reg = <0x600 0x10>;
> +			interrupts = <1 9 0>;
> +			interrupt-parent = <&mpc5200_pic>;
> +			fsl,has-wdt;
> +		};
> +
> +		timer@610 {	// General Purpose Timer
> +			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
> +			cell-index = <1>;

What shared resource is this cell-index value used to index?

Also why does it not appear on the timer@600 but does on all the
others.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
