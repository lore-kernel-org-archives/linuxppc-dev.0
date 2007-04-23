Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 942A9DDDFB
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2007 17:43:26 +1000 (EST)
Date: Mon, 23 Apr 2007 17:43:39 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Start split out of common open firmware code
Message-Id: <20070423174339.20308ac3.sfr@canb.auug.org.au>
In-Reply-To: <17cfcd2e089f7154354fe6c4c1cadf3c@kernel.crashing.org>
References: <20070412141905.6f30efd3.sfr@canb.auug.org.au>
	<20070412153424.bf3957f4.sfr@canb.auug.org.au>
	<1176357020.8061.123.camel@localhost.localdomain>
	<20070411.232545.45203999.davem@davemloft.net>
	<17cfcd2e089f7154354fe6c4c1cadf3c@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__23_Apr_2007_17_43_39_+1000_v9OcoJDRUbwW/KNx"
Cc: paulus@samba.org, David Miller <davem@davemloft.net>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__23_Apr_2007_17_43_39_+1000_v9OcoJDRUbwW/KNx
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 12 Apr 2007 09:00:45 +0200 Segher Boessenkool <segher@kernel.crashing.org> wrote:
>
> drivers/ is the wrong place to put this IMHO.  Why not
> use kernel/openfirmware/*.[ch] ?

We have drivers/acpi as a precedent ...

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__23_Apr_2007_17_43_39_+1000_v9OcoJDRUbwW/KNx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGLGOwFdBgD/zoJvwRAhYzAJ9aN6uYqjzvyECawCii7G98/luL/gCfdcPv
mE9z/d1+kw4OcRQwfVkGXcE=
=mCUE
-----END PGP SIGNATURE-----

--Signature=_Mon__23_Apr_2007_17_43_39_+1000_v9OcoJDRUbwW/KNx--
