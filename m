Return-Path: <dgibson@ozlabs.org>
Date: Fri, 1 Dec 2006 17:00:38 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-dev@ozlabs.org
Subject: Re: libfdt - flat tree manipulation library
Message-ID: <20061201060038.GA25476@localhost.localdomain>
References: <20061127055905.GA6428@localhost.localdomain>
	<20061129055904.GA11883@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061129055904.GA11883@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 29, 2006 at 04:59:04PM +1100, David Gibson wrote:
> On Mon, Nov 27, 2006 at 04:59:05PM +1100, David Gibson wrote:
> [snip]
> > The code, such as it is, is at:
> > 	git://ozlabs.org/home/dgibson/git/libfdt.git
> 
> Code for writing device trees from scratch, sequentially, is now
> implemented.

And now support for random access read-write is implemented.  The
library is now close to feature-complete, cleanups and convenience
wrappers remain.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
