Return-Path: <dgibson@ozlabs.org>
Date: Fri, 16 Mar 2007 13:05:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>, paulus@samba.org,
	linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 10/19] bootwrapper: Add ft_find_device_rel().
Message-ID: <20070316020515.GC6868@localhost.localdomain>
References: <20070312204153.GJ28545@ld0162-tx32.am.freescale.net>
	<20070316020036.GB6868@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070316020036.GB6868@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 16, 2007 at 01:00:36PM +1100, David Gibson wrote:
> On Mon, Mar 12, 2007 at 02:41:53PM -0600, Scott Wood wrote:
> > Add a function to look up a relative, rather than absolute, path
> > name.
> 
> Ok, I was dubious for a while, but I'm now convinced of the need for
> this one.
> 
> Except, to keep the dt_ops structure simple, I'd prefer to see
> relative lookup by the *only* one implemented in the hook methods.
> Absolute finddevice can then be implemented as a trivial wrapper
> around that.

And the hooks are added in a later patch in any case, so:
Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
