Return-Path: <maxime.ripard@free-electrons.com>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xC6fz3qxPzDrTB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 16:33:31 +1000 (AEST)
Date: Wed, 19 Jul 2017 08:24:12 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Rob Herring <robh@kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Chen-Yu Tsai <wens@csie.org>,
 Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] i2c: Convert to using %pOF instead of full_name
Message-ID: <20170719062412.o6mghdmzlhsytkla@flea>
References: <20170718214339.7774-26-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="tv4e3pgc4wtkta5l"
In-Reply-To: <20170718214339.7774-26-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--tv4e3pgc4wtkta5l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2017 at 04:43:06PM -0500, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Haavard Skinnemoen <hskinnemoen@gmail.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Peter Rosin <peda@axentia.se>
> Cc: linux-i2c@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  drivers/i2c/busses/i2c-gpio.c         |  4 ++--
>  drivers/i2c/busses/i2c-powermac.c     | 10 ++++------
>  drivers/i2c/busses/i2c-sun6i-p2wi.c   |  4 ++--

For the P2WI driver:
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--tv4e3pgc4wtkta5l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZbvsMAAoJEBx+YmzsjxAgRfQP/3G19XUIReb6gzvlyn/cx4+3
wq13/YtCCWrxiab9iWFP4bd+tck+MGCa4G4mVMIt8aN756+pCY80StlpDbgPHMCg
CUGFicFhd0t5NWF6iy63Tq7hUevZb/UTWUOA9HPNhm+3EXpcKAof2aI5fWOdI8jt
TWCGf7xKLND1GRNtLcKCR3RUBzQ/yKA8Hx2us8mawazq/OOkIgVccZkwiOh51PEb
CoJJBgnFgebsv13UbW9CxcmMxMVpWCkssyD89d+dnpQzZALMvJZ2XvEBzcB/Jg4J
pRUlRacj/DQb9CW6/IACd2MNG6LlHmnPMjr5bt7S+qL8u98CeDXN3QtgjAPuY6hr
WaPrzhW+1jepIxksqrBqyJOoqrcxYvtqopXOsf1vpm/KZ0OV9ReRUEQspfYWz4ue
PLSdiJL+OoKmZ8CTWEmGchfAY0Ao0MHFn9/I64NfW9V9ibIU2FVQKK3xFBZKi/lU
KFVX3T/fRBd5G+CYAKc8ChhEiTlXLaJERCOyOipAmjbkrC2FGuBXjmHk3Z4tUwWc
+fEFIulsv+3M4EQvslqm/ACtVFIS/wAzrkbExrGofN8sECU1u2bcVwm5O7NGihcg
EPPhtdjq+CI05b9W1SNbJ2wa5qwCE0eC2FuPrY/TqXhruUVHcpMaRnt1fgVnXu+h
gz0QszaMGMyFhh0Vtdyw
=2zI8
-----END PGP SIGNATURE-----

--tv4e3pgc4wtkta5l--
