Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0B6D12C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 16:33:23 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dwg@au1.ibm.com>;
 Sat, 4 May 2013 16:28:10 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8DA24357804A
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 16:33:05 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r446JINT20119762
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 4 May 2013 16:19:19 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r446X4sI006348
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 4 May 2013 16:33:05 +1000
Date: Sat, 4 May 2013 16:28:25 +1000
From: David Gibson <dwg@au1.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V7 04/10] powerpc: Update find_linux_pte_or_hugepte to
 handle transparent hugepages
Message-ID: <20130504062825.GY13041@truffula.fritz.box>
References: <1367178711-8232-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1367178711-8232-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130503045323.GP13041@truffula.fritz.box>
 <87ip2z51rn.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="5OPIRG5sBUHnKBkK"
In-Reply-To: <87ip2z51rn.fsf@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--5OPIRG5sBUHnKBkK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 04, 2013 at 12:28:20AM +0530, Aneesh Kumar K.V wrote:
> David Gibson <dwg@au1.ibm.com> writes:
>=20
> > On Mon, Apr 29, 2013 at 01:21:45AM +0530, Aneesh Kumar K.V wrote:
> >> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> >
> > What's the difference in meaning between pmd_huge() and pmd_large()?
> >
>=20
> #ifndef CONFIG_HUGETLB_PAGE
> #define pmd_huge(x)	0
> #endif
>=20
> Also pmd_large do check for THP PTE flag, and _PAGE_PRESENT.

I don't mean what's the code difference.  I mean what is the semantic
difference between pmd_huge() and pmd_large() supposed to be - in
words.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5OPIRG5sBUHnKBkK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlGEqokACgkQaILKxv3ab8YR7ACeIEQXWQ200IRwwwUy4XG/QqnR
VjkAn0XwLDa00t5eDnow51Yfq1F6Rc0V
=R2xM
-----END PGP SIGNATURE-----

--5OPIRG5sBUHnKBkK--
