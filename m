Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id BB1AEDDE46
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 10:54:53 +1000 (EST)
Date: Thu, 5 Apr 2007 10:55:10 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] add correct interrupt property for pegasos ide
Message-Id: <20070405105510.4376e9ec.sfr@canb.auug.org.au>
In-Reply-To: <20070404162004.GA3016@aepfle.de>
References: <20070404111635.GA1855@aepfle.de> <20070404162004.GA3016@aepfle.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__5_Apr_2007_10_55_10_+1000_.M2Aw/SCkC0kq=gy"
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Paul Mackeras <paulus@samba.org>, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__5_Apr_2007_10_55_10_+1000_.M2Aw/SCkC0kq=gy
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Olaf,

On Wed, 4 Apr 2007 18:20:04 +0200 Olaf Hering <olaf@aepfle.de> wrote:
>
> -	phandle isa;
> -	u32 isa_ranges[6];
> +	phandle ph;
> +	u32 prop[6];

Juat a small nit:  If you want to rename vairables, please do it in a
separate patch - doing it here just clutters the patch and makes it
harder to see what the real purpose is.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__5_Apr_2007_10_55_10_+1000_.M2Aw/SCkC0kq=gy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGFEjzFdBgD/zoJvwRApDtAJ4+ROT0mxIRGESJARFASESBf2Z48gCePjiV
IedvtAx+hRfI6ovqT1tJvcQ=
=sGbL
-----END PGP SIGNATURE-----

--Signature=_Thu__5_Apr_2007_10_55_10_+1000_.M2Aw/SCkC0kq=gy--
