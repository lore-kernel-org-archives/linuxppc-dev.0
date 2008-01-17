Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 166CFDDE29
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 17:39:38 +1100 (EST)
Date: Thu, 17 Jan 2008 17:39:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 1/2] Make setjmp/longjmp code generic
Message-Id: <20080117173929.59581ddf.sfr@canb.auug.org.au>
In-Reply-To: <20080117044542.2F6CD70006@localhost.localdomain>
References: <1200545142.37022.89292279731.qpush@coopers>
	<20080117044542.2F6CD70006@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__17_Jan_2008_17_39_29_+1100_LyS=A3DwBjvFG/Te"
Cc: linuxppc-dev@ozlabs.org, RAISCH@de.ibm.com,
	Paul Mackerras <paulus@samba.org>, THEMANN@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__17_Jan_2008_17_39_29_+1100_LyS=A3DwBjvFG/Te
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Jan 2008 15:45:42 +1100 Michael Neuling <mikey@neuling.org> wrot=
e:
>
> +++ linux-2.6-ozlabs/arch/powerpc/kernel/misc.S
> @@ -8,6 +8,8 @@
>   * Adapted for iSeries by Mike Corrigan (mikejc@us.ibm.com)
>   * PPC64 updates by Dave Engebretsen (engebret@us.ibm.com)
>   *
> + * setjmp/longjmp and xmon_save_regs code by Paul Mackerras.
                         ^^^^^^^^^^^^^^
This doesn't exist here.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__17_Jan_2008_17_39_29_+1100_LyS=A3DwBjvFG/Te
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHjvgpTgG2atn1QN8RAmx7AJ95ht+FI142sSfQ/u+HwDFDXKu0OwCdGisO
S2KK3uycT6z+Fj7Of98/lsw=
=qGlN
-----END PGP SIGNATURE-----

--Signature=_Thu__17_Jan_2008_17_39_29_+1100_LyS=A3DwBjvFG/Te--
