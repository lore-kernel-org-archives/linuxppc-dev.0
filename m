Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] hvc_console polling mode timer backoff
From: Michael Ellerman <michael@ellerman.id.au>
To: will_schmidt@vnet.ibm.com
In-Reply-To: <1176754943.28514.133.camel@farscape.rchland.ibm.com>
References: <97762565fcdccbf85d1d04cd055b1197@bga.com>
	<1176754943.28514.133.camel@farscape.rchland.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Bd0svYhrpHTlDiX8y619"
Date: Tue, 17 Apr 2007 10:13:19 +1000
Message-Id: <1176768799.5810.4.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, ppcdev <linuxppc-dev@ozlabs.org>,
	Milton Miller <miltonm@bga.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-Bd0svYhrpHTlDiX8y619
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-04-16 at 15:22 -0500, Will Schmidt wrote:
> On Sat, 2007-14-04 at 14:42 -0500, Milton Miller wrote:
> > Michael Ellerman wrote:
>=20
> > Did you consider making MAX_TIMEOUT a module parameter?   It could then
> > be changed at runtime through /sys/modules/.
>=20
> Yup, considered that.
>=20
> Decided against it, for no reason other than "keeping it simple".  Not
> sure that extra function does more good or bad.=20
>=20
> Who really wants the ability to tune their console timeout value
> anyway? :-)    hrm, maybe thats a silly question.

Patch looks good. But I think it's overkill to have a parameter.

The range of useful values for MAX_TIMEOUT is 0 to perhaps 5000, it's
not like there's a vast array of possible values that people might
sensibly want to use. This is one of those places where we should just
pick a good value and stick with it.

If people really think we've got the wrong value, patches welcome.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-Bd0svYhrpHTlDiX8y619
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBGJBEedSjSd0sB4dIRAut2AJ9fyPzQbwnaQXHRD0SI4zbAdaEy0wCfYRQ3
Us3+IJf7NcfS4qAvDfpVI/A=
=n1+n
-----END PGP SIGNATURE-----

--=-Bd0svYhrpHTlDiX8y619--
