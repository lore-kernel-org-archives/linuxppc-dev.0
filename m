Return-Path: <ianw@cse.unsw.edu.au>
Received: from note.orchestra.cse.unsw.EDU.AU (note.orchestra.cse.unsw.EDU.AU
	[129.94.242.24]) by ozlabs.org (Postfix) with ESMTP id 6CABD679E6
	for <linuxppc-dev@ozlabs.org>; Wed,  4 May 2005 09:48:14 +1000 (EST)
From: Ian Wienand <ianw@gelato.unsw.edu.au>
Sender: ianw@cse.unsw.edu.au
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 4 May 2005 09:48:11 +1000
Message-ID: <20050503234811.GA10048@cse.unsw.EDU.AU>
References: <1115072133.6031.33.camel@gaston>
	<20050503222200.GA29940@cse.unsw.EDU.AU>
	<1115163690.7568.45.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
In-Reply-To: <1115163690.7568.45.camel@gaston>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	DebianPPC <debian-powerpc@lists.debian.org>
Subject: Re: Laptop sleep & current "git" tree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 04, 2005 at 09:41:30AM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2005-05-04 at 08:22 +1000, Ian Wienand wrote:
> > Is there a fix in the works for the Radeon timing thing that makes the
> > screen go a little weird on wakeup?
> 
> I don't know this problem, what happens precisely and what model of
> radeon chip do you have ?

We discussed it briefly previously

http://lists.debian.org/debian-powerpc/2005/04/msg00138.html

 "Ok. I suspect the wakeup effect might be caused by the delays in
 radeonfb that I added to work around some chip errata... You can try
 hacking them out from the errata function in radeonfb.h"

-i

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFCeA27WDlSU/gp6ecRAlkNAKCDsd1cGf+CDgK9+aDpA/eQFObbOwCfQ6yT
PyBjdIKt+f6sYdoODgwUZQ0=
=M9kC
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
