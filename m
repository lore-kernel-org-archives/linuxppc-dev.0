Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 6/8] Explictly undefine DEBUG in
	arch/powerpc/platforms/pseries/eeh_driver.c
From: Michael Ellerman <michael@ellerman.id.au>
To: Tony Breeds <tony@bakeyournoodle.com>
In-Reply-To: <c5fdfe03bcac5d6964b6712a2a15ab0edc12ce83.1217476198.git.tony@bakeyournoodle.com>
References: <cac86e24e42bd05087b43663b687f04df91326ba.1217476198.git.tony@bakeyournoodle.com>
	<c5fdfe03bcac5d6964b6712a2a15ab0edc12ce83.1217476198.git.tony@bakeyournoodle.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-1YTDiTxZzs6GL3W7gscS"
Date: Thu, 31 Jul 2008 14:53:30 +1000
Message-Id: <1217480010.1487.38.camel@localhost>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-1YTDiTxZzs6GL3W7gscS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-07-31 at 13:51 +1000, Tony Breeds wrote:
> print_device_node_tree() is guarded by DEBUG but even when declared, it
> isn't called.  Explicitly undefine DEBUG as you'll need to modify this
> file anyway to use print_device_node_tree().

Please don't, it breaks CONFIG_PPC_PSERIES_DEBUG.

cheers

/me refrains from ranting about stupid -Werror

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-1YTDiTxZzs6GL3W7gscS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIkUVKdSjSd0sB4dIRAsckAJ0cJ4J2wr0Q17EumKNFScJtv2d87ACglM8P
yCB6ztwXp6tKthire7Jp3nU=
=nWMY
-----END PGP SIGNATURE-----

--=-1YTDiTxZzs6GL3W7gscS--
