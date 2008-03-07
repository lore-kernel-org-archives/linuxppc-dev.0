Return-Path: <dgibson@ozlabs.org>
Date: Fri, 7 Mar 2008 11:27:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH 2/2] Add local bus device nodes to MPC837xMDS device trees.
Message-ID: <20080307002730.GB24142@localhost.localdomain>
References: <1204800155-11613-1-git-send-email-leoli@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1204800155-11613-1-git-send-email-leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[snip]
> +		bcsr@1,0 {
> +			reg = <1 0x0 0x8000>;
> +			compatible = "fsl,mpc837xmds-bcsr";
> +		};
> +
> +		nand@3,0 {

This isn't a problem with this device tree, but it's probably time we
started establishing some conventional generic names for nand flash
and board-control devices.

So, to start the ball rolling, I've seen several names for nand flash
nodes, I'd suggest we standardise on "nand-flash".

I've seen several variants for board control devices (cpld, bcsr,
fpga, etc.) I suggest we standardise on "board-control"

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
