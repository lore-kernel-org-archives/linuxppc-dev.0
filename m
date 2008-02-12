Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id C79E7DDECC
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 21:18:25 +1100 (EST)
Date: Tue, 12 Feb 2008 21:18:20 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Manish Ahuja <ahuja@austin.ibm.com>
Subject: Re: [PATCH 6/8] pseries: phyp dump: Invalidate and print dump areas.
Message-Id: <20080212211820.439dad00.sfr@canb.auug.org.au>
In-Reply-To: <47B1483E.8040303@austin.ibm.com>
References: <4782B985.2090508@austin.ibm.com> <47B13D2E.1070001@austin.ibm.com>
	<47B1483E.8040303@austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__12_Feb_2008_21_18_20_+1100_agd2wjuoqh07rs7P"
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, linasvepstas@gmail.com,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__12_Feb_2008_21_18_20_+1100_agd2wjuoqh07rs7P
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Manish,

On Tue, 12 Feb 2008 01:18:22 -0600 Manish Ahuja <ahuja@austin.ibm.com> wrot=
e:
>
> -static void
> -release_memory_range(unsigned long start_pfn, unsigned long nr_pages)
> +static
> +void release_memory_range(unsigned long start_pfn, unsigned long nr_page=
s)

Cosmetic changes like this should normally be put in separate patch as
they just distract from a real review (which this isn't :-))

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__12_Feb_2008_21_18_20_+1100_agd2wjuoqh07rs7P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHsXJyTgG2atn1QN8RAvhoAJ9GypmsNWx4yU5k8sHFbK3Wdua31wCfUF/T
mzRK+VtyVdIh1l+iX4w8sUg=
=aSVT
-----END PGP SIGNATURE-----

--Signature=_Tue__12_Feb_2008_21_18_20_+1100_agd2wjuoqh07rs7P--
