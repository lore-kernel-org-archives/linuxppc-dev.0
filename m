Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 888F1DDF2C
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 10:34:19 +1100 (EST)
Date: Tue, 18 Mar 2008 10:31:05 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: =?UTF-8?B?Uy7Dh2HEn2xhcg==?= Onur <caglar@pardus.org.tr>
Subject: Re: [PATCH] arch/powerpc/platforms/iseries/pci.c: Use time_* macros
Message-Id: <20080318103105.9482a8d4.sfr@canb.auug.org.au>
In-Reply-To: <1205746593-24820-4-git-send-email-caglar@pardus.org.tr>
References: <1205746593-24820-1-git-send-email-caglar@pardus.org.tr>
	<1205746593-24820-2-git-send-email-caglar@pardus.org.tr>
	<1205746593-24820-3-git-send-email-caglar@pardus.org.tr>
	<1205746593-24820-4-git-send-email-caglar@pardus.org.tr>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__18_Mar_2008_10_31_05_+1100_EU0ekh9klEP8wsPr"
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__18_Mar_2008_10_31_05_+1100_EU0ekh9klEP8wsPr
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Mar 2008 11:36:26 +0200 S.=C3=87a=C4=9Flar Onur <caglar@pardus.o=
rg.tr> wrote:
>
> The functions time_before, time_before_eq, time_after, and time_after_eq =
are more robust for comparing jiffies against other values.
>=20
> So following patch implements usage of the time_after() macro, defined at=
 linux/jiffies.h, which deals with wrapping correctly
>=20
> Cc: linuxppc-dev@ozlabs.org
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>

Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__18_Mar_2008_10_31_05_+1100_EU0ekh9klEP8wsPr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH3v89TgG2atn1QN8RAsVjAKCJa01WiUaCCNbzwXoytMojbA+gUACfcUY5
SciRyIAq5SDecolsmmJkECE=
=/qD6
-----END PGP SIGNATURE-----

--Signature=_Tue__18_Mar_2008_10_31_05_+1100_EU0ekh9klEP8wsPr--
