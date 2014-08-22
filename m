Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 37E161A015C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Aug 2014 01:25:18 +1000 (EST)
Date: Sat, 23 Aug 2014 01:25:09 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 6/6] powerpc: Separate ppc32 symbol exports into
 ppc_ksyms_32.c
Message-ID: <20140823012509.37afb89e@canb.auug.org.au>
In-Reply-To: <1408485605-10490-6-git-send-email-anton@samba.org>
References: <1408485605-10490-1-git-send-email-anton@samba.org>
 <1408485605-10490-6-git-send-email-anton@samba.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/z5GNTejup59LGb1oZWasYwC"; protocol="application/pgp-signature"
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/z5GNTejup59LGb1oZWasYwC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Anton,

On Wed, 20 Aug 2014 08:00:05 +1000 Anton Blanchard <anton@samba.org> wrote:
>
> diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ks=
yms.c
> index aba41f3..c4dfff6 100644
> --- a/arch/powerpc/kernel/ppc_ksyms.c
> +++ b/arch/powerpc/kernel/ppc_ksyms.c
> @@ -1,135 +1,42 @@
> -#include <linux/export.h>

You removed export.h ...

> +EXPORT_SYMBOL(flush_dcache_range);
> +EXPORT_SYMBOL(flush_icache_range);

But still use EXPORT_SYMBOL ...

Or did I miss something?
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/z5GNTejup59LGb1oZWasYwC
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJT92DbAAoJEMDTa8Ir7ZwVyVoP/16NmuCu0YLAgYAuJa1ERnOD
4nq/X+/zH81itMwNQeckI+e4nIA5PD470TYJZELUs3eNzGlZ9MhRDWnR410CjkLZ
+MvmR5rJi9o7WuwcfCwUZYZDSxPCHeaFX22y7Mkv9jPOWc5iZ4bymfG8tE7WZ/74
BniB1yGleii9imkFVKqs/neSoIEGAJJzuLWbPhuFMN/XfJT6AYx8BjvKiEBJPDga
hqH/n2X42SZCNqydkjbGaLZiDss97WPSjvVCQc0MSnDfwnpxAaK8Nae9R9Mc67PO
EyO4zz34W7KM96vHoSMW8EtnHzgKHbve5e7KuDPlsAXdrdUtZqyFGtCimDLv0bRH
R/b18r226P9grYdO0mQ6U1Beh0v6BBth0zRXl/lCTNhv1YgV1JYav86cyebAT2P4
TZD4CLezCgy/gtfObouf3OFmMV4SpSTt4+YdwaXs3pOjA5pMAJ7pPt8+rAD5D1fv
gMliuXL+mjxCRhF9L81EEH3xvDa8+QVFt7lbhiC1BHFHz90gs+xAqzluaVdC7p0p
aqGEK05sXb9mmcYY2jQvRuvDnC/0E/HmQ+qyl5m7FD33+fNYsxXEUGZt4ePqA//o
vIzFD/6HdlEhNsZruvHyPSwB7NEPtpr2qR+rms3R5aO1ul6Y8iWE7UXCpKzbc1tD
bVHzCX4FrxBikr+KQerp
=95di
-----END PGP SIGNATURE-----

--Sig_/z5GNTejup59LGb1oZWasYwC--
