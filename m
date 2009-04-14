Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 48E97DDF83
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 01:40:53 +1000 (EST)
Subject: Re: [PATCH] AOA: Convert onyx and tas codecs to new-style i2c  
	drivers
From: Johannes Berg <johannes@sipsolutions.net>
To: Jean Delvare <khali@linux-fr.org>
In-Reply-To: <20090409141945.116772e3@hyperion.delvare>
References: <20090408150249.5a62a56c@hyperion.delvare>
	<1239205899.16477.32.camel@johannes.local>
	<20090408224858.04cb6dc4@hyperion.delvare>
	<1239263089.24548.30.camel@johannes.local>
	<20090409141945.116772e3@hyperion.delvare>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-BAW04IYgFlAJ7OMfBifh"
Date: Tue, 14 Apr 2009 17:40:13 +0200
Message-Id: <1239723613.24771.8.camel@johannes.local>
Mime-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-BAW04IYgFlAJ7OMfBifh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-04-09 at 14:19 +0200, Jean Delvare wrote:

> From: Jean Delvare <khali@linux-fr.org>
> Subject: AOA: Convert onyx and tas codecs to new-style i2c drivers
>=20
> The legacy i2c binding model is going away soon, so convert the AOA
> codec drivers to the new model or they'll break.

So I went to test this, but for some reason aoa doesn't work for me at
all, neither with nor without this patch.

The reason seems to be that aoa_fabric_layout_probe() is never called,
but my driver model fu is weak so I can't tell why -- I definitely see
the i2sbus soundbus devices registered. soundbus_probe() isn't getting
called either though, but we do of_device_register(). I'm confused, but
don't have time to dig further right now.

johannes

--=-BAW04IYgFlAJ7OMfBifh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJ5K5aAAoJEKVg1VMiehFYqDEP+wWx95N5W38XjfRWqXmeDjo7
ISlNNOMemKEuViuLSLdP33qK9JkYc+97sSqSexoZHZrE6MdNsVfKDKHcENDh3Q14
s1bzsqzIokljTS0xrO4MBXued9y2Mw4J487b4FPTa7aXqSR9ZUa1HhuiTTBDJFjq
oCePZsHMQdd5PuGdJTWEHk0sV7HG2hpMGmOId5SfZqUBFnNspv69HU5/pYPwlevr
uAYeotLVEZ2r4pdRNj5clIvmjsCIf4X8aLEm/16JOa6Nt/hE6hnNkkGuUdPyJEVP
CCR2vCZMbKcctlrn2bd2MFeTKdikMMb/A86JWAzmG9J2XtxIm6LxsY7sb9PGdbym
FLoEl+lvesJuDCwqFRyNXhW3s2YmH6BjmoUCriRE3C3CzmWCo4RZXNpXCgfnrDur
e1iBMPovfm38FrEKqAhhmbcaHx3dLTRmbvvk+Xqh4tmUyDiKVCKmthsdBR20EWth
xfyxM5sS/xTMBuJwgrlTLwGdR2gMOMm15Si+/+7ZNYHRws1QXAvCJHsJMtF5vjf0
2zwcSC1QU6+75ByBeg0YFMeQB4E8+vT5lCbvHItwYup/mkUN8oC3dFSDNr/rIPhC
SmQ3d1dIocRrUiRUTY/LhJe1KWp0AWjLeFyMO5Y2ocWrGVTT4LvEtujPenR6rXvX
nNC1aOmWxatcUUq4XtGV
=4eXS
-----END PGP SIGNATURE-----

--=-BAW04IYgFlAJ7OMfBifh--
