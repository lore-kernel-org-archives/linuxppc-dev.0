Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 6527ADDECF
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Jan 2007 03:06:17 +1100 (EST)
Date: Wed, 10 Jan 2007 19:04:41 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Ben Warren <bwarren@qstreams.com>
Subject: Re: Using fixed_phy with gianfar
Message-ID: <20070110190441.0f47a5ab@localhost.localdomain>
In-Reply-To: <880857.53326.qm@web308.biz.mail.mud.yahoo.com>
References: <20070110161145.3d8b0c77@localhost.localdomain>
	<880857.53326.qm@web308.biz.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_l5tXeEa.fIRu4/uibq46Ey+";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Sig_l5tXeEa.fIRu4/uibq46Ey+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Jan 2007 06:22:40 -0800 (PST)
Ben Warren wrote:

> Thanks Vitaly!
>=20
> --- Vitaly Bordug <vbordug@ru.mvista.com> wrote:
>=20
> > No, you do not miss - this is an issue. In fact MDIO
> > bus was changed for numeric for gianfar-stuff, and
> > has been remaining string for fs_enet. I think it
> > makes sense to average this up, and will try to do
> > that once will get 8349-mitx which is gianfar+ fixed
> > user.
> >=20
> > The point is that fixed should be updated to numeric
> > MDIO address encoding. This has to come through
> > netdev, so I'll try to get it fixed by the next
> > merge window.
> >=20
> > --
> > Sincerely, Vitaly
> >=20
>=20
> Ideally (for me anyway), we'd be able to pass some
> fixed phy information via the device tree, for example
> speed and duplexity.  This way a board could, for
> example, connect to one switch via RvMII @100FD and
> another via GMII @1000FD.  Having parameters as
> numeric limits this capability, but presumably a
> simple encoding scheme could be make it work. =20
>=20
> I'm sure you've already thought of this, though...

Yes, I was thinking about something like 0:1001 or 0:101 where 1 at the end=
 respects duplexity.
Putting it into devtree is good but we'll need to unify the interface first.

--
Sincerely, Vitaly

--Sig_l5tXeEa.fIRu4/uibq46Ey+
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFpQ6ZuOg9JvQhSEsRAtAjAJ0aFJ7WmEI5c9M125aySIv28t79lgCfV8Vp
zi9EwtiInif2iza2KMVNwPU=
=FawI
-----END PGP SIGNATURE-----

--Sig_l5tXeEa.fIRu4/uibq46Ey+--
