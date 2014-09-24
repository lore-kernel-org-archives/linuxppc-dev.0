Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F8DB1A0181
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 16:34:17 +1000 (EST)
Date: Wed, 24 Sep 2014 16:34:10 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/3] powerpc: Don't build powernv for other platform
 defconfigs
Message-ID: <20140924163410.4f1ad720@canb.auug.org.au>
In-Reply-To: <1411538232-31516-1-git-send-email-mpe@ellerman.id.au>
References: <1411538232-31516-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/R5z4qkIktVMMDIFa01Nlyk+"; protocol="application/pgp-signature"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/R5z4qkIktVMMDIFa01Nlyk+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Wed, 24 Sep 2014 15:57:10 +1000 Michael Ellerman <mpe@ellerman.id.au> wr=
ote:
>
> Because powernv arrived after these other platforms, the defconfigs
> didn't have PPC_POWERNV disabled, and being default y it gets turned on.

Well, that raises the question of why PPC_POWERNV is default y at all?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/R5z4qkIktVMMDIFa01Nlyk+
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJUImXnAAoJEMDTa8Ir7ZwVr18P/2S2K4vcOmapqDulCs5O0puI
M21IyF9XniIlv44uAZixcKohdDQiF/23G/oMOdMDWnHPvs9p4On6w/cyn0NMHDon
9/B1Tkg23/7nDDV2XzAVKixwwKazU1qnuKfYQW7w5/Ud4idAtT45aBPfBuOVZeOt
Tafk6avlEhbkwR9ZVHDn8oLO1XxlZrdYyXv1X9rTsDHEmSxaNLOHifzYEmRML/P2
ke/T5u3YBpdnTFqH/914DbxHuWNN5wrB8k23oZM4KptMPEMiK9NM49MSGVGWN2Yv
0/jw3UuHr5PA5d8HybCKCnHteVPmyo8GZ03IX6VWkgG9LdB0vm6nDNtvH7AUiFDT
7FnNu98L0ki2NjsaQZpsYGMJU8PDHx/gUiYAjHVd7JDo6WwL+cZAaCukXaeM6A1i
yXyxFMIrPRwDCvPh4SMO8J4YAgODLtKjcbMrWwzNGu6KUPsC6Ar7jeOTh7/tPoVF
4fpLQGn1t8gmdrgOXgQUhEXgaxXgVqeAIJSI+zdRXYA9HjBgkufV7t2JdkyKIsob
wb3I7NDqHvjzMZIcaJ6PpT16izqsD/2Ns68DGqErjlkGqVOG8gxu1i8ZA2dCY0Td
Nn3w1nC0M4ooXY4sDotSwVRZbw4Z4Nl8eZsIWtep6l7fRKlwi1dCX2MGSb0yZ7gr
CRhxAUOQmRjUNZp6Ue7p
=LjF7
-----END PGP SIGNATURE-----

--Sig_/R5z4qkIktVMMDIFa01Nlyk+--
