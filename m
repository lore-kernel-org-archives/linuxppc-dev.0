Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4425CDDF4A
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 03:21:21 +1000 (EST)
Subject: Re: [PATCH] AOA: Convert onyx and tas codecs to new-style i2c  
	drivers
From: Johannes Berg <johannes@sipsolutions.net>
To: Andreas Schwab <schwab@linux-m68k.org>
In-Reply-To: <m2ws9n18rn.fsf@igel.home>
References: <20090408150249.5a62a56c@hyperion.delvare>
	<1239205899.16477.32.camel@johannes.local>
	<20090408224858.04cb6dc4@hyperion.delvare>
	<1239263089.24548.30.camel@johannes.local>
	<20090409141945.116772e3@hyperion.delvare>
	<1239723613.24771.8.camel@johannes.local>  <m2ws9n18rn.fsf@igel.home>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-w/Qz7N0j4vQuEC0Fddxn"
Date: Tue, 14 Apr 2009 19:20:37 +0200
Message-Id: <1239729637.24771.10.camel@johannes.local>
Mime-Version: 1.0
Cc: Jean Delvare <khali@linux-fr.org>, Takashi Iwai <tiwai@suse.de>,
	alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-w/Qz7N0j4vQuEC0Fddxn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-04-14 at 18:48 +0200, Andreas Schwab wrote:
> Johannes Berg <johannes@sipsolutions.net> writes:
>=20
> > So I went to test this, but for some reason aoa doesn't work for me at
> > all, neither with nor without this patch.
>=20
> That is already fixed by
> <http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/=
driver-core.current/driver-core-fix-driver_match_device.patch>

Ah, cool, thanks. I'll add that to the mix and test again.

johannes

--=-w/Qz7N0j4vQuEC0Fddxn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJ5MXjAAoJEKVg1VMiehFYUs0P/3nz5hzSkLMIMi1FHkw2ejKV
CsxbKjMlYpri/2yYxwL42xE4LfrLZ1S/tsjI2B0x5gxNAQ/306WWoqKp1MgSIfpD
+EMV0MC8H7259msVZxlQbVSNl5X9dBSkzggKS2Y3vErXU7QeK3g3Tdv5YCpQ2fkI
NE8H3MFCOzbPaj3QGQlZh5M+Y4yIqcG2qi50P2WA6++A5DSvN3rJhJTiH7cXUr8B
c0FczUtx4LCPq59KaGUtLeAwhDlo6Bzm0htL6z3Hsc5OjLoh/U3Z7J84UqKB5jxv
+RqDJDllQHsLEC+tzI7aPAsWy25k/OgP4rTHszHlwnzEQru2hj2Fq3Oqm5fqJffz
RdaMo9cW6eQpz+CXVpeY65CZ7yB4xOJj6MBSI4/bMpGipCy0NAUBsHrhdvTiQFiM
38NUGYPIVjqddU0QhQfgLJ1hsncVdMkfUFf756GnHBG76P2chR0a55Ex7/K8dzTG
NmNk+ecYuSZuu8l/PEawsV2EXWs3cJMXBOC6eJpV9DVnn0g1ZA0HaTUB7jmhKhEu
K2/snHa/2PeHKw5EWr/qitRse33mwSB+5DCAmLXwiF10LQyKYItXNSQ5v9eeBzN3
5H9gh6LQG9jumhqT9/DgLUh3l5RsDjfS2W+gyNOrUBJpLBPly6kLipEeEhYbtQfl
nXnnSYYHwN2ae+n3+zUL
=NL6m
-----END PGP SIGNATURE-----

--=-w/Qz7N0j4vQuEC0Fddxn--
