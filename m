Return-Path: <mihai.caraman@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0242.outbound.protection.outlook.com [207.46.163.242])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 27DE81A000C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 20:07:03 +1000 (EST)
From: "mihai.caraman@freescale.com" <mihai.caraman@freescale.com>
To: Alexander Graf <agraf@suse.de>
Subject: RE: [PATCH v5 4/5] KVM: PPC: Alow kvmppc_get_last_inst() to fail
Date: Wed, 23 Jul 2014 10:06:56 +0000
Message-ID: <29a7a8c7ac1542a08ada4a35675bf7dc@BY2PR03MB508.namprd03.prod.outlook.com>
References: <1405596148-1507-1-git-send-email-mihai.caraman@freescale.com>
 <1405596148-1507-5-git-send-email-mihai.caraman@freescale.com>
 <53C7DBC3.2060104@suse.de>
 <9905fb7c7f604bcb966478e3722e8bfc@BY2PR03MB508.namprd03.prod.outlook.com>
 <32d95c415b3f4a69bebd5a208c498e15@BY2PR03MB508.namprd03.prod.outlook.com>
 <53CED5D9.9010609@suse.de>
 <72a612351ec34db5a94cda4f4883e608@BY2PR03MB508.namprd03.prod.outlook.com>
 <4803B12E-A3CF-43C4-AF98-2AD87F76D151@suse.de>
In-Reply-To: <4803B12E-A3CF-43C4-AF98-2AD87F76D151@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > Right. With this do you acknowledge that v5 (definitely overwritten
> approach)
> > is ok?
>=20
> I think I'm starting to understand your logic of v5. You write
> fetch_failed into *inst unswapped if the fetch failed.

"v5
  - don't swap when load fails" :)

>=20
> I think that's ok, but I definitely do not like the code flow - it's too
> hard to understand at a glimpse. Just rewrite it to swab at local
> variable level, preferably with if()s and comments what this is about and
> have a single unconditional *inst =3D fetched_inst; at the end of the
> function.

I will incorporate these change requests into v6.

Thanks,
-Mike
