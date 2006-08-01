Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH][2/2] RTAS MSI
From: Michael Ellerman <michael@ellerman.id.au>
To: Jake Moilanen <moilanen@austin.ibm.com>
In-Reply-To: <1154379714.29826.396.camel@goblue>
References: <1154024154.29826.229.camel@goblue>
	<1154024834.29826.240.camel@goblue>
	<1154320382.19883.26.camel@localhost.localdomain>
	<1154379714.29826.396.camel@goblue>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-wdYzBWT6fM+OBS34PVDs"
Date: Wed, 02 Aug 2006 09:26:31 +1000
Message-Id: <1154474791.3987.7.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, PaulMackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-wdYzBWT6fM+OBS34PVDs
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-07-31 at 16:01 -0500, Jake Moilanen wrote:
> Here's version 3 which addresses all of Michael's comments.

Looks good, nice one.

I was thinking about disable, can you give us any more details on the
firmware bug that is blocking that?

I'm not sure what disable really needs to do, but I think drivers might
expect it to set dev->irq back to the LSI value, even if we don't free
anything internally. Not sure.

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-wdYzBWT6fM+OBS34PVDs
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEz+MndSjSd0sB4dIRAhSZAKCgnU1rIjxnhekleba8AW8rJI7JVgCeIr/o
w9FVN7D0uXELXFvakB58GgA=
=Vv60
-----END PGP SIGNATURE-----

--=-wdYzBWT6fM+OBS34PVDs--
