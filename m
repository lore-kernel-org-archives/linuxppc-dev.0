Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 392FC1A1F29
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Nov 2014 19:27:21 +1100 (AEDT)
Date: Fri, 14 Nov 2014 09:28:33 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Valentin Longchamp <valentin.longchamp@keymile.com>
Subject: Re: [PATCH] i2c-qoriq: modified compatibility for correct prescaler
Message-ID: <20141114082832.GA2180@katana>
References: <1413538026-15739-1-git-send-email-valentin.longchamp@keymile.com>
 <1414537731.23458.120.camel@snotra.buserror.net>
 <5450AC85.40302@keymile.com> <20141113003418.GE2062@katana>
 <5465B285.7070005@keymile.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
In-Reply-To: <5465B285.7070005@keymile.com>
Cc: Linux device trees <devicetree@vger.kernel.org>, "Boschung,
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


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >=20
> > If we're going to change the device tree I'd rather just add a property
> > to say what the prescaler is.
>=20
>  We would however, leave the boards' device trees that use things like
> "fsl,mpc8543-i2c" as is and introduce the prescaler for the others requir=
ing it.
>=20
>=20
> Now the drawback is that the driver would require a change, to parse this
> prescaler new prescaler property. Would this be OK from your point of view
> Wolfram ? If yes, I will send the patches for it.

I don't think it is OK. I'd think it can be deduced from the compatible
property. Let's ask the DT experts here. I'll follow their suggestion.


--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZb0wAAoJEBQN5MwUoCm2SfoQAKIprVmGbqkdES+FOABKUcRc
dKTGxZW2obmcHVlE2BmXeR3hrzGYWj+1JAT0UYCkFqdCUwSb8qt4zOu7+41MJiW3
UPgJpIdixzqNVqXxBa8pdg3tsKEtZ5DjOHZ1+ZhTfe4HO4wkPZLE8mVMUOUoo7DY
WlRFFnd2hJeLxoSSt6xJZWJ0L6KDVPUK0VW4zpqocLvCJ1q8xYPvFRahF0Q9KSpm
h0QifBJJ0DakuCtGkK6nmd8n8A+XYT2YX2JAA2Xnl85AQ1gujtR3CP0rigKH/o0z
qLSkzPnICLg0hMXqFwKG8F2RriX62LSR+ogViTBRtQ4zEO+XMM6dGUrKD6eiI11R
wkQovbV2f10QLO7+j1sLYYVfkgIwxByzoDowpGE/wKcZ1CYZU62C9+au+tS+yjHL
3FcFZymLkhoHWHKk1W7c66TkUC0nrj8f3HfRvwLxb+h3dgIvEJW+Rz6UdOOaPsuX
GpcIjbcKiWzSOT6dHCMkI9M4AL2thp+NwroT6LQK/wm54jI1C9KMmHwfiOgq7IIK
F3nhsDqi8i56T5NzbX8V1SWqj2hiQ/qX7Nhn2+MT/9JojMaunDyz3riL6kKr6V57
lFhixLqknLpEqB1gX0u29AdLb9neuSjqXtpVfLG6JMO1Oev2sa1xFlO4mKtCSMIl
J1SJRzCHQeiiBJBOSqJ0
=fEBN
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
