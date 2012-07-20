Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 96CCD2C0370
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jul 2012 00:50:13 +1000 (EST)
Date: Sat, 21 Jul 2012 00:50:05 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: <sandeep@freescale.com>
Subject: Re: [PATCH][upstream] TDM Framework
Message-Id: <20120721005005.ace23a85cf3f0d2589990d00@canb.auug.org.au>
In-Reply-To: <1342787714-8415-1-git-send-email-sandeep@freescale.com>
References: <1342787714-8415-1-git-send-email-sandeep@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Sat__21_Jul_2012_00_50_05_+1000_apubb+8WiVM2ELCX"
Cc: Sandeep Singh <Sandeep@freescale.com>,
 Poonam Aggrwal <poonam.aggrwal@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Sat__21_Jul_2012_00_50_05_+1000_apubb+8WiVM2ELCX
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 20 Jul 2012 18:05:13 +0530 <sandeep@freescale.com> wrote:
>
> From: Sandeep Singh <Sandeep@freescale.com>
>=20
> TDM Framework is an attempt to provide a platform independent layer which=
 can
> offer a standard interface  for TDM access to different client modules.

I also wondered what TDM is.

> +++ b/drivers/tdm/Kconfig
> @@ -0,0 +1,18 @@
> +#
> +# TDM subsystem configuration
> +#
> +
> +menuconfig TDM
> +	tristate "TDM support"
> +	---help---
> +	  More information is contained in the directory <file:Documentation/td=
m/>,
                                                               ^^^^^^^^^^^^=
^^^^^^
> +	  especially in the file called "summary" there.
                                         ^^^^^^^

It might help if those files were included in the patch set ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Sat__21_Jul_2012_00_50_05_+1000_apubb+8WiVM2ELCX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJQCXAdAAoJEECxmPOUX5FEhXwP+wUqZ7l4M9FlcnkbIoiTtooR
xBcYrBrlt7LnbPrvIQXYmwQOrUojVOwRaw6FK62nEqCHfe2JcWkghIjCYhA8podO
FFqd0lE/MW7CiKrDlU/G7/yEhTZchkNHe2uiHRgGMle85VJS2fZvZ08ndLiXla5k
q+kHlpWssES5dxjabp9peE/Dld909chdn1jbPYBSoNSqVO21hR23aMJkoHslbC2z
sPgJhrUzCCh4AWted9Hr0NGM0SRwvoyXNsRtA3cDWu4Oy7aokyUkkomZ7zFvXwU/
8xy2qzO4vH2Vu9dJwhTYKhyTDgD3dbXgng/UWP7Rn3bvk9HALXYhKkX3edR4Jaou
BcGQ17vTvMvlWs7VO6gaV6wb77QYgAn1ozb/p4N0LbZh4vc+Nzd56AtyOUqfvVtm
RcUi6eGi2xh+MchRo4HPj/mglCrmZwbvHTBxCrK11HVKsOEbtRm6pCAygzaW3xT9
KAwI0B55gbbk0o6fusbOOnJSlUqkFaeBT8N5amHpRbyGsgf2gSIQ8cbA/w0n2XxO
phfq8kjmGVL6koQ0NpYIdEPcmk4a46vMsfknooLtc27/LJFp4pywxCsC5RvA9c5v
nkb1ZvuIYRhTL6tq/K2TzMk0AqaYmudIWS54qGkQl8xwR23F8z0JBML7L2ZN2MU1
0JCYJpbJYYAq6KavbgHX
=7zsL
-----END PGP SIGNATURE-----

--Signature=_Sat__21_Jul_2012_00_50_05_+1000_apubb+8WiVM2ELCX--
