Return-Path: <dgibson@ozlabs.org>
Date: Thu, 22 Nov 2007 11:22:54 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH 12/14] powerpc: Add early udbg support for 40x
	processors
Message-ID: <20071122002254.GE19445@localhost.localdomain>
References: <1195625777.579001.269266058699.qpush@grosgo>
	<20071121061720.83D5ADEBE3@ozlabs.org>
	<20071121225838.GC19445@localhost.localdomain>
	<1195689615.6970.117.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1195689615.6970.117.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 22, 2007 at 11:00:15AM +1100, Benjamin Herrenschmidt wrote:
> 
> On Thu, 2007-11-22 at 09:58 +1100, David Gibson wrote:
> > On Wed, Nov 21, 2007 at 05:16:30PM +1100, Benjamin Herrenschmidt wrote:
> > > This adds some basic real mode based early udbg support for 40x
> > > in order to debug things more easily
> > 
> > Shouldn't we be able to share code with the Maple realmode udbg()?
> 
> Do you really care ?

Not very much, no.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
