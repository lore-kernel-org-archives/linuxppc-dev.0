Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 82A2ADDEF4
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 17:28:02 +1000 (EST)
Date: Thu, 12 Jun 2008 17:27:54 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: linux-next: powerpc build failure
Message-Id: <20080612172754.91460af2.sfr@canb.auug.org.au>
In-Reply-To: <20080612071612.GB28590@elte.hu>
References: <20080611192748.686236fd.sfr@canb.auug.org.au>
	<20080611095951.GB14033@elte.hu>
	<18512.32267.636550.47385@cargo.ozlabs.ibm.com>
	<20080612053335.GA22035@bubble.grove.modra.org>
	<20080612170505.6049fa75.sfr@canb.auug.org.au>
	<20080612071612.GB28590@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__12_Jun_2008_17_27_54_+1000_nGVGHkp5i2oejaOJ"
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, Alan Modra <amodra@bigpond.net.au>,
	"H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__12_Jun_2008_17_27_54_+1000_nGVGHkp5i2oejaOJ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ingo,

On Thu, 12 Jun 2008 09:16:12 +0200 Ingo Molnar <mingo@elte.hu> wrote:
>
> ugh, please do that hack only privately in your allyesconfig testing and=
=20
> do not commit that change to linux-next!

See my other email, I have removed the ftrace disabling patch and
reverted one of Sam Ravnborg's instead.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__12_Jun_2008_17_27_54_+1000_nGVGHkp5i2oejaOJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhQz/oACgkQTgG2atn1QN94AACeO0Goz+0TOf920o0Sd4Gb8Cie
ijsAn179BJE0oc4LBTuJHYsqmj6FQVgo
=ADA/
-----END PGP SIGNATURE-----

--Signature=_Thu__12_Jun_2008_17_27_54_+1000_nGVGHkp5i2oejaOJ--
