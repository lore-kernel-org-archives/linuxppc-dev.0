Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A4BE1DDEDB
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 16:52:55 +1000 (EST)
Date: Tue, 12 May 2009 16:52:45 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Nick Piggin <npiggin@suse.de>
Subject: Re: Next May 11 : BUG during scsi initialization
Message-Id: <20090512165245.78b6bf83.sfr@canb.auug.org.au>
In-Reply-To: <20090512160352.4a97d2f4.sfr@canb.auug.org.au>
References: <20090511161442.3e9d9cb9.sfr@canb.auug.org.au>
	<4A081002.4050802@in.ibm.com>
	<20090511115233.GB8112@parisc-linux.org>
	<4A081437.7000409@in.ibm.com>
	<20090511122135.GC8112@parisc-linux.org>
	<20090512045716.GC32535@wotan.suse.de>
	<20090512155613.881fa2ec.sfr@canb.auug.org.au>
	<20090512055918.GF32535@wotan.suse.de>
	<20090512160352.4a97d2f4.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__12_May_2009_16_52_45_+1000_1w_au2XhoAYZWPic"
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

--Signature=_Tue__12_May_2009_16_52_45_+1000_1w_au2XhoAYZWPic
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nick,

On Tue, 12 May 2009 16:03:52 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> This is what I have been getting for the last few days:

bisected into the net changes, I will follow up there, sorry.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__12_May_2009_16_52_45_+1000_1w_au2XhoAYZWPic
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoJHL0ACgkQjjKRsyhoI8xCUQCfSZ3e9mpZT9k3SfXCZGh71PiA
WZMAniu3+IBo6EqdWv6y1LF2P9509KK9
=f31l
-----END PGP SIGNATURE-----

--Signature=_Tue__12_May_2009_16_52_45_+1000_1w_au2XhoAYZWPic--
