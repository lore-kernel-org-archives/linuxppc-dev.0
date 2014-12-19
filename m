Return-Path: <wsa@the-dreams.de>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 771CA1A04CD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Dec 2014 03:22:04 +1100 (AEDT)
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D31A51400A0
 for <linuxppc-dev@ozlabs.org>; Sat, 20 Dec 2014 03:22:02 +1100 (AEDT)
Date: Fri, 19 Dec 2014 17:21:46 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] macintosh: therm_pm72: delete deprecated driver
Message-ID: <20141219162146.GA3632@katana>
References: <1415238358-2453-1-git-send-email-wsa@the-dreams.de>
 <1415240376.4925.2.camel@kernel.crashing.org>
 <20141106092551.GA1333@katana>
 <1415267404.4925.15.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
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


--bp/iNruPH9dso1Pn
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

So, I haven't seen this coming in via ppc. I am going to send another
pull request to Linus tomorrow and will include it unless somebody
objects soon.


--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUlFCaAAoJEBQN5MwUoCm2cxwP/0hreVNbRZVYWTeEwXRl6PMe
mTVz5+uiVZgH4hk1iqlTTMMkf5o4rvG4M2Bk5o1a8nOKl1DeURiif+PFO4QffjEd
HmDQJb81+AV0eDuh056RlWGvJrzCNPjaayH/TdPKkGBGMn2qfF1i/DUJXv733oTk
ncc36SNXH8GGHoPfPUj7AfCK7j7Z1/F2OJA5WMScirG4dsl3pY+7qduBuvwVvmS5
/F1hXnHsautcKaoob5GfYVArns9v3x9sRLHS5qdRopnJzWqeAVExBwQGDOuJJEw/
hHJ6lH6REn1FUjQ2bUX1BBREFDFUnQsYfgPn6iH6JyfdFsTPDba/uRy1UPePZyd5
rHkHAcsqKBc2sZpu9gEuzB4XsiUJUZOoyZAf77fZ4/XMwTEtFhxC04b9z4lD/ou2
5bU25iBGwYDPvwl/7aB+y9Vi34ytHe2qOndOEvEipdZD2MGEln47avz06+L/Qizi
6MPqTbAfyIUhP32kJYI87N+6S2z47EaOgjdUQd6RnTt0pu8vBVJuzNxbo1awBXWg
gTEre7AwXP4wTRz5RgvgjMz0hSCyr9VG9EEhBkBVKdtnOr/i2v5GYJS2GDNAZXzR
1NRsw5h2IC0sHjFj99RLFxq8PgJmta9Pmg3wDZTqHEdmXKdficdS4ZRWi5fpyrsB
I8ZeXmLx6gcJLR8v+6KM
=wMth
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
