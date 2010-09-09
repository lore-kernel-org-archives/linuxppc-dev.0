Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id CE9FEB712C
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Sep 2010 08:42:09 +1000 (EST)
Date: Fri, 10 Sep 2010 08:42:03 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Tirumala Marri <tmarri@apm.com>
Subject: Re: Combining defconfigs for 44x based boards
Message-Id: <20100910084203.dcb9c816.sfr@canb.auug.org.au>
In-Reply-To: <69da3260c595cc3870a9ff1eee9a7898@mail.gmail.com>
References: <a3a9eb5a2e770f931950ad13c01960da@mail.gmail.com>
	<20100909004853.GA11808@zod.rchland.ibm.com>
	<49073d172310031addb3aa7d08a60c99@mail.gmail.com>
	<20100909063601.03CCE1506AA@gemini.denx.de>
	<56886bb653a2198b7a5bdcf5f38d4a98@mail.gmail.com>
	<20100909130954.265adb37@lappy.seanm.ca>
	<69da3260c595cc3870a9ff1eee9a7898@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__10_Sep_2010_08_42_03_+1000_+S3JKfYQANSKR9yW"
Cc: linuxppc-dev@lists.ozlabs.org, Wolfgang Denk <wd@denx.de>,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__10_Sep_2010_08_42_03_+1000_+S3JKfYQANSKR9yW
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 9 Sep 2010 15:17:10 -0700 Tirumala Marri <tmarri@apm.com> wrote:
>
> [Marri]That is kind of true. Can we create new defconfigs then ?
> I am trying to check-in new defconfig.

Just make sure that it is minimal by using "make savedefconfig".  This
will create a file "defconfig" in the current directory which should have
the minimal amount of stuff in it to reproduce the current .config.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__10_Sep_2010_08_42_03_+1000_+S3JKfYQANSKR9yW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMiWK7AAoJEDMEi1NhKgbst1gH/0oXjp16XmNQAqNklX7HkqKY
dF73XGoohyzqpic+d1C1pagAkgUNmj5lZBUYN0SVc3yCSVQboVgQbOsgyV2uzYWB
0xlQH1ohLPBlB4BmC1QEz0VfP5VdwGRTCwqi6Kjx8cgkG8NWHSN0SDF/ClNzgPfx
7frPBD72Y08MBfEVr0IgtCMiRBPyxO/kgutBpUiZ3bgAQyL3XgcIz4NA41Mh1tMv
aOT4eTyTdev8lG/jQL9YnTRJTC3JQR/eSBu1Hh8Y1e06ULBA40HMz5oGulK58nxd
ovS0XVKT4+kkCVTSi3aXnHcIQeJs5Xo/b7ugPX6+CznFZdZg5EqAAVWRz7aMiaw=
=kHIF
-----END PGP SIGNATURE-----

--Signature=_Fri__10_Sep_2010_08_42_03_+1000_+S3JKfYQANSKR9yW--
