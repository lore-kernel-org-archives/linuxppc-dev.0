Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 112ABDDE3E
	for <linuxppc-dev@ozlabs.org>; Sat, 12 May 2007 13:45:35 +1000 (EST)
Date: Sat, 12 May 2007 13:45:29 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] U-boot passes the initrd as start/end, not start/size.
Message-Id: <20070512134529.fe14f441.sfr@canb.auug.org.au>
In-Reply-To: <20070511175202.GA14644@ld0162-tx32.am.freescale.net>
References: <20070511175202.GA14644@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__12_May_2007_13_45_29_+1000_2bcwGjs+FM/wsHBN"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sat__12_May_2007_13_45_29_+1000_2bcwGjs+FM/wsHBN
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Fri, 11 May 2007 12:52:03 -0500 Scott Wood <scottwood@freescale.com> wrote:
>
>  	loader_info.initrd_addr = r4;
> -	loader_info.initrd_size = r4 ? r5 : 0;
> +	loader_info.initrd_size = r4 ? r5 - r4 : 0;

So do we need a "+ 1" here, or does r5 contain the address past the initrd?

>  	loader_info.initrd_addr = r4;
> -	loader_info.initrd_size = r4 ? r5 : 0;
> +	loader_info.initrd_size = r4 ? r5 - r4 : 0;

And here?

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__12_May_2007_13_45_29_+1000_2bcwGjs+FM/wsHBN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGRTheFdBgD/zoJvwRApooAJ9INqIBaHuN5Et1gmSV5L4clPA8hACfTpBi
SQnMuilShhyy+ZDWQkpyqeQ=
=ROLW
-----END PGP SIGNATURE-----

--Signature=_Sat__12_May_2007_13_45_29_+1000_2bcwGjs+FM/wsHBN--
