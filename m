Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 16DB51A024E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 May 2014 19:33:00 +1000 (EST)
Date: Thu, 29 May 2014 19:32:52 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Remove platforms/wsp and associated pieces
Message-ID: <20140529193252.05902952@canb.auug.org.au>
In-Reply-To: <1401353429-29036-1-git-send-email-mpe@ellerman.id.au>
References: <1401353429-29036-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/EaUuCgBPS0NWTB5uxmxRe47"; protocol="application/pgp-signature"
Cc: linuxppc-dev@ozlabs.org, pebolle@tiscali.nl
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/EaUuCgBPS0NWTB5uxmxRe47
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Thu, 29 May 2014 18:50:29 +1000 Michael Ellerman <mpe@ellerman.id.au> wr=
ote:
>
> __attribute__ ((unused))
>=20
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

So this was the only use of CONFIG_PPC_A2 ... so more cleanup
possible :-)

I always appreciate negative work :-)
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/EaUuCgBPS0NWTB5uxmxRe47
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJThv7KAAoJEMDTa8Ir7ZwVyXQP/2U825KK+oXRxtUyIIoyU43S
dQHNzQ5+hzApu/dYlj7cPRDgKlI++oS3idWbFSyZZKmrgmhwMhJFibhdevALlZRN
G851fJ+wdrmhAeLif3jtTHYZpzjoGFCoTk6xNk0e3Vn198IWBrGx+LHMsA+rjCX9
eAmDN4fBavh4DcENXpzO7wvfOpEj8ox2UFPqERDA2Vrkj6ygs7UId2s5yIswXXZ/
heAAXf+hVA0YqxSSY1lTH4T/vM4ipo8i9gt2+NK53GT05Y0wGTt/MScpfFiOiRND
aLB/4FU2IVsKOLyTJp6QyDLKd8BxCIhJq0oYQ6QQROME9JMAhI0P4iqORns84KmF
JmvEHgs/UKsZSa8A3tc44Ywlq4d1hqZCN+C4G5Ph23XNcyyLlKxw+WEevvkN/tEt
+2UzoZab1jClDjKRN0fZ5DKn50Wt8V4jOi6WYJc1PNpySArBuLnX7EHTdJnXhnCf
6mQTGlKpvV9lNDtXl6yyg3rSX9ObPmdQMSrcOT0wtCRAAxhOK3csLOFtiVeByVJY
oprdqOFfq5CkKAEBcOQf2opX4knD2EeboYBmnthhoG7uUXUp2xyfTrgv9dYAZiXd
htHVdQZnnLwaSJcy/SpnEEWLDUWO+DKdoAPg4uJW8MU6yPe+djAAIOkJ7Z7rthQK
JC9E1vGfmZERK6LS6CsW
=grHV
-----END PGP SIGNATURE-----

--Sig_/EaUuCgBPS0NWTB5uxmxRe47--
