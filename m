Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 8F19BB711B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Feb 2011 01:44:40 +1100 (EST)
Date: Tue, 8 Feb 2011 01:44:32 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] PM: Hide CONFIG_PM from users
Message-Id: <20110208014432.2c9288e4.sfr@canb.auug.org.au>
In-Reply-To: <20110207141829.GK10564@opensource.wolfsonmicro.com>
References: <1297081335-13631-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20110208011324.d5371c4c.sfr@canb.auug.org.au>
	<20110207141829.GK10564@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__8_Feb_2011_01_44_32_+1100_WrhF_X_zbIe/bP27"
Cc: Len Brown <len.brown@intel.com>, linux-embedded@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
	Alan Stern <stern@rowland.harvard.edu>,
	linux-pm@lists.linux-foundation.org,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__8_Feb_2011_01_44_32_+1100_WrhF_X_zbIe/bP27
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Mon, 7 Feb 2011 14:18:29 +0000 Mark Brown <broonie@opensource.wolfsonmic=
ro.com> wrote:
>
> On Tue, Feb 08, 2011 at 01:13:24AM +1100, Stephen Rothwell wrote:
> > On Mon,  7 Feb 2011 12:22:15 +0000 Mark Brown <broonie@opensource.wolfs=
onmicro.com> wrote:
>=20
> > > +	bool
> > > +	default y if !IA64_HP_SIM
>=20
> > Several powerpc configs have CONFIG_PM (implicitly) disabled (e.g. the
> > server configs), so this will unexpectedly turn it on for them.
>=20
> Do you mean that these systems require CONFIG_PM be turned off, or just
> that people tend not to turn it on?  If the latter would you expect any
> ill effects from doing so?

I don't know the answer to either question without testing.  All I am
saying is that currently the default for CONFIG_PM is "off" and you are
changing it to be "on" and there may not have been any testing done of
that in some situations.   We don't know where it was explicitly
turned off any more since we shrank our defconfig files (which was done
automatically) ... since it is off by default, it doesn't need to be
mentioned in a defconfig unless it needs to be turned on.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__8_Feb_2011_01_44_32_+1100_WrhF_X_zbIe/bP27
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJNUAVQAAoJEDMEi1NhKgbsZLkH/0eWC8wFEXEtH3XBdO/79I1W
5zTlj/bDi2QQjVb+8GYJxzyE7BR4rjOWvmLq0gs5vOxrBIE5+Tu4HmkUI5F1QZjp
8kqaK2Q8W1fSHSPumoZFKXKcEupCvZgofALmoKp9FjHBS49baHVhrltNFNOarblu
kRokJUceskm9aGq66SZQnvVK0Ux8OqcOdJmxZm06repkIcm6QenGoxYJPOTmjhfQ
TtdkBF2R8OYk1SPtuezk2KsTu4p0/4B38ad573yEKuZ3q9nE4mIMkwWy7G9Now7t
CPqqXsGPYgYRCj7nhPqgnRSK6fvoob9AHtdUwsumb1DI/gbFcGAZvENlhw07NEQ=
=/pa9
-----END PGP SIGNATURE-----

--Signature=_Tue__8_Feb_2011_01_44_32_+1100_WrhF_X_zbIe/bP27--
