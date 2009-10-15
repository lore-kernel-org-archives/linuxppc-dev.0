Return-Path: <sfr@canb.auug.org.au>
Date: Fri, 16 Oct 2009 10:38:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 00/12] Merge common OpenFirmware device tree code
Message-Id: <20091016103829.323c89d7.sfr@canb.auug.org.au>
In-Reply-To: <fa686aa40910151006k43b07c30q1e43c3b1ae4af561@mail.gmail.com>
References: <20091007041007.16890.62194.stgit@angua>
	<20091015120007.3780c59b.sfr@canb.auug.org.au>
	<fa686aa40910151006k43b07c30q1e43c3b1ae4af561@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__16_Oct_2009_10_38_29_+1100_rYgps1CinLaddb/v"
Cc: monstr@monstr.eu, devicetree-discuss@lists.ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__16_Oct_2009_10_38_29_+1100_rYgps1CinLaddb/v
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grant,

On Thu, 15 Oct 2009 11:06:15 -0600 Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>
> In the mean time, I've pushed out the current series with acked-bys
> added to my git server.  I think I'm ready for things to start going
> into linux-next.  Since this is the first time I've asked for a tree
> to be added to linux-next, please let me know if you see anything
> troublesome or problematic.  Here's the tree:
>=20
> The following changes since commit 4bdf0bb7d64cf672199519b3d808e2a82f5b59=
e9:
>   Grant Likely (1):
>         powerpc/5200: Update defconfigs

Um, that commit is in no tree but yours ...

> are available in the git repository at:
>=20
>   git://git.secretlab.ca/git/linux-2.6 next-devicetree

I have added this for today, but note that it contains stuff that is not
devicetree related.  Trees in linux-next should be based on other trees
in linux-next (almost always Linus' tree, but any other nonrebasing tree
is fine).

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

--Signature=_Fri__16_Oct_2009_10_38_29_+1100_rYgps1CinLaddb/v
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkrXsnUACgkQjjKRsyhoI8y2YgCePiBZY9OJAjVAfpDfG5Qx9pVh
CRwAnj0xw+gJATQsgdVT+s94ZPRuMAwu
=A5u+
-----END PGP SIGNATURE-----

--Signature=_Fri__16_Oct_2009_10_38_29_+1100_rYgps1CinLaddb/v--
