Return-Path: <michael@ellerman.id.au>
Subject: Re: [BUILD_FAILURE] linux-next: Tree for May 20 - build failure on
	powerpc
From: Michael Ellerman <michael@ellerman.id.au>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
In-Reply-To: <4832AE2B.2060208@linux.vnet.ibm.com>
References: <20080520202706.58791923.sfr@canb.auug.org.au>
	<4832AE2B.2060208@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-LLFHNlZaP4xOX1zKXEa+"
Date: Tue, 20 May 2008 22:44:37 +1000
Message-Id: <1211287477.7960.3.camel@localhost>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-LLFHNlZaP4xOX1zKXEa+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-05-20 at 16:25 +0530, Kamalesh Babulal wrote:
> Hi Stephen,
>=20
> The next-20080520 kernel build fails on powerpc, when build the randconfi=
g with
> build error message

>   CC      arch/powerpc/kernel/prom_init.o
>   CALL    arch/powerpc/kernel/prom_init_check.sh
> Error: External symbol 'kernstart_addr' referenced from prom_init.c
> make[1]: *** [prom_init_check] Error 1
> make: *** [arch/powerpc/kernel] Error 2

It's broken in upstream actually, for RELOCATABLE && FLATMEM.

Patch on the way.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-LLFHNlZaP4xOX1zKXEa+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIMse1dSjSd0sB4dIRAsJJAJ0bhuE4VKu6SoIC/KnVad/0DrzUIwCcCw8d
uHZwZIlAg6VikNCmCg1jWdo=
=gDK1
-----END PGP SIGNATURE-----

--=-LLFHNlZaP4xOX1zKXEa+--
