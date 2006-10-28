Return-Path: <michael@ellerman.id.au>
Subject: Re: Is get_property() correct?
From: Michael Ellerman <michael@ellerman.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <528646bc0610280038x421014bdxde263c5399907fcb@mail.gmail.com>
References: <528646bc0610272341s3c655ebbn785b373f148f6174@mail.gmail.com>
	<1162020235.25682.124.camel@localhost.localdomain>
	<528646bc0610280038x421014bdxde263c5399907fcb@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-6o0C0Ou33BPNVkva62zK"
Date: Sat, 28 Oct 2006 19:08:23 +1000
Message-Id: <1162026503.14822.5.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-6o0C0Ou33BPNVkva62zK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-10-28 at 01:38 -0600, Grant Likely wrote:
> On 10/28/06, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > On Sat, 2006-10-28 at 00:41 -0600, Grant Likely wrote:
> >
> > Well considering that we don't know the type of the property value, the
> > best we can do is return a pointer to it ...
> >
> > The comment might want an update, though it never stroke me as confusin=
g
> > but heh :)
>=20
> No, it's not confusing.  Both the comment and the code are correct.  I
> just forgot how to read code.  :(

But at least now we're all _sure_ they're correct, some good still
done :)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-6o0C0Ou33BPNVkva62zK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFQx4HdSjSd0sB4dIRAv/NAJ0VUgLAiPUaEe/LLRhrxCE1f8ECNgCfYSNn
KozMah0VgDfTqNWm+//b6ec=
=9iOd
-----END PGP SIGNATURE-----

--=-6o0C0Ou33BPNVkva62zK--
