Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3C6BC2C00CE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 16:05:41 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dwg@au1.ibm.com>;
 Thu, 11 Apr 2013 16:00:01 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 8F6482BB0023
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 16:05:37 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3B65WDG7733676
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 16:05:32 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3B65aDi024568
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 16:05:37 +1000
Date: Thu, 11 Apr 2013 15:57:19 +1000
From: David Gibson <dwg@au1.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V5 12/25] powerpc: Return all the valid pte ecndoing in
 KVM_PPC_GET_SMMU_INFO ioctl
Message-ID: <20130411055719.GF8165@truffula.fritz.box>
References: <1365055083-31956-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1365055083-31956-13-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130411032447.GU8165@truffula.fritz.box>
 <874nfdodlu.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="k040vn1t/h12DMPO"
In-Reply-To: <874nfdodlu.fsf@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--k040vn1t/h12DMPO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2013 at 10:41:57AM +0530, Aneesh Kumar K.V wrote:
> David Gibson <dwg@au1.ibm.com> writes:
>=20
> > On Thu, Apr 04, 2013 at 11:27:50AM +0530, Aneesh Kumar K.V wrote:
> >> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> >
> > Surely this can't be correct until the KVM H_ENTER implementation is
> > updated to cope with the MPSS page sizes.
>=20
> Why ? We are returning info regarding penc values for different
> combination. I would guess qemu to only use info related to base page
> size. Rest it can ignore right ?. Obviously i haven't tested this
> part. So let me know if I should drop this ?

The guest can't actually use those encodings unless the host's H_ENTER
allows it to, though, so this patch should be moved after extended
that KVM support.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--k040vn1t/h12DMPO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlFmUL8ACgkQaILKxv3ab8aJCACeOcEiDD1hRF2jKSZ+grlgeEmv
CGQAn3Wg6OUWGgyH+DE3rgdgwwV8MWLe
=7Ky2
-----END PGP SIGNATURE-----

--k040vn1t/h12DMPO--
