Return-Path: <dgibson@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 699E6DE18A
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Mar 2009 13:16:51 +1100 (EST)
Date: Sat, 14 Mar 2009 13:16:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Martyn Welch <martyn.welch@gefanuc.com>
Subject: Re: [PATCH 1/2] powerpc/86xx: Board support for GE Fanuc's PPC9A
Message-ID: <20090314021642.GA7094@yookeroo.seuss>
References: <20090313154716.25810.69695.stgit@ubuntu8041.localdomain>
	<20090313155226.25810.79323.stgit@ubuntu8041.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090313155226.25810.79323.stgit@ubuntu8041.localdomain>
Cc: linuxppc-dev@ozlabs.org, wim@iguana.be
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 13, 2009 at 03:52:26PM +0000, Martyn Welch wrote:
> Support for the PPC9A VME Single Board Computer from GE Fanuc (PowerPC
> MPC8641D).
> 
> This is the basic board support for GE Fanuc's PPC9A, a 6U single board
> computer, based on Freescale's MPC8641D.
> 
> Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>

[snip]
> +	soc@fef00000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		#interrupt-cells = <2>;
> +		device_type = "soc";
> +		compatible = "simple-bus";

There should be more detail in the compatible field - list the
specific model of the SoC, before including "simple-bus".  device_type
also doesn't really belong here, but it's possible you have to include
it for compatibility with older u-boot versions.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
