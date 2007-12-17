Return-Path: <dgibson@ozlabs.org>
Date: Mon, 17 Dec 2007 11:40:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] wrapper: rename offset in offset_devp().
Message-ID: <20071217004023.GB2394@localhost.localdomain>
References: <20071211212303.GA3661@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071211212303.GA3661@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 11, 2007 at 03:23:04PM -0600, Scott Wood wrote:
> fdt_wrapper_create_node passes a variable called offset to offset_devp(),
> which uses said parameter to initialize a local variable called offset.
> 
> Due to one of the odder aspects of the C language, the result is an
> undefined variable, with no error or warning.

Ouch, nasty!  Good catch.

> Signed-off-by: Scott Wood <scottwood@freescale.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
