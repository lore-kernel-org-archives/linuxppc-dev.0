Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 3D9EAB7BAB
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Nov 2009 19:13:34 +1100 (EST)
Date: Thu, 5 Nov 2009 19:13:28 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: 2.6.33 -next tree
Message-Id: <20091105191328.d63eeb1b.sfr@canb.auug.org.au>
In-Reply-To: <fa686aa40911050008r33cff773w191e97654efacf19@mail.gmail.com>
References: <fa686aa40911042210q5bbbca2fi82911b7245d17588@mail.gmail.com>
	<20091105190228.916c845c.sfr@canb.auug.org.au>
	<fa686aa40911050008r33cff773w191e97654efacf19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__5_Nov_2009_19_13_28_+1100_mnRHFQ=Qn6paiJUS"
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Brownell <dbrownell@users.sourceforge.net>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__5_Nov_2009_19_13_28_+1100_mnRHFQ=Qn6paiJUS
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grant,

On Thu, 5 Nov 2009 01:08:53 -0700 Grant Likely <grant.likely@secretlab.ca> =
wrote:
>
> It is 5xxx and virtex related stuff, plus a smattering of generic ppc
> changes.  "5xxx-and-virtex" perhaps?

OK, done.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgment of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
	Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

Legal Stuff:
By participating in linux-next, your subsystem tree contributions are
public and will be included in the linux-next trees.  You may be sent
e-mail messages indicating errors or other issues when the
patches/commits from your subsystem tree are merged and tested in
linux-next.  These messages may also be cross-posted to the linux-next
mailing list, the linux-kernel mailing list, etc.  The linux-next tree
project and IBM (my employer) make no warranties regarding the linux-next
project, the testing procedures, the results, the e-mails, etc.  If you
don't agree to these ground rules, let me know and I'll remove your tree
from participation in linux-next.

--Signature=_Thu__5_Nov_2009_19_13_28_+1100_mnRHFQ=Qn6paiJUS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkryiSgACgkQjjKRsyhoI8wSugCgskUXVcr+vCoc+rTd+54kMdbI
gOEAnRkLbPEGE4fz9ZXGfOpZKppYKIqI
=FAWm
-----END PGP SIGNATURE-----

--Signature=_Thu__5_Nov_2009_19_13_28_+1100_mnRHFQ=Qn6paiJUS--
