Return-Path: <B40534@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9239B2C0139
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 20:10:26 +1000 (EST)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: "galak@kernel.crashing.org" <galak@kernel.crashing.org>
Subject: RE: [PATCH v3 1/4] powerpc/mpic: add irq_set_wake support
Date: Tue, 23 Apr 2013 10:10:19 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259EF9A8C@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1365474152-21524-1-git-send-email-dongsheng.wang@freescale.com>
 <ABB05CD9C9F68C46A5CEDC7F15439259EE77D8@039-SN2MPN1-021.039d.mgd.msft.net>
 <1366155021.23030.24@snotra>
In-Reply-To: <1366155021.23030.24@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kumar,

Could you apply these patches?

Thanks.

[v3,1/4] powerpc/mpic: add irq_set_wake support
http://patchwork.ozlabs.org/patch/234934/

[v3,2/4] powerpc/mpic: add global timer support
http://patchwork.ozlabs.org/patch/234935/

[v3,3/4] powerpc/mpic: create mpic subsystem object
http://patchwork.ozlabs.org/patch/234936/

[v3,4/4] powerpc/fsl: add MPIC timer wakeup support
http://patchwork.ozlabs.org/patch/234937/


> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Wednesday, April 17, 2013 7:30 AM
> To: Wang Dongsheng-B40534
> Cc: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org;
> galak@kernel.crashing.org
> Subject: Re: [PATCH v3 1/4] powerpc/mpic: add irq_set_wake support
>=20
> ACK
>=20
> -Scott
>=20
> On 04/16/2013 05:58:52 AM, Wang Dongsheng-B40534 wrote:
> > Hi scott,
> >
> > Could you ACK these patches?
> >
> > [PATCH v3 2/4] powerpc/mpic: add global timer support
> > [PATCH v3 3/4] powerpc/mpic: create mpic subsystem object
> > [PATCH v3 4/4] powerpc/fsl: add MPIC timer wakeup support
> >
> > Thanks.
> >
