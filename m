Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 5064EDDEEE
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 15:39:52 +1100 (EST)
Date: Wed, 31 Jan 2007 07:39:47 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/3] [POWERPC] Fix kernel build errors for mpc8272ads
	and mpc8560ads
Message-ID: <20070131073947.67520c16@localhost.localdomain>
In-Reply-To: <F739E1EE-3BA6-428D-8C96-AB09E1B9773B@kernel.crashing.org>
References: <20070130230711.21111.52924.stgit@localhost.localdomain>
	<20070130230859.21111.39370.stgit@localhost.localdomain>
	<F739E1EE-3BA6-428D-8C96-AB09E1B9773B@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_fQbg3qBpXfzRjBQzqgcySa.;
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_fQbg3qBpXfzRjBQzqgcySa.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Jan 2007 17:41:14 -0600
Kumar Gala wrote:

>=20
> On Jan 30, 2007, at 5:09 PM, Vitaly Bordug wrote:
>=20
> >
> > Recent update of asm-powerpc/io.h caused cpm-related stuff to
> > break in the
> > current kernel. Current patch fixes it, as well as other =20
> > inconsistencies
> > expressed, that do not permit targets from working properly:
> >
> > - Updated dts with a chosen node with interrupt controller,
>=20
> Why do we need this?  I'm not aware of any other boards having to
> set this?

Correct. In fact I dropped that change, after "dtc -f"  discussion but forg=
ot
to clear this line from desc. Will resend in a few minutes, thanks for poin=
ting it out.

--
Sincerely, Vitaly

--Sig_fQbg3qBpXfzRjBQzqgcySa.
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFwB2UuOg9JvQhSEsRAuupAJ9HkjX/gG41pqqsv+plrFeVk4QuWQCfeqjf
+hPI5op/I3CfZzsWItCeh3s=
=2MDt
-----END PGP SIGNATURE-----

--Sig_fQbg3qBpXfzRjBQzqgcySa.--
