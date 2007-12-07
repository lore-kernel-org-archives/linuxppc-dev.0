Return-Path: <dgibson@ozlabs.org>
Date: Sat, 8 Dec 2007 10:22:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>, linuxppc-dev@ozlabs.org
Subject: Re: dtc: Convert #address-cells and #size-cells related checks
Message-ID: <20071207232242.GA2454@localhost.localdomain>
References: <20071207030555.GB26412@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071207030555.GB26412@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 07, 2007 at 02:05:55PM +1100, David Gibson wrote:
> This patch converts checks related to #address-cells and #size-cells
> to the new framework.  Specifically, it reimplements the check that
> "reg" properties have a valid size based on the relevant
> #address-cells and #size-cells values.  The new implementation uses
> the correct default value, unlike the old-style check which assumed
> the values were inherited by default.
> 
> It also implements a new, similar test for "ranges" properties.
> 
> Finally, since relying on the default values of these variables is
> considered not-good-practice these days, it implements a "style" check
> which will give a warning if the tree ever relies on the default
> values (that is if any node with either "reg" or "ranges" appears
> under a parent which has no #address-cells or #size-cells property).

Oops, that should, of course, be:

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
