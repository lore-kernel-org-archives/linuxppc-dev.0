Return-Path: <dgibson@ozlabs.org>
Date: Mon, 14 Jan 2008 11:01:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/3] 8xx: Analogue & Micro Adder875 board support.
Message-ID: <20080114000113.GA14801@localhost.localdomain>
References: <20080111200705.GA696@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080111200705.GA696@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 11, 2008 at 02:07:05PM -0600, Scott Wood wrote:
> Signed-off-by: Scott Wood <scottwood@freescale.com>

[snip]
> +	aliases {
> +		console = &console;
> +		enet0 = &eth0;
> +		enet1 = &eth1;

I think most other boards are settling on aliases "ethernet0"
etc. instead of "enet0" (though there's no reason you couldn't have
both.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
