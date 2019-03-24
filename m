Return-Path: <SRS0=5voM=R3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B041C43381
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 Mar 2019 23:07:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD2802133F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 Mar 2019 23:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD2802133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44SChY6sFgzDqMp
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 10:07:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=decadent.org.uk
 (client-ip=88.96.1.126; helo=shadbolt.e.decadent.org.uk;
 envelope-from=ben@decadent.org.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=decadent.org.uk
Received: from shadbolt.e.decadent.org.uk (shadbolt.e.decadent.org.uk
 [88.96.1.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44SCfq3twBzDqKv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 10:05:39 +1100 (AEDT)
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
 by shadbolt.decadent.org.uk with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ben@decadent.org.uk>)
 id 1h8CB6-0004M1-8H; Sun, 24 Mar 2019 23:05:20 +0000
Received: from ben by deadeye with local (Exim 4.92)
 (envelope-from <ben@decadent.org.uk>)
 id 1h8CB5-00025D-Jw; Sun, 24 Mar 2019 23:05:19 +0000
Message-ID: <eb21be1ac183dd206da3a389b426707c535c463c.camel@decadent.org.uk>
Subject: Re: powerpc/mm: Only define MAX_PHYSMEM_BITS in SPARSEMEM
 configurations
From: Ben Hutchings <ben@decadent.org.uk>
To: Andreas Schwab <schwab@linux-m68k.org>, Michael Ellerman
 <patch-notifications@ellerman.id.au>
Date: Sun, 24 Mar 2019 23:05:14 +0000
In-Reply-To: <87k1gnq5lp.fsf@igel.home>
References: <20190317011756.abjylw3nzfnc6gnh@decadent.org.uk>
 <44QjSh4zGhz9sV2__48832.6491251186$1553257542$gmane$org@ozlabs.org>
 <87k1gnq5lp.fsf@igel.home>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-r1ufRG9LhmC7mNONhTXl"
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk);
 SAEximRunCond expanded to false
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--=-r1ufRG9LhmC7mNONhTXl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2019-03-24 at 23:18 +0100, Andreas Schwab wrote:
> On M=C3=A4r 22 2019, Michael Ellerman <patch-notifications@ellerman.id.au=
> wrote:
>=20
> > On Sun, 2019-03-17 at 01:17:56 UTC, Ben Hutchings wrote:
> > > MAX_PHYSMEM_BITS only needs to be defined if CONFIG_SPARSEMEM is
> > > enabled, and that was the case before commit 4ffe713b7587
> > > ("powerpc/mm: Increase the max addressable memory to 2PB").
> > >=20
> > > On 32-bit systems, where CONFIG_SPARSEMEM is not enabled, we now
> > > define it as 46.  That is larger than the real number of physical
> > > address bits, and breaks calculations in zsmalloc:
> > >=20
> > >     mm/zsmalloc.c:130:49: warning: right shift count is negative [-Ws=
hift-count-negative]
> > >       MAX(32, (ZS_MAX_PAGES_PER_ZSPAGE << PAGE_SHIFT >> OBJ_INDEX_BIT=
S))
> > >                                                      ^~
> > >     ...
> > >     mm/zsmalloc.c:253:21: error: variably modified 'size_class' at fi=
le scope
> > >       struct size_class *size_class[ZS_SIZE_CLASSES];
> > >                          ^~~~~~~~~~
> > >=20
> > > Fixes: 4ffe713b7587 ("powerpc/mm: Increase the max addressable memory=
 to 2PB")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> >=20
> > Applied to powerpc fixes, thanks.
> >=20
> > https://git.kernel.org/powerpc/c/8bc086899816214fbc6047c9c7e15fca
>=20
> In file included from ./arch/powerpc/include/asm/book3s/64/mmu.h:39:0,
>                  from ./arch/powerpc/include/asm/mmu.h:360,
>                  from ./arch/powerpc/include/asm/lppaca.h:36,
>                  from ./arch/powerpc/include/asm/paca.h:21,
>                  from ./arch/powerpc/include/asm/current.h:16,
>                  from ./include/linux/thread_info.h:21,
>                  from ./include/asm-generic/preempt.h:5,
>                  from ./arch/powerpc/include/generated/asm/preempt.h:1,
>                  from ./include/linux/preempt.h:78,
>                  from ./include/linux/spinlock.h:51,
>                  from ./include/linux/mmzone.h:8,
>                  from ./include/linux/gfp.h:6,
>                  from ./include/linux/slab.h:15,
>                  from ./include/linux/crypto.h:24,
>                  from ./include/crypto/algapi.h:15,
>                  from ./include/crypto/internal/hash.h:16,
>                  from arch/powerpc/crypto/md5-glue.c:15:
> ./arch/powerpc/include/asm/book3s/64/mmu-hash.h:584:6: error: "MAX_PHYSME=
M_BITS" is not defined [-Werror=3Dundef]
>  #if (MAX_PHYSMEM_BITS > MAX_EA_BITS_PER_CONTEXT)
>       ^

Presumably you have CONFIG_PPC_BOOK3S_64 enabled and CONFIG_SPARSEMEM
disabled?  Was this configuration actually usable?

I think this would fix the build failure:

--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -341,7 +341,7 @@ static inline u16 get_mm_addr_key(struct mm_struct
*mm, unsigned long address)
 #if defined(CONFIG_SPARSEMEM_VMEMMAP) &&
defined(CONFIG_SPARSEMEM_EXTREME) &&  \
        defined (CONFIG_PPC_64K_PAGES)
 #define MAX_PHYSMEM_BITS        51
-#elif defined(CONFIG_SPARSEMEM)
+#elif defined(CONFIG_PPC64)
 #define MAX_PHYSMEM_BITS        46
 #endif
=20
--- END ---

but whether the result will actually *work*, I don't know.

Ben.

--=20
Ben Hutchings
Larkinson's Law: All laws are basically false.


--=-r1ufRG9LhmC7mNONhTXl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlyYDSsACgkQ57/I7JWG
EQmz3w/5AZIipfqoSO9mY4Ae5NqyBQIDeIHvZAPG90bnjmwnZandLZ4uGpwhMpsJ
QWCAy/T5WoP5wOLozbepYBmLuU24LS1EMJNrotAv9AnD7cftQ4iVdnNHW36VMKN5
On9cXfFCwAW++mXQ6YjPNSP9aYTDCVVr7ziR2TfzBRwerMUvI5fEu+zO6+V0gxMy
SlmzXfEDaebrlukLZx4eMSK6mzs6CT+egbGcW+n7IOpr4RPVDKHh7Q0+wni/3xa9
63LzwgK3R3fHW3RbXJqyOqM9X0WNKje+jPyMeK15Av9B01Bglmjd1UYGNLu//bKf
ioS8fBLCk5pflJXeGX1+eifc4LQIS0RQZzuFfEiPzbVIqsoHjP5+kSuUWi9a1ysh
f9aKa1VwrPmo+a28QjzCANopA7tONWK42aWJIkFANJFO0DReLz0qSzusvREZQJPU
FV2k/e7Q43GdnHsOkANH1RApFbEHJsO2sQ6rjUNiwo0UOKZMjzqMTsLaVlUJyF6F
XaphFe7gnSyvaGeTp044BfZ8y2td7DMQSylTFa+Zs4QPfAWIaNMVr0qm8SZSh4hJ
BxqDWh0/2eRcrqOD+wcUrfcUts6k85+ninidgCTDvpI35/OukzCFiqpLEVcrOoqu
BlSwwiO2sGtQguzHmGX246gtE0xo3OfL+A1/MFCyGPsyGdldZ08=
=Moxg
-----END PGP SIGNATURE-----

--=-r1ufRG9LhmC7mNONhTXl--
