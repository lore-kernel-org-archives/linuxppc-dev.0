Return-Path: <dgibson@ozlabs.org>
Date: Thu, 25 Jan 2007 10:37:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 05/18] Add ft_first_node().
Message-ID: <20070124233722.GA10736@localhost.localdomain>
References: <20070124210707.GE10527@ld0162-tx32.am.freescale.net>
	<45B7D044.7020007@smiths-aerospace.com>
	<45B7D6B6.2010308@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45B7D6B6.2010308@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 24, 2007 at 03:59:18PM -0600, Scott Wood wrote:
> Jerry Van Baren wrote:
> > Have you considered replacing flatdevtree.c with David Gibson's fdtlib? 
> >  The interface is a lot cleaner, which likely carries through to the 
> > underlying code.

In any case I intend to replace the flatdevtree.c code with libfdt at
some point in the future (not too far away, I hope).  I'm delaying on
a couple of things at present: first, sorting out IBM-internal
bureaucratic hurdles, second letting the API settle a bit so that I'm
pretty confident it won't want changing.

> > <http://thread.gmane.org/gmane.linux.ports.ppc64.devel/12771/focus=12877>
> 
> I tried pulling from the git tree, but since I'm using the http protocol 
> (our firewall unfortunately won't allow the git protocol to go through), 
> all I get is:
> 
> Cannot get remote repository information.
> Perhaps git-update-server-info needs to be run there?

Um.. I'm running git-update-server-info, but the repository wasn't
anywhere http visible.  Just moved things around, now try:
	git clone http://ozlabs.org/~dgibson/libfdt.git

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
