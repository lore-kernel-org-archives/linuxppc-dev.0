Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 57ABBB7CFD
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Feb 2010 15:41:12 +1100 (EST)
Date: Tue, 9 Feb 2010 15:41:06 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: tip build problem on powerpc
Message-Id: <20100209154106.ff295472.sfr@canb.auug.org.au>
In-Reply-To: <20100209042238.GB11280@elte.hu>
References: <20100209100700.81685ffe.sfr@canb.auug.org.au>
	<20100209042238.GB11280@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__9_Feb_2010_15_41_06_+1100_/=2Grjw_GMrucSpA"
Cc: Peter Zijlstra <peterz@infradead.org>, Don Zickus <dzickus@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__9_Feb_2010_15_41_06_+1100_/=2Grjw_GMrucSpA
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ingo.

On Tue, 9 Feb 2010 05:22:38 +0100 Ingo Molnar <mingo@elte.hu> wrote:
>
> yep, i know that already from the -tip cross build tests and reported it =
to=20
> Don yesterday. Do you boot -tip or only build test it? If you use -tip=20
> personally then you can simply disable CONFIG_NMI_WATCHDOG.

OK, good.  I just build test.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__9_Feb_2010_15_41_06_+1100_/=2Grjw_GMrucSpA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAktw52IACgkQjjKRsyhoI8ySPQCgkr0aHLMAU2WGBZL+6jPyOSIb
8ogAoIc62EKRAQP1456Y5MYDX8bgb/o4
=TKLG
-----END PGP SIGNATURE-----

--Signature=_Tue__9_Feb_2010_15_41_06_+1100_/=2Grjw_GMrucSpA--
