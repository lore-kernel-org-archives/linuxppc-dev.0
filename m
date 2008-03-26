Return-Path: <dgibson@ozlabs.org>
Date: Thu, 27 Mar 2008 09:30:38 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: dtc: Trivial formatting fixes
Message-ID: <20080326223038.GA5777@localhost.localdomain>
References: <20080326052103.GB2090@localhost.localdomain>
	<E1JeVTb-0005tQ-Ae@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1JeVTb-0005tQ-Ae@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 26, 2008 at 08:15:35AM -0500, Jon Loeliger wrote:
> > This patch fixes some trivial indentation and brace/bracket style
> > problems.
> 
> 
> > @@ -179,9 +179,8 @@
> >  		arg = argv[optind];
> >  
> >  	/* minsize and padsize are mutually exclusive */
> > -	if ((minsize) && (padsize)) {
> > +	if (minsize && padsize)
> >  		die("Can't set both -p and -S\n");
> > -	}
> 
> 
> I do not consider extra braces a "problem", and will
> not be applying those changes.  The other indentation
> fixes will be applied, of course.

Meh, whatever.  Usual kernel style - which is what I originally
adopted for dtc - says no braces for one line blocks.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
