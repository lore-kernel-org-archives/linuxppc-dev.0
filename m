Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C86292C00C5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 16:18:47 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dwg@au1.ibm.com>;
 Thu, 11 Apr 2013 16:13:59 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 877322CE804D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 16:18:43 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3B65FPw9568736
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 16:05:15 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3B6IgKg006574
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 16:18:43 +1000
Date: Thu, 11 Apr 2013 16:18:35 +1000
From: David Gibson <dwg@au1.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V5 18/25] powerpc/THP: Double the PMD table size for THP
Message-ID: <20130411061835.GH8165@truffula.fritz.box>
References: <1365055083-31956-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1365055083-31956-19-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="kUr9BK2/TCCh1PYv"
In-Reply-To: <1365055083-31956-19-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--kUr9BK2/TCCh1PYv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2013 at 11:27:56AM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>=20
> THP code does PTE page allocation along with large page request and depos=
it them
> for later use. This is to ensure that we won't have any failures when we =
split
> hugepages to regular pages.
>=20
> On powerpc we want to use the deposited PTE page for storing hash pte slo=
t and
> secondary bit information for the HPTEs. We use the second half
> of the pmd table to save the deposted PTE page.

The previous patch accesses data in that second half of the PMD table,
so this patch should go before it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kUr9BK2/TCCh1PYv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlFmVbsACgkQaILKxv3ab8Z7igCfQFP08UqGTcSoCvL7Uoh0gh2a
hC0AnjGnaz4B06XmMwdlMbPxCxqJdSkB
=iQxQ
-----END PGP SIGNATURE-----

--kUr9BK2/TCCh1PYv--
