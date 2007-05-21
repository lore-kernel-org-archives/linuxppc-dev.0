Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 724E4DDE37
	for <linuxppc-dev@ozlabs.org>; Mon, 21 May 2007 17:36:40 +1000 (EST)
Date: Mon, 21 May 2007 17:36:31 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: michael@ellerman.id.au
Subject: Re: [PATCH] [POWERPC] Comment out a currently unused function
Message-Id: <20070521173631.64a580a7.sfr@canb.auug.org.au>
In-Reply-To: <1179731970.5579.0.camel@concordia.ozlabs.ibm.com>
References: <20070521154026.640320cd.sfr@canb.auug.org.au>
	<1179731970.5579.0.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__21_May_2007_17_36_31_+1000_=ngNErAZ8EtX9VVT"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__21_May_2007_17_36_31_+1000_=ngNErAZ8EtX9VVT
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 21 May 2007 17:19:30 +1000 Michael Ellerman <michael@ellerman.id.au> wrote:
>
> Why not remove it? You can always get it back with git.

Because I am hopeful that the comment on the module_exit() line is
implying that the maintainer (or someone else who knows what is going on)
is intending to fis it up soon.  :-)

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__21_May_2007_17_36_31_+1000_=ngNErAZ8EtX9VVT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGUUwHFdBgD/zoJvwRAuTSAKCTNtUw1rNrT4AD2UANBkWxQ8LTlgCeKmYC
VfuX6Aft9mYHzJHb+eEFCoU=
=Bf5V
-----END PGP SIGNATURE-----

--Signature=_Mon__21_May_2007_17_36_31_+1000_=ngNErAZ8EtX9VVT--
