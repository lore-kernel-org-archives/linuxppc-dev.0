Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Qwjg1p69zF35W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2018 09:47:51 +1000 (AEST)
Date: Thu, 12 Jul 2018 09:47:29 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>,
 osalvador@techadventures.net, mpe@ellerman.id.au, broonie@kernel.org,
 mhocko@suse.cz, linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Linux Memory Management List <linux-mm@kvack.org>, LKML
 <linux-kernel@vger.kernel.org>, mm-commits@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhe@redhat.com, aneesh.kumar@linux.ibm.com,
 khandual@linux.vnet.ibm.com
Subject: Re: Boot failures with "mm/sparse: Remove
 CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER" on powerpc (was Re: mmotm
 2018-07-10-16-50 uploaded)
Message-ID: <20180712094729.1112f290@canb.auug.org.au>
In-Reply-To: <20180711141344.10eb6d22b0ee1423cc94faf8@linux-foundation.org>
References: <20180710235044.vjlRV%akpm@linux-foundation.org>
 <87lgai9bt5.fsf@concordia.ellerman.id.au>
 <20180711133737.GA29573@techadventures.net>
 <CAGM2reYsSi5kDGtnTQASnp1v49T8Y+9o_pNxmSq-+m68QhF2Tg@mail.gmail.com>
 <20180711141344.10eb6d22b0ee1423cc94faf8@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/EYBWYqRmT+9CpTkc3L=Ei9_"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/EYBWYqRmT+9CpTkc3L=Ei9_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Wed, 11 Jul 2018 14:13:44 -0700 Andrew Morton <akpm@linux-foundation.org=
> wrote:
>
> OK, I shall drop
> mm-sparse-remove-config_sparsemem_alloc_mem_map_together.patch for now.

I have dropped it from linux-next today (in case you don't get time).

--=20
Cheers,
Stephen Rothwell

--Sig_/EYBWYqRmT+9CpTkc3L=Ei9_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltGlxEACgkQAVBC80lX
0GwoUwf/bx0m01nkKzrGDRN2EbV745BfGn4LcFCUqgnVbtIwvCgd21+BSMQKZeBQ
hXceLO2LFHU5+BQxG8CsGyLob2rijmXu35ie3boJKXPjMPdng8QaCCtSDyUkjTuu
XkiNYUspbTMVZWlnHX3tFV0Urm4SI7xHOG5lrE/c58rLoJnTOqL9ssC2cdiN0j2w
glkgPVXLSljiB5RwUmF/cXf3Q6knDeHF2f3XikAlUjKv5NIa+JR3wz1H/pzzIw7K
kSVxPcRjwRBaAmqxPMep92ZpthSBZ9sJfTxQajHFyTKfgpSfWB6aP8FuavEL8zuC
xHM1AI0ggVguLGhN2yKqtxRw77KLmQ==
=c4bd
-----END PGP SIGNATURE-----

--Sig_/EYBWYqRmT+9CpTkc3L=Ei9_--
