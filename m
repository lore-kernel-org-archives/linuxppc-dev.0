Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 27F8EDDE19
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Dec 2007 13:52:15 +1100 (EST)
Date: Mon, 24 Dec 2007 13:52:08 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>
Subject: Re: drivers/net/iseries_veth.c dubious sysfs usage
Message-Id: <20071224135208.2a29ffc0.sfr@canb.auug.org.au>
In-Reply-To: <20071213070829.GA13764@kroah.com>
References: <20071205093054.GA23229@kroah.com>
	<1196853031.6759.7.camel@concordia>
	<20071205214103.GA7074@kroah.com>
	<1196912898.14754.13.camel@concordia>
	<20071213070829.GA13764@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__24_Dec_2007_13_52_08_+1100_.68Y0mCcCxgBrWHK"
Cc: linux-kernel@vger.kernel.org, David Gibson <dwg@au1.ibm.com>,
	linuxppc-dev@ozlabs.org, "Kyle A. Lucke" <klucke@us.ibm.com>,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__24_Dec_2007_13_52_08_+1100_.68Y0mCcCxgBrWHK
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Wed, 12 Dec 2007 23:08:29 -0800 Greg KH <greg@kroah.com> wrote:
>
> Hm, ok, it's odd as you are the only driver in the whole tree doing
> something like this, but it seems semi-resonable, so I can't complain :)
>=20
> I'll fix the core up to allow you to do this, thanks for the
> explanation.

So if this "seems semi-reasonable", why was the result
gregkh-driver-driver-add-driver_add_kobj-for-looney-iseries_veth-driver
containing "Hopefully no one uses this function in the future and the
iseries_veth driver authors come to their senses so I can remove this
hack..." as part of its comment.  If you expect respect, you need to
treat others the same way ...

If what the driver writers are doing is "looney" (in your opinion), then
please describe a better way of doing what they are trying to do.
Sometimes, if people have to abuse the infrastructure, it is possible that
the infrastructure is lacking?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Mon__24_Dec_2007_13_52_08_+1100_.68Y0mCcCxgBrWHK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHbx7dTgG2atn1QN8RAhWEAJ4ymGNuhmuHByAVk/VK3jh+K6UBYQCglLBB
WQQ4PCkw2he5ftxow1xrR2s=
=nkiS
-----END PGP SIGNATURE-----

--Signature=_Mon__24_Dec_2007_13_52_08_+1100_.68Y0mCcCxgBrWHK--
