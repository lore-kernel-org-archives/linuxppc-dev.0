Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id CEC6D67BEE
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Nov 2006 16:05:09 +1100 (EST)
Date: Thu, 30 Nov 2006 16:04:59 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: michael@ellerman.id.au
Subject: Re: [POWERPC] Allow xmon to build on legacy iSeries
Message-Id: <20061130160459.4f617199.sfr@canb.auug.org.au>
In-Reply-To: <1164848648.27764.2.camel@concordia.ozlabs.ibm.com>
References: <20061130114409.994a661e.sfr@canb.auug.org.au>
	<1164848648.27764.2.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__30_Nov_2006_16_04_59_+1100_2QBHOEWCwP6mzD7X"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__30_Nov_2006_16_04_59_+1100_2QBHOEWCwP6mzD7X
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 30 Nov 2006 12:04:08 +1100 Michael Ellerman <michael@ellerman.id.au> wrote:
>
> Why the ifdefs around the firmware check? Shouldn't it compile out to
> nothing for !ISERIES anyway?

I wasn't sure if it gets built for 32 bit or ppc and have broken them
before.  This was the patch is very obviously safe and is more likely to
get accepted ...

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__30_Nov_2006_16_04_59_+1100_2QBHOEWCwP6mzD7X
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFbmZ7FdBgD/zoJvwRAhvhAJwNuHXLmm7XO4a4AwbmkRggfEggzwCfd/on
50LBOLhnDYoD2ZN3Yp+XgTs=
=PyHH
-----END PGP SIGNATURE-----

--Signature=_Thu__30_Nov_2006_16_04_59_+1100_2QBHOEWCwP6mzD7X--
