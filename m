Return-Path: <dgibson@ozlabs.org>
Date: Fri, 1 Feb 2008 18:50:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH 2/4 v4] POWERPC: Add StorCenter DTS first draft.
Message-ID: <20080201075033.GB18684@localhost.localdomain>
References: <E1JHkYP-00010b-At@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1JHkYP-00010b-At@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 23, 2008 at 12:42:29PM -0600, Jon Loeliger wrote:
> 
> Based on the Kurobox DTS files.

[snip]
> +/ {
> +	model = "StorCenter";
> +	compatible = "storcenter";

This really needs a vendor prefix.

> +	chosen {
> +		linux,stdout-path = "/soc/serial@4500";

You can now use a path reference here.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
