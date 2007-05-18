Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 1E931DDE9F
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 10:09:14 +1000 (EST)
Date: Fri, 18 May 2007 10:09:08 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 4/5] powerpc: Add of_register_i2c_devices().
Message-Id: <20070518100908.aa803cc6.sfr@canb.auug.org.au>
In-Reply-To: <20070517143856.GD29795@ld0162-tx32.am.freescale.net>
References: <20070517143856.GD29795@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__18_May_2007_10_09_08_+1000_.GVF2=cpkRNl3cvP"
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__18_May_2007_10_09_08_+1000_.GVF2=cpkRNl3cvP
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 17 May 2007 09:38:56 -0500 Scott Wood <scottwood@freescale.com> wrote:
>
> +		addr = get_property(node, "reg", &len);

get_property has been replaced by of_get_property.

> +		name = get_property(node, "compatible", NULL);

ditto.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__18_May_2007_10_09_08_+1000_.GVF2=cpkRNl3cvP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGTO6oFdBgD/zoJvwRAiyIAKCND5GY3D6F8ZlwYNGPuRDNqE/JYQCdFng6
DM2CiGgKB3Jl1lDeq0UKz7Y=
=mlXe
-----END PGP SIGNATURE-----

--Signature=_Fri__18_May_2007_10_09_08_+1000_.GVF2=cpkRNl3cvP--
