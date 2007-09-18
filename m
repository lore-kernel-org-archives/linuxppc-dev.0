Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 1F649DDDCA
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 14:26:20 +1000 (EST)
Date: Tue, 18 Sep 2007 14:26:06 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 1/3] usb: add device-tree-aware ehci driver
Message-Id: <20070918142606.06477b04.sfr@canb.auug.org.au>
In-Reply-To: <46EEC4AB.2030707@ru.mvista.com>
References: <20070917125039.GA29525@ru.mvista.com>
	<20070917125543.GA29584@ru.mvista.com>
	<20070917232809.1221acd9.sfr@canb.auug.org.au>
	<46EEC4AB.2030707@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__18_Sep_2007_14_26_06_+1000_xetVR_VhhzcX1g2G"
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__18_Sep_2007_14_26_06_+1000_xetVR_VhhzcX1g2G
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Sep 2007 22:17:15 +0400 Valentine Barshak <vbarshak@ru.mvista.co=
m> wrote:
>
> Looks like we'll need a patch that replaces asm/prom.h and=20
> asm/of_platform.h with linux/of.h and linux/of_platform.h
> in other drivers.

Yeah, but at the moment I am just stopping the infection spreading :-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__18_Sep_2007_14_26_06_+1000_xetVR_VhhzcX1g2G
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG71NiTgG2atn1QN8RAmGPAJ9OhqNRYqLe6CvVBqmPsDvhdp7z+QCdEAtB
PQ9pos8g9BntFH4i2Tj0ixU=
=Qldh
-----END PGP SIGNATURE-----

--Signature=_Tue__18_Sep_2007_14_26_06_+1000_xetVR_VhhzcX1g2G--
