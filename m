Return-Path: <joerg@dorchain.net>
Received: from Redstar.dorchain.net (153-133-088-212.ip-addr.teresto.net
	[212.88.133.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 04EF867A45
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jan 2005 21:50:30 +1100 (EST)
Date: Thu, 20 Jan 2005 11:50:26 +0100
From: Joerg Dorchain <joerg@dorchain.net>
To: Guido Guenther <agx@sigxcpu.org>
Message-ID: <20050120105026.GG27077@Redstar.dorchain.net>
References: <20050119101448.GA1374@Redstar.dorchain.net>
	<20050120095546.GD5810@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z+pzSjdB7cqptWpS"
In-Reply-To: <20050120095546.GD5810@bogon.ms20.nix>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: nvram driver not possible as a module
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--z+pzSjdB7cqptWpS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 20, 2005 at 10:55:46AM +0100, Guido Guenther wrote:
> Hi Joerg,
> On Wed, Jan 19, 2005 at 11:14:48AM +0100, Joerg Dorchain wrote:
> > KConfig says CONFIG_NVRAM is possible as a module. Loading the module
> > fails because of an unknown symbol __alloc_bootmem. __alloc_bootmem is
> > marked __init. The obvious workaround is to compile the driver not as a
> > module, but how can this get really fixed?
> Does this help:
[...]

Most likely, if there wasn't a specific reason to use bootmem.

I'll try tonight.

Thanks,

Joerg

--z+pzSjdB7cqptWpS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFB74zyjY4+4PdzvOARAnD8AJ4tNHVkoTEM4xzBQravgZ9ahO3mjgCfR4d4
XNurJqmy4tc95+LAPJvmpls=
=cEeg
-----END PGP SIGNATURE-----

--z+pzSjdB7cqptWpS--
