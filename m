Return-Path: <joerg@dorchain.net>
Received: from Redstar.dorchain.net (153-133-088-212.ip-addr.teresto.net
	[212.88.133.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 85B9267A64
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Mar 2005 01:18:57 +1100 (EST)
Date: Thu, 3 Mar 2005 15:18:32 +0100
From: Joerg Dorchain <joerg@dorchain.net>
To: evilninja <evilninja@gmx.net>
Message-ID: <20050303141832.GU25080@Redstar.dorchain.net>
References: <20050303124435.GA24233@Redstar.dorchain.net>
	<4227153C.3030201@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TBFeK8oU8Jij/i72"
In-Reply-To: <4227153C.3030201@gmx.net>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: boot time scheduling hile atomic (was: GCC4 fun.)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--TBFeK8oU8Jij/i72
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 03, 2005 at 02:46:36PM +0100, evilninja wrote:
>=20
> what does this have to do with your subject? ("GCC4 fun.")

My stupidity. Mixed up threads.
>=20
> > scheduling while atomic: swapper/0x00000002/0
> > Call trace:
> >  [c0007620] dump_stack+0x18/0x28
> >  [c01de704] schedule+0x678/0x67c
> >  [c0004500] syscall_exit_work+0x108/0x10c
> >  [c02a97b4] proc_root_init+0x168/0x174
> >  [ff847288] 0xff847288
> >  [c02945e8] start_kernel+0x144/0x170
> >  [00003a30] 0x3a30
>=20
> did you try the various -rc kernels before 2.6.11? did it happen with
> these too?

No. Unfortunately, my mac has no regular internet connection.
>=20
> i don't know why you're getting this error, but seeing "swapper" to be
> involved here: can you compile with CONFIG_SWAP=3Dn and boot this one?

I'll do tonight.


Joerg


--TBFeK8oU8Jij/i72
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCJxy4jY4+4PdzvOARAs8iAJwLmpykxni+u0O5xSircp6hoI1EIACfa5q0
Bsl5UDxMKWmsMg4cWd3+zzY=
=F3An
-----END PGP SIGNATURE-----

--TBFeK8oU8Jij/i72--
