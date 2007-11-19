Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B1BCADDDE9
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Nov 2007 13:38:47 +1100 (EST)
Date: Mon, 19 Nov 2007 13:38:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [PATCH] 2.6.24-rc2-mm1 powerpc (iseries)- build failure -
	mm/stab.c
Message-Id: <20071119133849.bcfe52c1.sfr@canb.auug.org.au>
In-Reply-To: <20071114105410.GA16846@linux.vnet.ibm.com>
References: <20071114105410.GA16846@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__19_Nov_2007_13_38_49_+1100_xyk31yLXh2SRmrC."
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, anton@au1.ibm.com,
	paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__19_Nov_2007_13_38_49_+1100_xyk31yLXh2SRmrC.
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kamalesh,

On Wed, 14 Nov 2007 16:24:10 +0530 Kamalesh Babulal <kamalesh@linux.vnet.ib=
m.com> wrote:
>
> +#ifdef CONFIG_PPC_ISERIES
> +#include <asm/iseries/hv_call.h>
> +#endif /* CONFIG_PPC_ISERIES */

You should not need the #ifdef and we prefer not to ifdef include unless
necessary.  Please resubmit.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__19_Nov_2007_13_38_49_+1100_xyk31yLXh2SRmrC.
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHQPc+TgG2atn1QN8RAh1RAJ47QqPkhtAVx4E+cQrivYhDDiqB6ACggkrS
T7OqZN4gyXYmukKyGdprf+8=
=JXY1
-----END PGP SIGNATURE-----

--Signature=_Mon__19_Nov_2007_13_38_49_+1100_xyk31yLXh2SRmrC.--
