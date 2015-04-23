Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F0F001A0C9E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2015 01:38:06 +1000 (AEST)
Date: Thu, 23 Apr 2015 17:37:58 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: larrystotler@netscape.net
Subject: Re: [opensuse-ppc] HELP: test kernel patches on the real thing
Message-ID: <20150423153758.GB2795@katana>
References: <20150416135014.GE913@katana>
 <14cd96df76d-41ad-451c9@webprd-m95.mail.aol.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
In-Reply-To: <14cd96df76d-41ad-451c9@webprd-m95.mail.aol.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2015 at 08:43:24PM -0400, larrystotler@netscape.net wrote:
> -----Original Message-----
> From: Wolfram Sang <wsa@the-dreams.de>
> =20
> Quoted from the opensuse-ppc mailing list
>=20
> >I'm Wolfram Sang, maintainer of the I2C subsystem of the Linux Kernel. I
> >want to get rid of an ancient mechanism in the I2C core which was used i=
n the
> >2.4 era. There are only two users left; drivers for old Macintosh comput=
ers I
> >don't have access to. So, I tried to emulate the behaviour on an ARM boa=
rd and
> >wrote a replacement for the old mechanism which works fine here. Now, I =
wonder
> >if there are people willing to test these patches on the real thing? Thi=
s would
> >be much appreciated!
>=20
> I have a bunch of older macs but none currently has linux and/or a curren=
t version of linux on them. =20
>=20
> What models do you need tested?  Can you point me to a quick easy to inst=
all distro?  I usually use openSUSE but I think Fedora has a ppc port now a=
s well.
>=20
> I only have 32bit macs.  I have:
>=20
> iMac DV 400Mhz
> PowerMac G4 Digital Audio 466Mhz
> 2 - PowerMac G3 Blue & Whites (one with a G4 I THINK).
> PowerMac 9600
> PowerMac 9500
> PowerMac 6500
> PowerMac 6400
> PowerMac G3 All In One Beige.
> PowerBook G3 Wallstreet

Thank you for the offer! I am still in the process to find out which
machines are "windtunnel" and which ones are "keywest". I thought this
would be easy once I found some Mac owners, but seems I was wrong...

I'll let you know if one of your machines could become useful.

Thanks again,

   Wolfram


--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVORHVAAoJEBQN5MwUoCm2JSMQAIrsgxBWSvQygGLRkHMWe+gV
jyO1KCJ5JIRsmcg3+Bx2LsnVWyMp2gFCiZj7+cuqz0SCMP6Ev22fq4UOVfYKDFjb
mXqxENDjHyp3zPKLJbx/A98wdsF1H90vxUm5Jco+5Xu9FMhHqjObAHLTR0B8hkdq
zrZSL2WvlMkRzymullqXuns+9+aZrvZOWb9OWIq6jmoBJ2QSL9QNNZ4t+cGrzPKw
KEYkShAmJf7ZoqLEW8hRje+rEhQf7i9Qn88Sk/w0wrI8RSpU0/djF/TbEzjqobQe
YKKMxLo7dPziI7g8PdanYN7fmOG2jar0AV12QhcnWDnyTrJu5aZ4GE6EF7G58Wwc
PqizMnMtyzWJtYiWjncEMg+5dCQx/NnBy+9utod2oaXRtgYtt85VmzaHE6y+MNdb
Ee2qHZdU899b3/rtEEGJFX6LXmMo0Zw28hqBc+ZOZc0Egap5v6JI5dwQx/A9JF8a
UoBgrcfHHHcG9Un4/Q9k869H3RAZtRePRjwUS32+j1tb/mgipxCMqf3SqYs/86F5
h/3ekojW3zlOjOJn4ByVL7itOGwCiPmJFa6YG+QtJVidocB5Ln3bCmNCxOvfGY/T
2HOaDFw4UMCXg4JGABA6YBxeFpLwvXK85RjyD3Hb34sFoKsPmfqYnd9i3PK7D4nn
e3xGRu0X88SauImyGAN5
=yGgi
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
