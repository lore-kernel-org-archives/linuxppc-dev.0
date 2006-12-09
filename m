Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 899FD67B83
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Dec 2006 16:47:45 +1100 (EST)
Date: Sat, 9 Dec 2006 16:47:38 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] dont allow pSeries_probe to succeed without
	initialising MMU
Message-Id: <20061209164738.61ef7b35.sfr@canb.auug.org.au>
In-Reply-To: <20061208072208.GD29167@krispykreme>
References: <20061208070837.GC29167@krispykreme>
	<20061208072208.GD29167@krispykreme>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__9_Dec_2006_16_47_38_+1100_1N84tfePMxRWHkFa"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sat__9_Dec_2006_16_47_38_+1100_1N84tfePMxRWHkFa
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Fri, 8 Dec 2006 18:22:09 +1100 Anton Blanchard <anton@samba.org> wrote:
>
>  	DBG("Machine is%s LPAR !\n",
>  	    (powerpc_firmware_features & FW_FEATURE_LPAR) ? "" : " not");
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Want to change that to firmware_has_feature(FW_FEATURE_LPAR) while you
are there?

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__9_Dec_2006_16_47_38_+1100_1N84tfePMxRWHkFa
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFek4AFdBgD/zoJvwRAji9AJ9Nm4W5RP3/rGyglZDhC/dpS3iWwQCePwgA
5sG8Imsx7zPL6DIyATHjvUo=
=wMfB
-----END PGP SIGNATURE-----

--Signature=_Sat__9_Dec_2006_16_47_38_+1100_1N84tfePMxRWHkFa--
