Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 4/4] Add irq debugfs and virq_mapping for getting the
	virq to irq host's hwirq mapping list.
From: Michael Ellerman <michael@ellerman.id.au>
To: Zhang Wei <wei.zhang@freescale.com>
In-Reply-To: <11740199152381-git-send-email-wei.zhang@freescale.com>
References: <11740199151814-git-send-email-wei.zhang@freescale.com>
	<11740199152595-git-send-email-wei.zhang@freescale.com>
	<11740199154116-git-send-email-wei.zhang@freescale.com>
	<11740199152381-git-send-email-wei.zhang@freescale.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-kD6SpV7t6VplRPZM6Wxp"
Date: Tue, 20 Mar 2007 14:03:40 +1100
Message-Id: <1174359820.10827.8.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: paulus@samba.org, r54964@freescale.com, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-kD6SpV7t6VplRPZM6Wxp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-03-16 at 12:38 +0800, Zhang Wei wrote:
> This patch adds 'irq' directory into the root debugfs and virq_mapping fo=
r getting the virq to
> irq host's hwirq mapping list.

Minor nit. Should we be creating a 'powerpc' directory first, and
putting the 'irq' file under that? Otherwise we risk clashing with some
generic code that creates a file called 'irq' in debugfs.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-kD6SpV7t6VplRPZM6Wxp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBF/08MdSjSd0sB4dIRAm/LAKC56W2Abq4DrUEVZQ++1cmQjWozewCgr4i9
yrho+P251ge9PBUHjM5b7tU=
=fl6V
-----END PGP SIGNATURE-----

--=-kD6SpV7t6VplRPZM6Wxp--
