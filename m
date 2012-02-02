Return-Path: <vapier@gentoo.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 18971104785
 for <linuxppc-dev@ozlabs.org>; Fri,  3 Feb 2012 03:35:11 +1100 (EST)
From: Mike Frysinger <vapier@gentoo.org>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH] Implement GET_IP/SET_IP for powerpc architecture.
Date: Thu, 2 Feb 2012 11:28:46 -0500
References: <20120202144125.GA6221@linux.vnet.ibm.com>
In-Reply-To: <20120202144125.GA6221@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3436184.K5jcuRBvpI";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <201202021128.49188.vapier@gentoo.org>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--nextPart3436184.K5jcuRBvpI
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thursday 02 February 2012 09:41:25 Srikar Dronamraju wrote:
> +#define GET_FP(regs)		(0)
> +#define SET_FP(regs, val)

ppc doesn't have a standard FP location ?

> +#define profile_pc(regs) GET_IP(regs)

pretty sure you don't need this as asm-generic/ptrace.h already has a=20
definition for you
=2Dmike

--nextPart3436184.K5jcuRBvpI
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPKrnAAAoJEEFjO5/oN/WB9wYP/jFM3l1/KyJRKDEP3LtXOV/6
k70MyzY7Xu3/K5nWOfgQugd2gwwhbY2IDAudl22a4ZazndFd3WpK4mX+TH3KKpoU
2OGdDEZ8HkRvFiPdheXsqGRbKWt01YYZtoedcRF6ZdzyNNpKvRta9Q4x0fnDieUL
DAC/D3ztDlpJQ5FInW2rGOLtNtpAD2MVYT9I+GC/ApEd0R2OT3c+0wbXommffN1D
7KXvFTHXPRubX81GajCjDvvGTqqye+LHJ455PAwUc8ade3oGxw/J7nkAviaJCQur
TpESM99YBaAlsZjN4gLd7Q9yIoK1QmTPLmLJQYDjsIiT4IpeqSmhf1Sh3K4LR5Sh
nXLPQKxSulL7BpbUlnBmdu3CDoiGTY25SD2iiOjFYV6rwrQC7JFSxhTNdXVF0Sfm
IMmOVBGNqWEs1lr5oIOpYm+BaZkEA66m/CIswrddNeJlZoUAGPIBej/nJ+r6DOE4
vnOXdDsT6Q0UX21qDNsYtjvVH7EFhO15jaJnoADb5ff9LACCun+V5Gz5WZbsxF4V
apcfUrkGqZrUSUaxWr9F2JB8nmoJ6sCZCUFIb51TX9vcnUc6buMqenucrDWwxkj6
hLY1MSeahHLT3ru2HP7LW9bYTlLn97WjXbVuM4rnb8Td53LG1k3KQCnT2SkyYNTD
YDIaZxP7Sa6/3WWq8N2p
=uSBc
-----END PGP SIGNATURE-----

--nextPart3436184.K5jcuRBvpI--
