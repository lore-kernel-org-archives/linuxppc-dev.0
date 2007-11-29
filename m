Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Increase the upper bound on NR_CPUS.
From: Michael Ellerman <michael@ellerman.id.au>
To: Tony Breeds <tony@bakeyournoodle.com>
In-Reply-To: <20071129042314.GN24243@bakeyournoodle.com>
References: <20071129041603.GM24243@bakeyournoodle.com>
	<1196309836.7875.3.camel@concordia>
	<20071129042314.GN24243@bakeyournoodle.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-X+/NbHj19gTk8V12Ed/L"
Date: Thu, 29 Nov 2007 15:44:13 +1100
Message-Id: <1196311453.7875.9.camel@concordia>
Mime-Version: 1.0
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-X+/NbHj19gTk8V12Ed/L
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Thu, 2007-11-29 at 15:23 +1100, Tony Breeds wrote:
> On Thu, Nov 29, 2007 at 03:17:16PM +1100, Michael Ellerman wrote:
> > On Thu, 2007-11-29 at 15:16 +1100, Tony Breeds wrote:
> > > Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
> > >=20
> > > ---
> > > why not?
> >=20
> > How big is say a pseries_defconfig with NR_CPUS =3D 1024 ?
>=20
> This is a ppc64_defconfig, with a couple of extra patches, and
> NR_CPUS=3D1024
>=20
> tony@Sprygo:~/scratch/working$ size ../working_out/arch/powerpc/boot/zIma=
ge.{pmac,pseries,iseries} ../working_out/vmlinux
>    text    data     bss      dec     hex filename
> 3697092    5356   48232  3750680  393b18 ../working_out/arch/powerpc/boot=
/zImage.pmac
> 3697092    5356   48232  3750680  393b18 ../working_out/arch/powerpc/boot=
/zImage.pseries
> 8101340 4994176  815544 13911060  d44414 ../working_out/arch/powerpc/boot=
/zImage.iseries
> 8101340 4994176  815544 13911060  d44414 ../working_out/vmlinux

OK, not too bad for the zImage, but the vmlinux has grown a bit, we
obviously have lots of foo[NR_CPUS].

NR_CPUS =3D 32 vs 1024

   text    data     bss     dec     hex filename
7889287 1786256  529248 10204791         9bb677 vmlinux
7901531 4946864  814432 13662827         d07a6b vmlinux

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-X+/NbHj19gTk8V12Ed/L
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHTkOddSjSd0sB4dIRAhGQAKCVK+DQAbjiuFchF5YwKxb0FFwtEQCfaAxk
CJNF0tT7kmm6/Ls03tjv6m4=
=ttFR
-----END PGP SIGNATURE-----

--=-X+/NbHj19gTk8V12Ed/L--
