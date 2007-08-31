Return-Path: <dgibson@ozlabs.org>
Date: Fri, 31 Aug 2007 12:44:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/3] mpc8349: Add linux,
	network-index to ethernet nodes in device tree
Message-ID: <20070831024427.GB19271@localhost.localdomain>
References: <20070830202618.9927.32588.stgit@trillian.cg.shawcable.net>
	<20070830202624.9927.50088.stgit@trillian.cg.shawcable.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070830202624.9927.50088.stgit@trillian.cg.shawcable.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 30, 2007 at 02:26:24PM -0600, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> cuImage need to know the logical index of the ethernet devices in order
> to assign mac addresses.  This patch adds the needed properties
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> CC: Scott Wood <scottwood@freescale.com>
> CC: Kumar Gala <galak@kernel.crashing.org>
> CC: Timur Tabi <timur@freescale.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
