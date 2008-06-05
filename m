Return-Path: <dgibson@ozlabs.org>
Date: Fri, 6 Jun 2008 08:56:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Timur Tabi <timur@freescale.com>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
Message-ID: <20080605225637.GG30980@yookeroo.seuss>
References: <48480987.1070701@freescale.com>
	<fa686aa40806050900i40f0aa62o4bab3b8c7409b15f@mail.gmail.com>
	<484810A3.5070301@freescale.com>
	<20080605112122.0381a338@zod.rchland.ibm.com>
	<48481373.8010706@freescale.com>
	<20080605132735.3433f2af@zod.rchland.ibm.com>
	<fa686aa40806051146h10d9add6ude64d59cedf08f7d@mail.gmail.com>
	<20080605135625.562d1dbe@zod.rchland.ibm.com>
	<fa686aa40806051214u6866cec0m66ea32275d8bd5cc@mail.gmail.com>
	<48483B99.3010300@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48483B99.3010300@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>, Stefan Roese <sr@denx.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 05, 2008 at 02:16:41PM -0500, Timur Tabi wrote:
> Grant Likely wrote:
> 
> > No; use an alias in the aliases node.  That is what aliases is designed
> > for.  Something like 'index' is a reinvention of the wheel.
> 
> Do aliases work in reverse?  That is, if I have a pointer to a
> device node, can I look up its alias directly?  Or do I have to scan
> the aliases node and do a comparison of each phandle, one at a time,
> until I find a match?  And when I find a match, will I need to do
> sscanf() in order to extract the actual index value from the
> property?

Aliases aren't trivially reversible, but it shouldn't be too hard to
write a helper function which will do the scan and parse you describe.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
