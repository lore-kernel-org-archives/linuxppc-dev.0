Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id D507A67BFF
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Dec 2006 17:21:26 +1100 (EST)
Date: Wed, 6 Dec 2006 17:21:14 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: albertl@mail.com
Subject: Re: Oops in pata_pdc2027x
Message-Id: <20061206172114.a1c515f8.sfr@canb.auug.org.au>
In-Reply-To: <45765EC7.2000908@tw.ibm.com>
References: <20061205170144.0b98d7e6.sfr@canb.auug.org.au>
	<45765EC7.2000908@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__6_Dec_2006_17_21_14_+1100_J+KINg=8AeB7wdyv"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Albert Lee <albertcc@tw.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__6_Dec_2006_17_21_14_+1100_J+KINg=8AeB7wdyv
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 06 Dec 2006 14:10:15 +0800 Albert Lee <albertcc@tw.ibm.com> wrote:
>
> Where could I download the patched kernel source? There are two
> POWER5 9110-51A boxes here. Maybe I could try to reproduce the problem
> on these boxes.

You can just use Linus' current tree - it exhibits the same problem (and
the powerpc tree has been merged into it).

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__6_Dec_2006_17_21_14_+1100_J+KINg=8AeB7wdyv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFdmFaFdBgD/zoJvwRAlrrAJ9nTsXfOmskR8L8mTwmI4mp8C65KwCgmDUe
HB9+ck7EU3PHukwX4zzUs20=
=OW9h
-----END PGP SIGNATURE-----

--Signature=_Wed__6_Dec_2006_17_21_14_+1100_J+KINg=8AeB7wdyv--
