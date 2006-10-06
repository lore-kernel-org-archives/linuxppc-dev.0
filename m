Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 42C2D67EA9
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Oct 2006 12:35:59 +1000 (EST)
Date: Fri, 6 Oct 2006 06:35:40 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] powerpc: fix fsl_soc build breaks
Message-ID: <20061006063540.1b5c9528@localhost.localdomain>
In-Reply-To: <20061005211648.0d550152@pb15>
References: <20061005211648.0d550152@pb15>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_4WTd0IpFZsFYIgux4vvO0na;
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_4WTd0IpFZsFYIgux4vvO0na
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Oct 2006 21:16:48 -0500
Olof Johansson wrote:

> Hrm, there's no way this ever built at time of merge. There's a
> missing } and the wrong type on phy_irq.
>=20
> Also, another const for get_property().
>=20
>=20
>   CC      arch/powerpc/sysdev/fsl_soc.o
> arch/powerpc/sysdev/fsl_soc.c: In function 'fs_enet_of_init':
> arch/powerpc/sysdev/fsl_soc.c:625: error: assignment of read-only
> variable 'phy_irq' arch/powerpc/sysdev/fsl_soc.c:625: warning:
> assignment makes integer from pointer without a cast
> arch/powerpc/sysdev/fsl_soc.c:661: warning: assignment discards
> qualifiers from pointer target type
> arch/powerpc/sysdev/fsl_soc.c:684: error: subscripted value is
> neither array nor pointer arch/powerpc/sysdev/fsl_soc.c:687: error:
> subscripted value is neither array nor pointer
> arch/powerpc/sysdev/fsl_soc.c:722: warning: ISO C90 forbids mixed
> declarations and code arch/powerpc/sysdev/fsl_soc.c:728: error:
> invalid storage class for function 'cpm_uart_of_init'
> arch/powerpc/sysdev/fsl_soc.c:798: error: initializer element is not
> constant arch/powerpc/sysdev/fsl_soc.c:798: error: expected
> declaration or statement at end of input make[1]: ***
> [arch/powerpc/sysdev/fsl_soc.o] Error 1
>=20
>=20
> Signed-off-by: Olof Johansson <olof@lixom.net>
>=20
>=20
> ---
>=20
> There are more issues with this file. Whitespace, if () {}; and other
> things. I'm just fixing the build breaks.
>=20
> These were all introduced by patches fed upstream via git trees
> instead of list posts, as far as I can tell. Maybe posting patches is
> a better idea, more eyes on the code.
>=20

All those were submitted in form of patches prior, and located issues addre=
ssed. I must mistype something with git-push,
so it didn't fed in very latest changes. Thanks for pointing it out and sor=
ry for confusion.

--
Sincerely, Vitaly

--Sig_4WTd0IpFZsFYIgux4vvO0na
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFJcD8uOg9JvQhSEsRAilZAJ9z2huq0aovwaqEfI5BrVlUFasPFACcDgMk
Qa6GGNCqOCWKbHP/JcVTLX4=
=qAdB
-----END PGP SIGNATURE-----

--Sig_4WTd0IpFZsFYIgux4vvO0na--
