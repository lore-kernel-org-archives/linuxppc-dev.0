Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 41A28DE027
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 09:27:05 +1100 (EST)
Date: Wed, 26 Mar 2008 09:26:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Theodore Tso <tytso@MIT.EDU>
Subject: Re: [PATCH] ppc: Export empty_zero_page
Message-Id: <20080326092657.8b65e5ea.sfr@canb.auug.org.au>
In-Reply-To: <20080325135454.GK30110@mit.edu>
References: <E1JZGwo-0000vf-2v@closure.thunk.org>
	<20080312034110.GT6887@bakeyournoodle.com>
	<20080312144239.GY15804@mit.edu> <20080312202431.GG15804@mit.edu>
	<20080325135454.GK30110@mit.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__26_Mar_2008_09_26_57_+1100_ZCILdlsMWQyaDnjX"
Cc: linuxppc-dev@ozlabs.org, Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__26_Mar_2008_09_26_57_+1100_ZCILdlsMWQyaDnjX
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ted,

On Tue, 25 Mar 2008 09:54:54 -0400 Theodore Tso <tytso@MIT.EDU> wrote:
>
> So I screwed this one up.  Mea culpa, mea culpa, mea maxima culpa....
>=20
> I assume Stephen's already sent this to patch to you guys (I picked it
> up from the linux-next git tree), but just in case he didn't....

Yeah, I already sent it and paulus is probably going to put it in his
2.6.26 tree.

However, have you made any progress on Christoph's suggestion:

"The real fix is that ext4 shouldn't be using ZERO_PAGE().  Please use
the same zeroing helpers all the other filesystems and drivers use."

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__26_Mar_2008_09_26_57_+1100_ZCILdlsMWQyaDnjX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH6Xw1TgG2atn1QN8RAhX5AJ9SvApgAEUUQQq9Go01BKipDY3G2QCdEPy5
PtGw5cQCW4EgmfMVFMjs8t8=
=ucqc
-----END PGP SIGNATURE-----

--Signature=_Wed__26_Mar_2008_09_26_57_+1100_ZCILdlsMWQyaDnjX--
