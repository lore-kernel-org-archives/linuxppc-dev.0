Return-Path: <ianw@cse.unsw.edu.au>
Received: from note.orchestra.cse.unsw.EDU.AU (note.orchestra.cse.unsw.EDU.AU
	[129.94.242.24]) by ozlabs.org (Postfix) with ESMTP id AB679679E6
	for <linuxppc-dev@ozlabs.org>; Wed,  4 May 2005 08:27:09 +1000 (EST)
From: Ian Wienand <ianw@gelato.unsw.edu.au>
Sender: ianw@cse.unsw.edu.au
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 4 May 2005 08:22:00 +1000
Message-ID: <20050503222200.GA29940@cse.unsw.EDU.AU>
References: <1115072133.6031.33.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
In-Reply-To: <1115072133.6031.33.camel@gaston>
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


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 03, 2005 at 08:15:33AM +1000, Benjamin Herrenschmidt wrote:
> I would appreciate extensive testing, provided you figure out how to
> retreive the "git" repository from kernel.org :) There must be some
> howto somewhere, but I'm afraid I don't have a link at hand.

It's so far working well for me on an 800Mhz iBook (750fx) after quite
a few sleep and resume cycles.

Is there a fix in the works for the Radeon timing thing that makes the
screen go a little weird on wakeup?

FWIW, the two step way to get the git tree I followed was

wget http://www.kernel.org/pub/software/scm/cogito/cogito-0.8.tar.bz2
(install, modify path in Makefile if you want)

cd /usr/src
mkdir linux-2.6-git
cd linux-2.6-git
cg-init rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

-i
ianw@gelato.unsw.edu.au
http://www.gelato.unsw.edu.au

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFCd/mIWDlSU/gp6ecRAmH5AJ4w4iy3H23mKTJD225COTpkDzAsjACfVUkR
vGgUDbdEwc6+QNViRNSYjFo=
=z9S2
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
