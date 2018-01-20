Return-Path: <j.neuschaefer@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zNgcl65HvzF0yY
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jan 2018 12:50:15 +1100 (AEDT)
Date: Sat, 20 Jan 2018 02:47:47 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Rob Herring <robh@kernel.org>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 4/6] dt-bindings: gpio: Add binding for Wii GPIO controller
Message-ID: <20180120014747.w46g5ag7xl3vnwok@latitude>
References: <20180115031401.19577-1-j.neuschaefer@gmx.net>
 <20180115031401.19577-5-j.neuschaefer@gmx.net>
 <20180119230521.st5uon74fpi4jghc@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="xwdbwosl34erxkmp"
In-Reply-To: <20180119230521.st5uon74fpi4jghc@rob-hp-laptop>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--xwdbwosl34erxkmp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2018 at 05:05:21PM -0600, Rob Herring wrote:
> On Mon, Jan 15, 2018 at 04:13:59AM +0100, Jonathan Neusch=C3=A4fer wrote:
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > ---
> >  .../bindings/gpio/nintendo,hollywood-gpio.txt      | 27 ++++++++++++++=
++++++++
> >  .../devicetree/bindings/powerpc/nintendo/wii.txt   |  9 +-------
> >  2 files changed, 28 insertions(+), 8 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/gpio/nintendo,hol=
lywood-gpio.txt
[...]
> > +Example:
> > +
> > +	GPIO: gpio@0d8000c0 {
>=20
> Drop the leading 0.

Ok, will do.

> With that,
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks.


Jonathan Neusch=C3=A4fer

--xwdbwosl34erxkmp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJaYp+8AAoJEAgwRJqO81/bWRMQALyvBEdjaHfv08RV+mib1xch
tvlUSQWhnr28/fecv61CEv5QT5ICRUcukbuMhOAmgkN207I1ubRxa2ZrISmjWWsO
0wofCqZaT3nuAhP9y3E98t2bxz/qPV6p5A1IyGeRBAqVrUVRGxwWgkxyhLUKA3NH
uRnR9QzIRka0JHT+INGA5RlI5k3Wv759y7fF50XA8ZhH0uk0dAquf4AiCpS8vLjL
F266UrxSUtMpLEcSdPTuXB5mn23R2HpJFPcExM2gHabPw9srfrIYczUD9JEoMRzp
ITBj3IsAy0sH0aLCnW23hJ2L4NzIWNzD2RNirYXneEPe73Qt9CDOgUtQN5E6962S
WjBor4Ryzqph9OwCRcTzlgscNQbtKsMqqhEInmIA5Pp0fwPUdt95XMwxTRK0UsyN
E4iSX3QZ9KcQcQqK1tmx+5n+776ujZAMFS0S8AlY1u4/e7bBB2nvCbUvnIc4eIKS
MtTPkk7f+FJQ7V5YlrthYL2E397HyqoQ6dJzVdKQz07WVNgflSMF9nya1VWQN4ZK
QjaVRpXfbHFdPV4J5EoYtj5dOQCydD6v13mke8vfmE9H4S8wcau05eKKf0gCxMoO
505N0wHc3tLdFiOEEJ9rff/xLT6oKYjRNK476nAZRMXTQ7yHqdf/37zJoJLcNkuJ
NUIHk22hGHW/dh6tPqZt
=xC1+
-----END PGP SIGNATURE-----

--xwdbwosl34erxkmp--
