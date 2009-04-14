Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0353DDE0BA
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 01:51:05 +1000 (EST)
Subject: Re: [PATCH] AOA: Convert onyx and tas codecs to new-style i2c  
	drivers
From: Johannes Berg <johannes@sipsolutions.net>
To: Jean Delvare <khali@linux-fr.org>
In-Reply-To: <1239723613.24771.8.camel@johannes.local>
References: <20090408150249.5a62a56c@hyperion.delvare>
	<1239205899.16477.32.camel@johannes.local>
	<20090408224858.04cb6dc4@hyperion.delvare>
	<1239263089.24548.30.camel@johannes.local>
	<20090409141945.116772e3@hyperion.delvare>
	<1239723613.24771.8.camel@johannes.local>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-KHxUTyN12gZiQwMpwo/o"
Date: Tue, 14 Apr 2009 17:50:27 +0200
Message-Id: <1239724227.24771.9.camel@johannes.local>
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


--=-KHxUTyN12gZiQwMpwo/o
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-04-14 at 17:40 +0200, Johannes Berg wrote:

> So I went to test this, but for some reason aoa doesn't work for me at
> all, neither with nor without this patch.
>=20
> The reason seems to be that aoa_fabric_layout_probe() is never called,
> but my driver model fu is weak so I can't tell why -- I definitely see
> the i2sbus soundbus devices registered. soundbus_probe() isn't getting
> called either though, but we do of_device_register(). I'm confused, but
> don't have time to dig further right now.

2.6.29 works -- guess somebody could bisect, but I can't now.

johannes

--=-KHxUTyN12gZiQwMpwo/o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJ5LDBAAoJEKVg1VMiehFYSfYQALUtPyixjj5EjvK26wJHHVny
+Gb2HL1X3o5QuFnB0/Gu2KGQZSXvqU5273mCXW4dScb+JfdBI5qIRZCT9FFVrfD7
Un1p+A6kEv9s5osmubHC95dZ0Z1OZzT/5pBlTKh2ejPc51cUzI2AFJLfxob8Gc5r
gebscoAdbJR4LfCZRC2U+d4EHcuX5TeIaFJbuMjcnGkacpRtFKlhPSQypxsHIWV2
cLy9OkHFjAoRDfgqHVuEFM8BbIUeq6LV8XswKJ0ePKKUlAZPs20j2kijCAt4MKq1
7t81oGzVq0Lhf0YHT3rUlJls4f8Y7nqnDeFtrNgS9nmruR/y7B8M0EOEnt8kmas6
fiPpRedN87AM280w27Qvm5++l2peme+y4s0atjcsyr6EPOLkRK30O1Gm2KEewGv8
5RwdHln8LpC87rpArnN8S8wQCeV4zC+PjQc6sDclGFWEq19ELY/6vxeaK5Nww3Y8
Y6AmhDfCHoPXyVMti7+lQQ5KzIYydAvQaVtgGDTwGwSs+asBSTP08rlQqzXRbrm2
YoQbmP6OCtqFweb6/zI12TJBw9q7P1CnmgTwQVeIy3iq6CWExeTN59434Pnr1Osr
Y78cbmd2vYwGVcPxHxhU/Wx/IzEqZ0H6BXhxroMJsjVlDhV6E1pECHAVIWSLhcSO
mGHxVPmjWcFrDCaEO/FV
=TS7V
-----END PGP SIGNATURE-----

--=-KHxUTyN12gZiQwMpwo/o--
