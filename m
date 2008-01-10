Return-Path: <dgibson@ozlabs.org>
Date: Thu, 10 Jan 2008 16:09:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/3] Handle absolute pathnames correctly in dtc_open_file.
Message-ID: <20080110050958.GD19088@localhost.localdomain>
References: <20080104211045.GB28991@ld0162-tx32.am.freescale.net>
	<20080106033716.GL4326@localhost.localdomain>
	<20080106224623.GA8239@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080106224623.GA8239@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jan 06, 2008 at 04:46:24PM -0600, Scott Wood wrote:
> On Sun, Jan 06, 2008 at 02:37:16PM +1100, David Gibson wrote:
> > >  out:
> > > +	free((void *)file->dir);
> > 
> > That cast shouldn't be there.
> 
> It generates a constness warning otherwise.  I was on the fence over
> whether to just remove the constness (even though the data is never
> modified during its lifetime); would that be preferable?

I think that is preferable.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
