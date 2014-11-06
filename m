Return-Path: <wsa@the-dreams.de>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4A3031A00B8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Nov 2014 20:54:55 +1100 (AEDT)
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D2DD61400A8
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Nov 2014 20:54:54 +1100 (AEDT)
Date: Thu, 6 Nov 2014 10:56:02 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] macintosh: therm_pm72: delete deprecated driver
Message-ID: <20141106095602.GB1333@katana>
References: <1415238358-2453-1-git-send-email-wsa@the-dreams.de>
 <1415240376.4925.2.camel@kernel.crashing.org>
 <20141106092551.GA1333@katana>
 <1415267404.4925.15.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
In-Reply-To: <1415267404.4925.15.camel@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Michael Ellerman <michaele@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06, 2014 at 08:50:04PM +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2014-11-06 at 10:25 +0100, Wolfram Sang wrote:
> > On Thu, Nov 06, 2014 at 01:19:36PM +1100, Benjamin Herrenschmidt wrote:
> > > On Thu, 2014-11-06 at 02:45 +0100, Wolfram Sang wrote:
> > > > The new driver is around for more than 2 years now, so the old one =
can
> > > > go. Getting rid of it helps the removal of the legacy .attach_adapt=
er
> > > > callback of the I2C subsystem.
> > > >=20
> > > > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> > >=20
> > > Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >=20
> > Thanks! I can take it via my I2C tree, but I'd think it makes more sense
> > if you take it via ppc? What do you prefer?
>=20
> Either works. These days Michael Ellerman handles the day to day
> maintainance of the powerpc tree so it's his choice but if you need this
> as a dependency on your subsequent API removal it's probably better that
> you take it.

No dependency, just a first step. Good to know, I will CC Michael on
(somewhen) upcoming patches, too.


--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUW0WyAAoJEBQN5MwUoCm2VK4P/1AuEM+FmErnLueXgR11CfXX
ihykPsAaY+r5fMu3CbhanNUxQX9zrmLT6zleK05L+hTlFmkWjyVNnr5EOD77Asy8
wg4JSX0nEtGUsgfcKLdvqu0x+dNIx+KsIlOgo+Tt8RnBlpSQ3KiyOGzSPrNNuGIq
590wEdqThQcC/S5OXBhW+6xmO1o8/pCvXPEzNxco6rUn6MJz4rsKeSl/VMGXIW4j
q4hIcy0SC0y/u9+Im7H4aYe3/Dy3T5NLgptDXianLEEWQyOodyCNHJi3oO2N2Usk
VlntH8T9p4OgUaLjylcqRyEudUVHZHWaoEVwr8j1hq/hjl299SxkBGlmvrjQoPcI
8bNf1z28uBG+jroFHIEZ6SkJx6cQB6/QKMw/gRKviH4sKwuid5H/L8poVJepiT00
3+Yf/nvcdsLhmo0Voqhfl6hfmL5k4on85Xxz/jkzXF2mREqLxDd6IE7ry7pgXtJY
xvnvz2IU7wd0ltAZyZB37I7NTnW8xx2Iusk/ZOLAXb6CqHAIzHkxqJ8ZIwjrzE3F
9cSaMyZxGtw+0tgoE+lj3JWgjbp+B+iH5Z6HNoH5YekRQHSpr+D+7SJoRKr4LVf4
XWOjKObrcOD7Q/XM/NEnJptV2RIo4dg6Kcbs/n7bPJ95R7Qnd6HfzkONqWukDDOv
b6hDNWjrelUhUvNrNwpv
=zTo7
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
