Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id A75F4DDF6E
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 16:15:22 +1100 (EST)
Date: Wed, 31 Jan 2007 08:15:19 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/3] [POWERPC] Fix kernel build errors for mpc8272ads
	and mpc8560ads
Message-ID: <20070131081519.6af307ce@localhost.localdomain>
In-Reply-To: <20C6E81C-CB34-461A-B1CD-FF302D83E2AB@kernel.crashing.org>
References: <20070130230711.21111.52924.stgit@localhost.localdomain>
	<20070130230859.21111.39370.stgit@localhost.localdomain>
	<F739E1EE-3BA6-428D-8C96-AB09E1B9773B@kernel.crashing.org>
	<20070131073947.67520c16@localhost.localdomain>
	<20C6E81C-CB34-461A-B1CD-FF302D83E2AB@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_8wqpg31hvS9scqa/yQpp+P6";
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

--Sig_8wqpg31hvS9scqa/yQpp+P6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Jan 2007 22:41:57 -0600
Kumar Gala wrote:

>=20
> On Jan 30, 2007, at 10:39 PM, Vitaly Bordug wrote:
>=20
> > On Tue, 30 Jan 2007 17:41:14 -0600
> > Kumar Gala wrote:
> >
> >>
> >> On Jan 30, 2007, at 5:09 PM, Vitaly Bordug wrote:
> >>
> >>>
> >>> Recent update of asm-powerpc/io.h caused cpm-related stuff to
> >>> break in the
> >>> current kernel. Current patch fixes it, as well as other
> >>> inconsistencies
> >>> expressed, that do not permit targets from working properly:
> >>>
> >>> - Updated dts with a chosen node with interrupt controller,
> >>
> >> Why do we need this?  I'm not aware of any other boards having to
> >> set this?
> >
> > Correct. In fact I dropped that change, after "dtc -f"  discussion =20
> > but forgot
> > to clear this line from desc. Will resend in a few minutes, thanks =20
> > for pointing it out.
>=20
> I think the 8272 dts still had the node in it.
>=20
No it does not, in the latest resubmit series at least - just have checked.

--
Sincerely, Vitaly

--Sig_8wqpg31hvS9scqa/yQpp+P6
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFwCXouOg9JvQhSEsRAjNxAJ483LKwcIU7bHwzogdW0A2fZzRKtgCeLjQK
+5lkwY2nbX80MwmDDiq+5aM=
=Umx7
-----END PGP SIGNATURE-----

--Sig_8wqpg31hvS9scqa/yQpp+P6--
