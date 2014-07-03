Return-Path: <mihai.caraman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0190.outbound.protection.outlook.com [207.46.163.190])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AF6851A0003
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jul 2014 01:58:27 +1000 (EST)
From: "mihai.caraman@freescale.com" <mihai.caraman@freescale.com>
To: Alexander Graf <agraf@suse.de>, "kvm-ppc@vger.kernel.org"
 <kvm-ppc@vger.kernel.org>
Subject: RE: [PATCH 4/6 v2] KVM: PPC: Book3E: Add AltiVec support
Date: Thu, 3 Jul 2014 15:58:18 +0000
Message-ID: <087e629a1c51420f9828831ca6efbdf7@BY2PR03MB508.namprd03.prod.outlook.com>
References: <1404142497-6430-1-git-send-email-mihai.caraman@freescale.com>
 <1404142497-6430-5-git-send-email-mihai.caraman@freescale.com>
 <53B54D44.2010007@suse.de>
In-Reply-To: <53B54D44.2010007@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Alexander Graf [mailto:agraf@suse.de]
> Sent: Thursday, July 03, 2014 3:32 PM
> To: Caraman Mihai Claudiu-B02008; kvm-ppc@vger.kernel.org
> Cc: kvm@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH 4/6 v2] KVM: PPC: Book3E: Add AltiVec support
>=20
>=20
> On 30.06.14 17:34, Mihai Caraman wrote:
> > Add KVM Book3E AltiVec support. KVM Book3E FPU support gracefully reuse
> host
> > infrastructure so follow the same approach for AltiVec.
> >
> > Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
>=20
> Same comment here - I fail to see how we refetch Altivec state after a
> context switch.

See previous comment. I also run my usual Altivec stress test consisting in
a guest and host process running affine to a physical core an competing for
the same unit's resources using different data sets.

-Mike
