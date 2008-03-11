Return-Path: <dgibson@ozlabs.org>
Date: Wed, 12 Mar 2008 09:41:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Rune Torgersen <runet@innovsys.com>
Subject: Re: OF compatible MTD platform RAM driver ?
Message-ID: <20080311224110.GB7642@localhost.localdomain>
References: <200803101606.39184.laurentp@cse-semaphore.com>
	<DCEAAC0833DD314AB0B58112AD99B93B0418505E@ismail.innsys.innovsys.com>
	<20080311004545.GI11559@localhost.localdomain>
	<DCEAAC0833DD314AB0B58112AD99B93B041854B3@ismail.innsys.innovsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B041854B3@ismail.innsys.innovsys.com>
Cc: ben@simtec.co.uk, linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 11, 2008 at 10:00:10AM -0500, Rune Torgersen wrote:
> David Gibson wrote:
> > On Mon, Mar 10, 2008 at 12:00:22PM -0500, Rune Torgersen wrote:
> >> We ran ito the same issue.
> >> We did option 3, as it was efinetly the easiest,
> > 
> > I think this is the best option in principle.
> > 
> >> here is the sram entry in our dts:
> > 
> > Except that your implementation of it is not good.
> > 
> > You're relying on the old obsolete flash binding with the "probe-type"
> > field.  The solution should be adapted to the new approach which uses
> > values in the "compatible" field to indicate various sorts of flash
> > device.
> 
> Yea, I know. But it was the easiest way of doing it at the time we did
> our port....
> In a timecrunch, easier is sometimes better than correct. :)

Well sure, but don't expect others to be swayed by your time pressure.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
