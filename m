Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id AF1A867CEC
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Oct 2006 14:06:26 +1100 (EST)
Date: Tue, 31 Oct 2006 14:06:07 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: map 4K iommu pages even on 64K largepage systems
Message-Id: <20061031140607.388d7e4e.sfr@canb.auug.org.au>
In-Reply-To: <1162185359.25682.165.camel@localhost.localdomain>
References: <1162185359.25682.165.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__31_Oct_2006_14_06_07_+1100_U/Te+v/t.qorYcmR"
Cc: Olof Johansson <olof@lixom.net>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__31_Oct_2006_14_06_07_+1100_U/Te+v/t.qorYcmR
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 30 Oct 2006 16:15:59 +1100 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>
> iSeries friendly version of it. Needs to go to RHEL5 too.

Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>
--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__31_Oct_2006_14_06_07_+1100_U/Te+v/t.qorYcmR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFRr2kFdBgD/zoJvwRAq6iAJ9OAl8MeEo6huEjXWQsA92pP67rwgCffLLN
rreyIANCAdiq7PEUnhVdOjg=
=R856
-----END PGP SIGNATURE-----

--Signature=_Tue__31_Oct_2006_14_06_07_+1100_U/Te+v/t.qorYcmR--
