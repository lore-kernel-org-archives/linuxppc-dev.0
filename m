Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AD70C1A0749
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 14:39:08 +1100 (AEDT)
Date: Tue, 20 Jan 2015 14:39:02 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 2/7] powerpc: Enable on demand governor on ppc64_defconfig
Message-ID: <20150120143902.0f092f20@canb.auug.org.au>
In-Reply-To: <1421709865-6368-2-git-send-email-anton@samba.org>
References: <1421709865-6368-1-git-send-email-anton@samba.org>
 <1421709865-6368-2-git-send-email-anton@samba.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/N9oYafZLp/7ROdCy6gwb1dz"; protocol="application/pgp-signature"
Cc: nacc@linux.vnet.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/N9oYafZLp/7ROdCy6gwb1dz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Anton,

On Tue, 20 Jan 2015 10:24:20 +1100 Anton Blanchard <anton@samba.org> wrote:
>
> This was enabled on the pseries defconfigs recently, but missed
> the ppc64 one.

So do any of the options you enable in thelater patches need to be
enabled for ppc64_defconfig as well?

I am wondering if we could do more of these in Kconfig entries ...
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/N9oYafZLp/7ROdCy6gwb1dz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJUvc3bAAoJEMDTa8Ir7ZwVBw4P/jpxkmXQ0pkNrhEpH3drdCe0
AviHvDY9Bwi0gisZf94jMgY8J/4nuW6LT6ZhDtboJVOPQfH6aQ0zwO/NEzO9yHYP
W927LKeKipGkT4HXJwKu6CFyxuo1WKX5O9GcwZhWc18t2FS0Mno9l4/7b3sVft08
ic7UGa34ZdencqCTLt2bEkl1QM+BV3XyDcw4rc//hyaF2WN3DvW6oRAKeJ8uRZy6
wVx+xYlap8e9t/4FCdAO41RjID14dJpdLxg+FuOU/dluPbUavVqFsPMrfH58g2zY
UUgSxivRvCsmw02uzrSWqdsf5W8mvEd4f0W+pLlRN00gOUohbjDyICjDIuyD5GeO
L+xenBT0qM+o2nM6eEurn6O7FI7H5XcLUUzYIj2ed+FLMqkI1NstAOgrCRMWCLGY
zf5+xcq2O0/NuetBrOLCN5yCqoF2PLawoUr5ubQZRzIkwfzeAu6anr1JgIyog7/j
iQiTQDLz1sTBehoywcfF0rbc8f50x2VNzkKbU5TAAHTvgFo5bj9bs//XVq89j3ao
CJZIuVp9RkmiP2VYl7aDj3Mtf8IAk5T33hTXZBPPS285kuDaB/TmvOpttgRMDrq7
Yo5PyHRm6hF2pheZVEGHNX/1+3vJnnZAfHLdoWHRlSBzJ9J6egK+cUbI1s1Kkn9E
6Yd9K+Dsp3bj1HGF3NNe
=Y1mW
-----END PGP SIGNATURE-----

--Sig_/N9oYafZLp/7ROdCy6gwb1dz--
