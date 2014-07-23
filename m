Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0C6391A013B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 20:08:00 +1000 (EST)
Date: Wed, 23 Jul 2014 11:07:46 +0100
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Message-ID: <20140723100746.GC17528@sirena.org.uk>
References: <cover.1405603108.git.nicoleotsuka@gmail.com>
 <9ef07dc9cc98b19e3f81f8374617605bf0d9faeb.1405603108.git.nicoleotsuka@gmail.com>
 <20140718101810.GA15150@MrMyself> <20140723095229.GA25639@MrMyself>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="NFhhVVeDTkyNvWHh"
In-Reply-To: <20140723095229.GA25639@MrMyself>
Subject: Re: [PATCH 1/2] ASoC: fsl_sai: Reset FIFOs after disabling TE/RE
Cc: alsa-devel@alsa-project.org, b42378@freescale.com, b02247@freescale.com,
 linux-kernel@vger.kernel.org, timur@tabi.org, Li.Xiubo@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--NFhhVVeDTkyNvWHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2014 at 05:52:32PM +0800, Nicolin Chen wrote:

> I found this two patches are merged into for-next branch, although I have=
n't
> got the 'applied' email.=20

> Is that possible for you to drop this one? If not, I'll send another patch
> to fix this.

Please send a patch, I'd already applied it by the time you asked me to
drop it.

--NFhhVVeDTkyNvWHh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTz4lvAAoJELSic+t+oim9x7gP/06hLfS/OM3JrvPuAaXXqvgK
7G0nVvMQh/QopDYZ10MJNxU+w0CCFpP1yPbhqkZrDLQH0WxXlzlDFgVMzmFKHmJw
qYkwrWD6vzjSxEecrCEtsYIXhAn4FUNgOATa5FrqVT1pBCXrY8kIXkaclzB7YOOL
Ob5lsdGIf3YXQnsWt+sFF1CLKTb4rDXg0Oe3PTmHbqdQx4Gwbls2TmE37za8XKtf
UtZgN91zsxgZYMOKRUeqQpvCaIHIQbZTipoDjOTaw0Ocdb6NusTVUw9lJXrrrP52
8SPlJqs+KwJGThv5xjFNmn8fDTx0P+SfzIXPcc56xiHDdpe00Ziy3zKv7PDUaq6o
HuIzOWJvIClrc/WoyayiEbUtnJsKkl/1v1L15tkipb5H7wz0OL0a9JdPf7lDMR/3
N1WvtAjkcYJNVEoYhVuuUymqqkT1MKEq64blgX7wuretgt3ZVVpfLhVYdL0ltzcN
ZKZnzKlEm/aTMz9x9gArLiy6AomAgGYf9wDZd6hriyqm5Ll2toT7dnvRClZ6ugkt
SDdbCbl9i9w0DRZdFNOAJkQzJ/mBmUR0SjQ08aWxBu2Rb5IUtzUmAPayHSDcKOeY
vLiYUGTgbokKtmkvFw12uvtFFJjsprK5gOrsSnK5EsOTmYfU63EAk4XCKGsCEhsn
aMvVzC+PZdV3wMX42zEV
=8XPw
-----END PGP SIGNATURE-----

--NFhhVVeDTkyNvWHh--
