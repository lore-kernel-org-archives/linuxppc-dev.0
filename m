Return-Path: <mihai.caraman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0144.outbound.protection.outlook.com [207.46.163.144])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 23EA41A0003
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jul 2014 02:11:35 +1000 (EST)
From: "mihai.caraman@freescale.com" <mihai.caraman@freescale.com>
To: Alexander Graf <agraf@suse.de>, "kvm-ppc@vger.kernel.org"
 <kvm-ppc@vger.kernel.org>
Subject: RE: [PATCH 5/6 v2] KVM: PPC: Book3E: Add ONE_REG AltiVec support
Date: Thu, 3 Jul 2014 16:11:20 +0000
Message-ID: <92e31868b99a421ab578640527b41ccf@BY2PR03MB508.namprd03.prod.outlook.com>
References: <1404142497-6430-1-git-send-email-mihai.caraman@freescale.com>
 <1404142497-6430-6-git-send-email-mihai.caraman@freescale.com>
 <53B54DB2.1000805@suse.de>
In-Reply-To: <53B54DB2.1000805@suse.de>
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
> Sent: Thursday, July 03, 2014 3:34 PM
> To: Caraman Mihai Claudiu-B02008; kvm-ppc@vger.kernel.org
> Cc: kvm@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH 5/6 v2] KVM: PPC: Book3E: Add ONE_REG AltiVec support
>=20
>=20
> On 30.06.14 17:34, Mihai Caraman wrote:
> > Add ONE_REG support for AltiVec on Book3E.
> >
> > Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
>=20
> Any chance we can handle these in generic code?

I expected this request :) Can we let this for a second phase to have
e6500 enabled first?

Can you share with us a Book3S setup so I can validate the requested
changes? I already fell anxious touching strange hardware specific
Book3S code without running it.

-Mike
