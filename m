Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 4253967A39
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Dec 2006 15:41:56 +1100 (EST)
Date: Fri, 1 Dec 2006 15:41:53 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: michael@ellerman.id.au
Subject: Re: [POWERPC] Allow xmon to build on legacy iSeries
Message-Id: <20061201154153.b0f8b9dc.sfr@canb.auug.org.au>
In-Reply-To: <1164931474.5348.3.camel@concordia.ozlabs.ibm.com>
References: <20061130114409.994a661e.sfr@canb.auug.org.au>
	<1164848648.27764.2.camel@concordia.ozlabs.ibm.com>
	<20061130160459.4f617199.sfr@canb.auug.org.au>
	<1164931474.5348.3.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__1_Dec_2006_15_41_53_+1100_VSm8DYaLOvyItU0M"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__1_Dec_2006_15_41_53_+1100_VSm8DYaLOvyItU0M
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Fri, 01 Dec 2006 11:04:34 +1100 Michael Ellerman <michael@ellerman.id.au> wrote:
>
> ps. why are you including <asm/iseries/it_lp_reg_save.h> instead of
> firmware.h?

Because firmware.h is already included and we need it_lp_reg_save.h to
make the file build at all on iSeries.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__1_Dec_2006_15_41_53_+1100_VSm8DYaLOvyItU0M
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFb7KRFdBgD/zoJvwRAly3AJ9B8wea8xUMpVQD9RygLDFurauOxwCeIYVi
CLuoXwWoy9Cu7FA/C2xjQ1s=
=YBcY
-----END PGP SIGNATURE-----

--Signature=_Fri__1_Dec_2006_15_41_53_+1100_VSm8DYaLOvyItU0M--
