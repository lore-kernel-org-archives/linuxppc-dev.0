Return-Path: <j.neuschaefer@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zdKGd6vYDzF0k8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 02:48:22 +1100 (AEDT)
Date: Fri, 9 Feb 2018 16:48:08 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc: linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, Albert Herranz <albert_herranz@yahoo.es>,
 Segher Boessenkool <segher@kernel.crashing.org>,
 Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 2/4] gpio: Add GPIO driver for Nintendo Wii
Message-ID: <20180209154807.xkfarpxzpieznfsh@latitude>
References: <20180209120732.17863-1-j.neuschaefer@gmx.net>
 <20180209120732.17863-3-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="blzswmp6chmlj3mw"
In-Reply-To: <20180209120732.17863-3-j.neuschaefer@gmx.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--blzswmp6chmlj3mw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2018 at 01:07:29PM +0100, Jonathan Neusch=C3=A4fer wrote:
> The Nintendo Wii's chipset (called "Hollywood") has a GPIO controller
> that supports a configurable number of pins (up to 32), interrupts, and
> some special mechanisms to share the controller between the system's
> security processor (an ARM926) and the PowerPC CPU. Pin multiplexing is
> not supported.
>=20
> This patch adds a basic driver for this GPIO controller. Interrupt
> support will come in a later patch.
>=20
> This patch is based on code developed by Albert Herranz and the GameCube
> Linux Team, file arch/powerpc/platforms/embedded6xx/hlwd-gpio.c,
> available at https://github.com/DeltaResero/GC-Wii-Linux-Kernels, but
> has grown quite dissimilar.
>=20
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> Cc: Albert Herranz <albert_herranz@yahoo.es>
> Cc: Segher Boessenkool <segher@kernel.crashing.org>
> <---

Ooops, I just noticed that I broke the separator here. This should be a
normal --- line, obviously.


Jonathan Neusch=C3=A4fer

--blzswmp6chmlj3mw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJafcKwAAoJEAgwRJqO81/bYKIQALAd9vMfeRv6ofuyS2/g+wEE
ZSTvxxfogE+fHJuTxz1eFHlfisMX74qVW7kmjtB01oHhugVkElI4f22vCB+q83+D
J5dCcxB+QtwoDNURRN3VD2S7dr9oaCmKz2cFSEXBUiM1Kzol1B2W/rmPOPGk6hOv
Sz8zIfgkGFL/CUqXA7OIqlhccl3vpmg3xTDeVFbMz9L0/m35UzkwHyp3BZ5KhIcJ
R2EN9+n2ApKmkYgc0ZiiM65TgvKlkXMd3HQQFml86v9naRzaVPgR0Ft+h9s4uDjE
XhBx96TSi7Zjg4R6a7UfNyoH/watS2L8oiGPt5z+tgqK8zoV3rbwRL/xmoEIWha6
vVg1ALrb0Ww5d9/XHHWeebG5s8R5dAtA6HGiO6I8mPCGo5Toc+8kvOjQ28/Se6p3
L9thxpC62pem4aPzlkUPUPn/GV5QHdBz/Lfu9lkjOa9Vx2wgvxkz3WLM4cAVJIna
h+pfccA/qYHu/BdrU8E5GXJiC3PV+QAbfII18FF9sJSi+PS8wjvb+5pq59eXWxsC
ENQ9MmxNYstjahGgC4YgeK44zix/i90CGOUkZGTKIN1w/iRF9aKlDAPMbbg/5ptT
jDka6KhlH/UCPkHT2JPgL/E0i3sGodOJkXOS5GV8yE8WWrCmN0n6tDfLW0E0CuAC
DVcUna8tarsDfOLtlByd
=EsLr
-----END PGP SIGNATURE-----

--blzswmp6chmlj3mw--
