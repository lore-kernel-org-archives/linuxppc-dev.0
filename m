Return-Path: <dgibson@ozlabs.org>
Date: Thu, 19 Jan 2006 12:29:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Becky Bruce <bgill@freescale.com>
Subject: Re: [PATCH] dtc: add bus-frequency prop to SOC node
Message-ID: <20060119012925.GL23219@localhost.localdomain>
References: <Pine.LNX.4.61.0601180917080.11236@cde-tx32-ldt329.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.61.0601180917080.11236@cde-tx32-ldt329.sps.mot.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 18, 2006 at 09:20:58AM -0600, Becky Bruce wrote:
> Updated SOC node definition in documentation to include bus-frequency
> property. Also extended mdio example to match specification.
> 
> Signed-off-by: Becky Bruce <becky.bruce@freescale.com>

Looks sane enough to me, but I don't think I'm the right person to be
assessing changes to this document merely because it's hosted in the
dtc git tree for now.  I'll apply if I get an Ack from Paulus or BenH.

Had a brief chat to Paulus - we might look at moving this document to
Documentation/ in the kernel tree, arguably a better place for it.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
