Return-Path: <dgibson@ozlabs.org>
Date: Fri, 7 Mar 2008 11:29:59 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexandr Smirnov <asmirnov@ru.mvista.com>
Subject: Re: [PATCH 3/4] Emerson KSI8560 device tree
Message-ID: <20080307002959.GC24142@localhost.localdomain>
References: <20080304162322.GA19634@ru.mvista.com>
	<20080306151451.GA25251@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080306151451.GA25251@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 06, 2008 at 06:14:51PM +0300, Alexandr Smirnov wrote:
> Add device tree file for Emerson KSI8560 board.
> 
> Signed-off-by: Alexandr Smirnov <asmirnov@ru.mvista.com>

[snip]
> +	soc@fdf00000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		device_type = "soc";

Since this is a new board, is it feasible to require it to have a
sufficient new u-boot version that we don't require this old
device_type entry.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
