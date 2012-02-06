Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.pcug.org.au [203.10.76.10])
 by ozlabs.org (Postfix) with ESMTP id CC0A91007D2
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Feb 2012 11:31:12 +1100 (EST)
Date: Mon, 6 Feb 2012 11:30:59 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/wsp: Permanently enable PCI class code workaround
Message-Id: <20120206113059.346b449e6bc7f2a5086fcfa3@canb.auug.org.au>
In-Reply-To: <1328485804.30631.10.camel@pasglop>
References: <1328485804.30631.10.camel@pasglop>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Mon__6_Feb_2012_11_30_59_+1100_cC7zNw3U197w6b50"
Cc: Jimi Xenidis <jimix@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Mon__6_Feb_2012_11_30_59_+1100_cC7zNw3U197w6b50
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben,

Just a small grammar correction:

On Mon, 06 Feb 2012 10:50:04 +1100 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> -	/* WSP DD1 has a bogus class code by default in the PCI-E
> -	 * root complex's built-in P2P bridge */
> +	/*
> +	 * Some WSP variants  has a bogus class code by default in the PCI-E
                             ^^^^
have

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Mon__6_Feb_2012_11_30_59_+1100_cC7zNw3U197w6b50
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJPLx9DAAoJEECxmPOUX5FEbvYP/RhvmTO8yyh1kt9Hp8Q/udYZ
+w+PlgeqaZYWL0jwabNnKFk79W5uXz9xBDTvgSXWVi11NaN2WkieBbwix4mhG/qu
gCWHhd/cc1g5nBMlNJ8w1sY7y3lbaJrwDM/n1Vb+NLDCaMU9wUI1bFsZsPpmS0vo
TyMl9bOTvPcq82K4hmk4o7RSo5H8fiT3D/lZEfAbm+kLxlxaTwXkRsHwhAMDy1W+
Dz6hmgJDA3ZZupbsW5tu/p27cxtwfkTjvi0NaroyKKMzK0414vw85LHdQN6t+ciD
t1zKfxLCcWeiQHeezpincuXLqRn6KBTlDFiL38tyr4gQasBmIVC6ZM3tzH5ift6X
tfA1/2N5NERQuNjx/wQgkoHQz7onXfWsX+oMt3KFmisye8ojmWJfwl6zLhCKCCaV
LIUy9vgyZdqvcC81nmIn7OEt3Le1yIyzOGfi8Mi4fF7fx4Bd/o7brhUPNYgwnPGW
QNrzNFpGC2A2QuFjVmK5KhZLtoohi6B2KpDaBNRdZ3I2HD10yTqjJQTNZqA9FKbr
wutvv3fnNjNZEBn2PjD/FQOfR6EEKn8phGdlR6mo62QP4TzoaZiHQueHxqruK3NB
e2XSuO+nGmu7X91ww83eWRsZ5Q8PZ2+yxrEZVZ8zbecu20+gr4RYDQE//O9lH0Gl
Ndm4SoD1Txke4vcmJLTM
=usUR
-----END PGP SIGNATURE-----

--Signature=_Mon__6_Feb_2012_11_30_59_+1100_cC7zNw3U197w6b50--
