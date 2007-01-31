Return-Path: <dgibson@ozlabs.org>
Date: Wed, 31 Jan 2007 18:02:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 16/18] bootwrapper: Add dt_ops methods.
Message-ID: <20070131070205.GF25231@localhost.localdomain>
References: <20070129201307.GP13485@ld0162-tx32.am.freescale.net>
	<E87F75BF-81BC-4440-AFFD-10CD9DF783C7@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E87F75BF-81BC-4440-AFFD-10CD9DF783C7@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 30, 2007 at 09:01:17PM +0100, Segher Boessenkool wrote:
> > +static void *ft_finddevice_rel(const void *phandle, const char *name)
> > +{
> > +	return ft_find_device_rel(&cxt, phandle, name);
> > +}
> 
> Seeing all these...  wouldn't it be better to make "cxt"
> an implicit parameter to all the ft_ functions?  It's not
> like you'll ever be dealing with more than one tree ;-)

Not necessarily true.  I'm contemplating some wrapper setups that
would involve selecting from one of several possible pre-built trees
depending on some id from the firmware.  Or even grafting several
trees together.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
