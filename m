Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 2CF7DDE842
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 18:40:15 +1000 (EST)
Date: Thu, 21 Aug 2008 18:40:08 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: powerpc allmodconfig in current -mm
Message-Id: <20080821184008.d363d5c6.sfr@canb.auug.org.au>
In-Reply-To: <18604.63159.163718.167197@drongo.ozlabs.ibm.com>
References: <20080820181626.0347c270.akpm@linux-foundation.org>
	<18604.63159.163718.167197@drongo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__21_Aug_2008_18_40_08_+1000_T9q9GXWIjUDvk9WI"
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__21_Aug_2008_18_40_08_+1000_T9q9GXWIjUDvk9WI
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Thu, 21 Aug 2008 15:01:43 +1000 Paul Mackerras <paulus@samba.org> wrote:
>
> OK.  I think we need to export CMO_PrPSP and CMO_SecPSP as well.
> (Lovely names. :()

These are only used (indirectly) in lparcfg.c which is never a module, so
should be OK.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__21_Aug_2008_18_40_08_+1000_T9q9GXWIjUDvk9WI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkitKegACgkQjjKRsyhoI8y7BwCfcENt6N38WwxMY4vQ1Ib1b5gr
z/4An04NqnSkYEbdE0oYIzSHINCnLUHO
=br7j
-----END PGP SIGNATURE-----

--Signature=_Thu__21_Aug_2008_18_40_08_+1000_T9q9GXWIjUDvk9WI--
