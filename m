Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0E8161A0CDB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Dec 2014 00:49:49 +1100 (AEDT)
Date: Tue, 23 Dec 2014 14:49:40 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Valentin Longchamp <valentin.longchamp@keymile.com>
Subject: Re: [PATCH] i2c-qoriq: modified compatibility for correct prescaler
Message-ID: <20141223134940.GA1925@katana>
References: <1414537731.23458.120.camel@snotra.buserror.net>
 <5450AC85.40302@keymile.com> <20141113003418.GE2062@katana>
 <5465B285.7070005@keymile.com> <20141114082832.GA2180@katana>
 <1416274083.15957.96.camel@freescale.com>
 <20141125181347.GC9716@katana>
 <1416966097.15957.171.camel@freescale.com>
 <54899FB4.9010207@keymile.com> <54996CB5.8030808@keymile.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
In-Reply-To: <54996CB5.8030808@keymile.com>
Cc: Linux device trees <devicetree@vger.kernel.org>,
 danielle.costantino@gmail.com, "Boschung,
 Rainer" <Rainer.Boschung@keymile.com>, "Brunck,
 Holger" <Holger.Brunck@keymile.com>, Linux I2C <linux-i2c@vger.kernel.org>,
 Scott Wood <scottwood@freescale.com>,
 Linux PowerPC Kernel <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2014 at 02:23:01PM +0100, Valentin Longchamp wrote:
> Wolfgang, Scott,

Wolfram, please.

> > What is then the agreement here ? Add a clock-div to the device trees ?=
 Or do
> > something similar to  mpc_i2c_get_sec_cfg_8xxx() ?
> >=20
> > I think the clock-div property is better according to Freescale's AN 29=
19
> > section 3.1 Source clock. All the source clocks are fixed (with a clock=
-div of 2
> > in case of mpc8536/43/45/47/48/67/68/72, plus p2020) except for the mpc=
8533/44
> > where it can be 2 or 3, and that's what mpc_i2c_get_sec_cfg_8xxx() dete=
rmines.
> >=20
> > So mpc_i2c_get_sec_cfg_8xxx() should remain the exception and the other
> > prescaler values should be derived from an additional clock-div that mu=
st be
> > added in the respective device trees (at least for the qoriq devices, b=
ecause
> > for instance mpc8543 already has the correct prescaler thanks to
> > mpc_i2c_data_8543 from i2c-mpc.c).
> >=20
>=20
> Do you have an opinion on the above ?

I don't mind. I'll leave it to PowerPC experts to judge if a new binding
is apropriate or reading SVR is the way to go. If it is going to be a
new binding, then please look around before if there is already
something similar around...


--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUmXL0AAoJEBQN5MwUoCm2CcgQAKV5sdN8lTA+hbf/QsQO7ubF
Ia+rTM8zopsChRAA1VwAj9qU3LSUnSxHraT+2+lOxr1UwERvacMRcTpEWzWHDABM
8O+K/QDu+FhAsarFvcBs/qgUrSRka9nesPYIs6DGVo0ggK5dN9ZEvsJCyrJIvbRa
dOCZbVHKhAfrXHSuGr5UrLuHwOvdGZr6L0giCxNM00riU1RxFYKnNnNXH6JVhfDG
ztjUjelgpUiPW0pMikpcfSxI/KTFxe81j4wIM7tD+foaSPusBEsTpFPdVvkZWvRH
MV6YQPPO30lLh7jjZp7T5RAvrsRsJ9kiM3OvADnWwGGXvaGtRMvvEN8RBr2Do/MF
HJux3tdV1m6aVcyUZqQZXEkOikNsBKvbPSl+oS4tpmoH3x2JeXq3eyVfh3/ovwK2
EXqgTvhXKRecm3Rj7qjsqfUO09KTZnxrqVBcntViSh3IbF/06qpp9q5ago4tH9vp
aTipo6RUpVRgk8dUCY+j/sbBXJ7G9abHWeZqZCxYUtpJYuDUQwytqNosZA7me0YY
mCtqgXoOsoXzdV9TLh4pQRscMhInDGiAN50HsxLonrx2IobNWr30GCZanoMxeh2m
noKZAvY13Tedl6fWpjIuJ9Pyx9Dcd3nQnvRoXrWrdObqJfZh4pQhcBgE1/ii3SSt
eY4WVC0kuiry2wHpZr/B
=qYRd
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
