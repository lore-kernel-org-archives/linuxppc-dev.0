Return-Path: <SRS0=ZiU1=LZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A6BC11F64
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Jul 2021 20:05:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3485761410
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Jul 2021 20:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3485761410
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GG8Mz2JRhz3bWw
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Jul 2021 06:05:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linkmauve.fr (client-ip=82.65.109.163; helo=luna.linkmauve.fr;
 envelope-from=linkmauve@linkmauve.fr; receiver=<UNKNOWN>)
X-Greylist: delayed 475 seconds by postgrey-1.36 at boromir;
 Fri, 02 Jul 2021 06:05:12 AEST
Received: from luna.linkmauve.fr (82-65-109-163.subs.proxad.net
 [82.65.109.163])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GG8MX1kClz301s
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jul 2021 06:05:11 +1000 (AEST)
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
 id 06CA9F40443; Thu,  1 Jul 2021 21:56:55 +0200 (CEST)
Date: Thu, 1 Jul 2021 21:56:55 +0200
From: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.ne@posteo.net>
Subject: Re: [PATCH v2 3/4] powerpc: wii.dts: Expose the OTP on this platform
Message-ID: <20210701195655.knbcikdga57a7epx@luna>
Jabber-ID: linkmauve@linkmauve.fr
References: <20210519095044.4109-1-linkmauve@linkmauve.fr>
 <20210519095044.4109-4-linkmauve@linkmauve.fr>
 <YNe5aW55SrXFGKFV@latitude>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5xpqystiypqfkjaq"
Content-Disposition: inline
In-Reply-To: <YNe5aW55SrXFGKFV@latitude>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Ash Logan <ash@heyquark.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--5xpqystiypqfkjaq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 26, 2021 at 11:34:01PM +0000, Jonathan Neusch=C3=A4fer wrote:
> On Wed, May 19, 2021 at 11:50:43AM +0200, Emmanuel Gil Peyrot wrote:
> > This can be used by the newly-added nintendo-otp nvmem module.
> >=20
> > Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> > ---
> >  arch/powerpc/boot/dts/wii.dts | 5 +++++
> >  1 file changed, 5 insertions(+)
> >=20
> > diff --git a/arch/powerpc/boot/dts/wii.dts b/arch/powerpc/boot/dts/wii.=
dts
> > index aaa381da1906..7837c4a3f09c 100644
> > --- a/arch/powerpc/boot/dts/wii.dts
> > +++ b/arch/powerpc/boot/dts/wii.dts
> > @@ -219,6 +219,11 @@ control@d800100 {
> >  			reg =3D <0x0d800100 0x300>;
> >  		};
> > =20
> > +		otp@d8001ec {
> > +			compatible =3D "nintendo,hollywood-otp";
> > +			reg =3D <0x0d8001ec 0x8>;
>=20
> The OTP registers overlap with the previous node, control@d800100.
> Not sure what's the best way to structure the devicetree in this case,
> maybe something roughly like the following (untested, unverified):
[snip]

I couldn=E2=80=99t get this to work, but additionally it looks like it shou=
ld
start 0x100 earlier and contain pic1@d800030 and gpio@d8000c0, given
https://wiibrew.org/wiki/Hardware/Hollywood_Registers

Would it make sense, for the time being, to reduce the size of this
control@d800100 device to the single register currently being used by
arch/powerpc/platforms/embedded6xx/wii.c (0xd800194, used to reboot the
system) and leave the refactor of restart + OTP + PIC + GPIO for a
future series?

Thanks,

--=20
Emmanuel Gil Peyrot

--5xpqystiypqfkjaq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEjrVT1SzTln43kCLJOWgfYkb2LpAFAmDeHgQACgkQOWgfYkb2
LpBR1wgAo8/AW14uyzt1Z177k6xWkLqlqUXPSqvRzsrEbtn4t/IlewtlPOrwBntP
v9cBf82hjFyNeKZMOGD/3Hka8bXBlsqrcVZUEPxUYuty6f+qsQ96AIYeVdN+S4It
8wquNDtGA3VIJY6xxD+sDE+GplNH5WeUO/dhLqXxlSDi52fSyUK/mc6DIcXHC+q8
f+RW6VDgVVVrJdhofhvHoO/2g0BwKNWOmfyv70RXUvZq+mT6lI3liEkEeAm8TyxP
4logyZ9vZYg/LhjceqHTnppXl5XyBPeOznBVbygdeJh7igBfRsh6Pz2ISgYeS51N
YhJjzLcGv44IlTttJz1GkRzIwHj0wg==
=zJte
-----END PGP SIGNATURE-----

--5xpqystiypqfkjaq--
