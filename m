Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 34528679FF
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2006 00:17:59 +1100 (EST)
Date: Fri, 24 Mar 2006 00:17:48 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 3/4] powerpc: Rename and export ppc64_firmware_features
Message-Id: <20060324001748.5ae0c190.sfr@canb.auug.org.au>
In-Reply-To: <20060323123348.4815367C10@ozlabs.org>
References: <1143117144.850591.48752080269.qpush@concordia>
	<20060323123348.4815367C10@ozlabs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__24_Mar_2006_00_17_48_+1100_kkJGABHXCvHY3GYB"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__24_Mar_2006_00_17_48_+1100_kkJGABHXCvHY3GYB
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Mar 2006 23:33:11 +1100 Michael Ellerman <michael@ellerman.id.au=
> wrote:
>
> +EXPORT_SYMBOL_GPL(powerpc_firmware_features);

This should be in firmware.c not a header file.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__24_Mar_2006_00_17_48_+1100_kkJGABHXCvHY3GYB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEIqADFdBgD/zoJvwRAkJgAJ9mcaQDF3GHzfHuNwyGT8COtULm9gCgkLrc
3dv7T0SYdkhm7tEVJi2CnS8=
=RWKX
-----END PGP SIGNATURE-----

--Signature=_Fri__24_Mar_2006_00_17_48_+1100_kkJGABHXCvHY3GYB--
