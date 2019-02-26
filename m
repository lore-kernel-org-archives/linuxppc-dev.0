Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66031C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 04:26:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E30A21841
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 04:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="a/ZVkDxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E30A21841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447m373LsRzDqNj
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 15:26:11 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447m0t6ZwzzDqLK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 15:24:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="a/ZVkDxB"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 447m0t2rZzz9s5c; Tue, 26 Feb 2019 15:24:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1551155054;
 bh=oSQSEVE0aQFuitLSqJEgVtJnjg23y+VrWCIedJHPod4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=a/ZVkDxBz+O0pRJn4R0Q7ydKOouhMh6t1RKhA7laM4W55h6R+aUZMrVUPrlw/p6et
 dVnaEk/K/1YjVn5l/NT1ouYrldOR7SOTo8ynMl7rugj5vM+N4E+j0oZmd/Fj2mgrWF
 wOwykc3p16zCVj+T3X1sxweuuyt5Ziqx6B8ASMIw=
Date: Tue, 26 Feb 2019 15:21:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 01/16] powerpc/xive: add OPAL extensions for the XIVE
 native exploitation support
Message-ID: <20190226042145.GP6872@umbus.fritz.box>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-2-clg@kaod.org>
 <87y364jzlz.fsf@concordia.ellerman.id.au>
 <543ff6a2-b892-6710-d218-6aed1414840f@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7PAM/4G1BR2SfWzg"
Content-Disposition: inline
In-Reply-To: <543ff6a2-b892-6710-d218-6aed1414840f@kaod.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
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
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Stewart Smith <stewart@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--7PAM/4G1BR2SfWzg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 25, 2019 at 11:11:58AM +0100, C=E9dric Le Goater wrote:
> On 2/25/19 4:50 AM, Michael Ellerman wrote:
> > C=E9dric Le Goater <clg@kaod.org> writes:
> >=20
> >> The support for XIVE native exploitation mode in Linux/KVM needs a
> >> couple more OPAL calls to configure the sPAPR guest and to get/set the
> >> state of the XIVE internal structures.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  arch/powerpc/include/asm/opal-api.h           | 11 ++-
> >>  arch/powerpc/include/asm/opal.h               |  7 ++
> >>  arch/powerpc/include/asm/xive.h               | 14 +++
> >>  arch/powerpc/sysdev/xive/native.c             | 99 +++++++++++++++++++
> >>  .../powerpc/platforms/powernv/opal-wrappers.S |  3 +
> >>  5 files changed, 130 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/includ=
e/asm/opal-api.h
> >> index 870fb7b239ea..cdfc54f78101 100644
> >> --- a/arch/powerpc/include/asm/opal-api.h
> >> +++ b/arch/powerpc/include/asm/opal-api.h
> >> @@ -186,8 +186,8 @@
> >>  #define OPAL_XIVE_FREE_IRQ			140
> >>  #define OPAL_XIVE_SYNC				141
> >>  #define OPAL_XIVE_DUMP				142
> >> -#define OPAL_XIVE_RESERVED3			143
> >> -#define OPAL_XIVE_RESERVED4			144
> >> +#define OPAL_XIVE_GET_QUEUE_STATE		143
> >> +#define OPAL_XIVE_SET_QUEUE_STATE		144
> >>  #define OPAL_SIGNAL_SYSTEM_RESET		145
> >>  #define OPAL_NPU_INIT_CONTEXT			146
> >>  #define OPAL_NPU_DESTROY_CONTEXT		147
> >> @@ -209,8 +209,11 @@
> >>  #define OPAL_SENSOR_GROUP_ENABLE		163
> >>  #define OPAL_PCI_GET_PBCQ_TUNNEL_BAR		164
> >>  #define OPAL_PCI_SET_PBCQ_TUNNEL_BAR		165
> >> -#define	OPAL_NX_COPROC_INIT			167
> >> -#define OPAL_LAST				167
> >> +#define OPAL_HANDLE_HMI2			166
> >> +#define OPAL_NX_COPROC_INIT			167
> >> +#define OPAL_NPU_SET_RELAXED_ORDER		168
> >> +#define OPAL_NPU_GET_RELAXED_ORDER		169
> >> +#define OPAL_XIVE_GET_VP_STATE			170
> >=20
> > You should only be defining the calls you need, leaving gaps for other
> > things, and you need to retain OPAL_LAST. So it should look more like:
> >=20
> >  -#define OPAL_LAST				167
> >  +#define OPAL_XIVE_GET_VP_STATE		170
> >  +#define OPAL_LAST				170
> >=20
> >=20
> > Also I can't merge this until it's merged into skiboot.
>=20
> OK. Let's start with skiboot.

Yeah.. where are we at with skiboot in general.  We can't test this
downstream until we have a released skiboot with the necessary
support.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7PAM/4G1BR2SfWzg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx0vtkACgkQbDjKyiDZ
s5LunhAAqdW4Vz1C1Rc/2lQE84WlVsoYlWX0JuiluSHCMF3M56Xq7YbFx4+8zNrq
oVGVAhCLYvLKEvbpPFBhatrP0z81wNMFfi58dtJY8lmvcUiBiLkRe9exNMYACEGX
WouMwpP1EcvfSFFWItnTZufSF2k52UnyktDrB9ndy7TylOT/BPN0ROTrvplEBS5x
nA/J5j0Mzi3pEWJjryHfcCH2ira3PGULJ2q2k/xuvFafo4VqlqSv3nd6osAkHMXQ
PWt/tEwgysPGWs0VAITImhW+N7L5W36bIl25CluG9kIghsq/bYaMo3TR2x8gqeB4
X4L0gvAsMusuBbycEtXXf5zA7er2ArdObuBgrksPVW7XgKsAhrSCGTKY8sgTZ/y2
hAGSKYVB93kF7M+a006iaUB6/MqsHqsEnSqlb2ZoJNpSQ60x5478wXSIaYqIzYcM
0LlHjkXu7CmVWdmilLJEN7CZp0xph7brGKIZL4PTO1UST/SpnY0l88iaEBVghRL6
cZqk/Tyq9qeeT5bby9/wJr9xvcSqEVp1F2cHIKtmKnjkuprjTqINIiAkAHMoCA5n
LVaVNxS5MZbGR3rneetCquRYVuF366vpbV+8ynANy5daQnG3i5DvkHAleknvrOjJ
TjWj871EiPaWrLwJRUbHNMBnTi3suWcUFn1Ac0Ct+/iJfFfq9C8=
=rbBq
-----END PGP SIGNATURE-----

--7PAM/4G1BR2SfWzg--
