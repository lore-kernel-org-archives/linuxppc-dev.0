Return-Path: <bernhard@intevation.de>
Received: from kolab.intevation.de (aktaia.intevation.org [212.95.126.10])
	by ozlabs.org (Postfix) with ESMTP id 494E8DDDFD
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Feb 2008 21:07:52 +1100 (EST)
From: Bernhard Reiter <bernhard@intevation.de>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: compile quirk linux-2.6.24 (with workaround)
Date: Wed, 6 Feb 2008 11:07:37 +0100
References: <200802031729.12069.bernhard@intevation.de>
	<fa686aa40802050724o692ef9e7yf51945225f56da5b@mail.gmail.com>
	<20080205093820.5918a216@zod.rchland.ibm.com>
In-Reply-To: <20080205093820.5918a216@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1433458.QFdKtCEU4I";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200802061107.43576.bernhard@intevation.de>
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1433458.QFdKtCEU4I
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 05 February 2008 16:38, Josh Boyer wrote:
> > That would mean we're dropping support for compilers which can't build
> > 405/440 specific wrapper bits (or other core specific quirks that need
> > to go in the wrapper) =A0That doesn't sound appropriate to me.

I agree.
Note that dropping support for these compilers will raise the hurdle to=20
compile kernels, which might lead to less testing of the whole kernel. This=
=20
effect would probably eat up the advantages of better testing by always=20
building the whole source. So I do not recommend it. :)

> No it doesn't. =A0At least not yet. =A0I said I'd try to come up with a
> patch soon-ish. =A0

Thanks in advance!


=2D-=20
Managing Director - Owner: www.intevation.net       (Free Software Company)
Germany Coordinator: fsfeurope.org. Coordinator: www.Kolab-Konsortium.com.
Intevation GmbH, Osnabr=FCck, DE; Amtsgericht Osnabr=FCck, HRB 18998
Gesch=E4ftsf=FChrer Frank Koormann, Bernhard Reiter, Dr. Jan-Oliver Wagner

--nextPart1433458.QFdKtCEU4I
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.5 (GNU/Linux)

iD8DBQBHqYbvh9ag3dpKERYRAsYoAJ9o/N1TyxRIjOQp3kNmgBZKAyEEpgCghox7
ks9w7O9LDAr84yewD1o73cM=
=woFq
-----END PGP SIGNATURE-----

--nextPart1433458.QFdKtCEU4I--
