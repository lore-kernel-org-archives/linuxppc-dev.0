Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 30C63DDE16
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 15:56:20 +1000 (EST)
Date: Tue, 12 May 2009 15:56:13 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Nick Piggin <npiggin@suse.de>
Subject: Re: Next May 11 : BUG during scsi initialization
Message-Id: <20090512155613.881fa2ec.sfr@canb.auug.org.au>
In-Reply-To: <20090512045716.GC32535@wotan.suse.de>
References: <20090511161442.3e9d9cb9.sfr@canb.auug.org.au>
	<4A081002.4050802@in.ibm.com>
	<20090511115233.GB8112@parisc-linux.org>
	<4A081437.7000409@in.ibm.com>
	<20090511122135.GC8112@parisc-linux.org>
	<20090512045716.GC32535@wotan.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__12_May_2009_15_56_13_+1000_XEPp5_Ae/_uZPBoo"
Cc: linux-scsi <linux-scsi@vger.kernel.org>, Matthew Wilcox <matthew@wil.cx>,
	linuxppc-dev@ozlabs.org, Pekka Enberg <penberg@cs.helsinki.fi>,
	linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__12_May_2009_15_56_13_+1000_XEPp5_Ae/_uZPBoo
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nick,

On Tue, 12 May 2009 06:57:16 +0200 Nick Piggin <npiggin@suse.de> wrote:
>
> Hmm, I think (hope) your problems were fixed with the recent memory
> coruption bug fix for SLQB. (if not, let me know)
>=20
> This one possibly looks like a problem with remote memory allocation
> or memory hotplug or something like that. I'll do a bit of code
> review....

These are -next kernels which include the two fixes you posted recently
(I am pretty sure).  I am also getting the network failures that Sachin
is seeing on several of my machines here.  The previously reported
problems have gone away.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__12_May_2009_15_56_13_+1000_XEPp5_Ae/_uZPBoo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoJD30ACgkQjjKRsyhoI8yt4ACfUhS1N3pSKka6v0j6wNE1CLUy
ZJwAn2HHuo9jW7RDBnjcpJiDmu0pHtVD
=VeYZ
-----END PGP SIGNATURE-----

--Signature=_Tue__12_May_2009_15_56_13_+1000_XEPp5_Ae/_uZPBoo--
