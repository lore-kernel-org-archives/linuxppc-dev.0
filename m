Return-Path: <dgibson@ozlabs.org>
Date: Wed, 14 Mar 2007 11:02:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [dtc] Add support for flat device tree format version 17
Message-ID: <20070314000213.GC25514@localhost.localdomain>
References: <20070313062240.GA22737@localhost.localdomain>
	<20070313211002.GA6985@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070313211002.GA6985@mag.az.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 13, 2007 at 02:10:02PM -0700, Mark A. Greer wrote:
> On Tue, Mar 13, 2007 at 05:22:40PM +1100, David Gibson wrote:
> > Index: dtc/dtc.c
> > ===================================================================
> > --- dtc.orig/dtc.c	2007-03-13 16:37:01.000000000 +1100
> > +++ dtc/dtc.c	2007-03-13 16:37:17.000000000 +1100
> > @@ -113,7 +113,7 @@ int main(int argc, char *argv[])
> >  	int opt;
> >  	FILE *inf = NULL;
> >  	FILE *outf = NULL;
> > -	int outversion = 0x10;
> > +	int outversion = 0x11;
> 
> Super-minor nit but since you seem to refer to the version as decimal
> '17' everywhere else, why don't you just put '17' here?

Oh, because, the old code used hex.  Which it does in a totally
inconsistent fashion.  Yeah, I probably should take this opportunity
to start phasing out the use of hex.  Ok, revised patch coming.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
