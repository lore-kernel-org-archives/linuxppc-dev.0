Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0189.outbound.messaging.microsoft.com [213.199.154.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6C9952C0040
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Mar 2013 09:30:06 +1100 (EST)
Received: from mail152-db8 (localhost [127.0.0.1])	by
 mail152-db8-R.bigfish.com (Postfix) with ESMTP id C261D4A0239	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 22:30:00 +0000 (UTC)
Received: from DB8EHSMHS012.bigfish.com (unknown [10.174.8.252])	by
 mail152-db8.bigfish.com (Postfix) with ESMTP id DC80D3A004B	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 22:29:58 +0000 (UTC)
Date: Fri, 22 Mar 2013 17:29:55 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/3] powerpc/mpic: add global timer support
To: Wang Dongsheng-B40534 <B40534@freescale.com>
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259EB857A@039-SN2MPN1-022.039d.mgd.msft.net>
 (from B40534@freescale.com on Fri Mar 22 01:14:51 2013)
Message-ID: <1363991395.24790.13@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Gala Kumar-B11780 <B11780@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/22/2013 01:14:51 AM, Wang Dongsheng-B40534 wrote:
>=20
>=20
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Thursday, March 21, 2013 7:00 AM
> > To: Wang Dongsheng-B40534
> > Cc: Wood Scott-B07421; Gala Kumar-B11780; =20
> linuxppc-dev@lists.ozlabs.org;
> > Li Yang-R58472
> > Subject: Re: [PATCH 2/3] powerpc/mpic: add global timer support
> >
> > BTW, the input clock frequency has been similarly scaled, yet you =20
> don't
> > try to scrounge up that information to get further precision...
> >
> Let's go back patch, do you think the code is repeated?
> I will remove "if (!(priv->flags & FSL_GLOBAL_TIMER))" branch, there =20
> will be no redundant code.

I'd rather that branch be kept and the more complicated branch deleted, =20
and priv->timerfreq frequency be adjusted on initialization to account =20
for the scaler.

-Scott=
