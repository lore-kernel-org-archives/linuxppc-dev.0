Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 91AACDDECE
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 01:34:18 +1000 (EST)
Date: Tue, 24 Apr 2007 01:34:31 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: olof@lixom.net (Olof Johansson)
Subject: Re: [PATCH] [v4] powerpc: save trap number in bad_stack
Message-Id: <20070424013431.25d632db.sfr@canb.auug.org.au>
In-Reply-To: <20070423151155.GA2530@lixom.net>
References: <20070416062347.GA20196@lixom.net>
	<20070422233821.GB28479@lixom.net> <20070423121931.GA683@lixom.net>
	<20070423151155.GA2530@lixom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__24_Apr_2007_01_34_31_+1000_WzI5bmHmIjo6WvuS"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__24_Apr_2007_01_34_31_+1000_WzI5bmHmIjo6WvuS
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 23 Apr 2007 10:11:55 -0500 olof@lixom.net (Olof Johansson) wrote:
>
> Save the trap number in the case of getting a bad stack in an exception
> handler. It is sometimes useful to know what exception it was that caused
> this to happen. Without this, no trap is reported.
>
>
> Signed-off-by: Olof Johansson <olof@lixom.net>

I'm happy this time :-)

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__24_Apr_2007_01_34_31_+1000_WzI5bmHmIjo6WvuS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGLNIPFdBgD/zoJvwRAhJgAJsEfAyjSciXn4mPewjFteL3rqTy+ACfZ6eR
g+l1+DyXI03uCSMEQbZCJH4=
=yWVa
-----END PGP SIGNATURE-----

--Signature=_Tue__24_Apr_2007_01_34_31_+1000_WzI5bmHmIjo6WvuS--
