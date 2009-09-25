Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 02D05B7B7C
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2009 16:28:20 +1000 (EST)
Date: Fri, 25 Sep 2009 16:28:09 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: powerpc: Move /proc/ppc64 to /proc/powerpc and add symlink
Message-Id: <20090925162809.3d78d197.sfr@canb.auug.org.au>
In-Reply-To: <1253856553.7103.513.camel@pasglop>
References: <1253856553.7103.513.camel@pasglop>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__25_Sep_2009_16_28_09_+1000_tDmfHVNGwV/mCpU5"
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__25_Sep_2009_16_28_09_+1000_tDmfHVNGwV/mCpU5
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben,

On Fri, 25 Sep 2009 15:29:13 +1000 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
>  obj-$(CONFIG_PPC_970_NAP)	+=3D idle_power4.o
>  obj-$(CONFIG_PPC_OF)		+=3D of_device.o of_platform.o prom_parse.o
>  obj-$(CONFIG_PPC_CLOCK)		+=3D clock.o
> -procfs-$(CONFIG_PPC64)		:=3D proc_ppc64.o
> +procfs-y			:=3D proc_powerpc.o
>  obj-$(CONFIG_PROC_FS)		+=3D $(procfs-y)

Surely just:

obj-$(CONFIG_PROC_FS)		+=3D proc_powerpc.o

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__25_Sep_2009_16_28_09_+1000_tDmfHVNGwV/mCpU5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkq8YvkACgkQjjKRsyhoI8za2ACggaL4YGpr+0L1UJ3C32H5GDwc
uPsAn3EqhEk5vi1VJbNuDn3lGQWw6w0z
=3Gur
-----END PGP SIGNATURE-----

--Signature=_Fri__25_Sep_2009_16_28_09_+1000_tDmfHVNGwV/mCpU5--
