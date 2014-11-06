Return-Path: <wsa@the-dreams.de>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6F1E11A030E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Nov 2014 20:24:47 +1100 (AEDT)
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F0E3C1400A6
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Nov 2014 20:24:46 +1100 (AEDT)
Date: Thu, 6 Nov 2014 10:25:51 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] macintosh: therm_pm72: delete deprecated driver
Message-ID: <20141106092551.GA1333@katana>
References: <1415238358-2453-1-git-send-email-wsa@the-dreams.de>
 <1415240376.4925.2.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
In-Reply-To: <1415240376.4925.2.camel@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06, 2014 at 01:19:36PM +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2014-11-06 at 02:45 +0100, Wolfram Sang wrote:
> > The new driver is around for more than 2 years now, so the old one can
> > go. Getting rid of it helps the removal of the legacy .attach_adapter
> > callback of the I2C subsystem.
> >=20
> > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
>=20
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Thanks! I can take it via my I2C tree, but I'd think it makes more sense
if you take it via ppc? What do you prefer?


--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUWz6fAAoJEBQN5MwUoCm25/UQALWcb13rNgmuzfD0hl1G3WXu
PoOrVfSJCfrj0igqR/6avBKrHTwuQdZ/LLWOuOyPb7teTYq/2mU1YOyhHa29E528
mIDgQ/FfCFICWeF65Mj7tft2AXZcRrkwhpCLFI6GXVBClXK/EcgD/qKmebPZliN0
BvMNkke3A1TSerfoMXuzqAvPZSOoe/i6z4Xw60G0vvoSMwFISUgAGuHGvMYPOXJY
VOqroQmAEH0Py4+6x/H9rEYTA1rxz23FpsopmAlut1WeXRQWe6zPeV2hN0U3mlDS
Ev/Z89D3wpwc9f+7jiVCcoBRwUs9/DTMzzWCdMfZgc4dHOwDqYiG02aOdS6IkHiA
QXQAfhzPT65YilS18rQWLyQLwAIskmGG+f58DjOAetpmRWe/jN8Q828zYP/7Ffsi
u2/MshqH9PVo7GzayzN6UrIGwbOC9IeY94I6ALwYKCGpQDvUUEbxoqYmKuvKRhwN
5weSFyRAtwzESPvvUCX9pY+9vKLVH4OwRdSw1RGh1Q9OiubCAIlAfn7s4fAYFI0S
OB/Qn6pjhDCjivQNbiVagY3Ky3ZdxSaKzDl7Fe7Hl0NibYT1RU2qr5Zd70VQe7tm
G1DwpPG+lPS1/G2ArzeDUxG9Yev3tsFk03RuCaEohR/ThX9jdA8sgpwn14uzgkiw
i8TaS11KDb5/sHyxep3w
=+a/w
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
