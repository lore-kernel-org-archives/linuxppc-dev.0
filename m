Return-Path: <r66093@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 491C2B6EEA
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 12:54:30 +1100 (EST)
From: Huang Changming-R66093 <r66093@freescale.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: RE: [PATCH] powerpc/85xx: allow CONFIG_PHYS_64BIT to be selectable
Date: Fri, 24 Feb 2012 01:54:24 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C02E4A8@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1329853995-7533-1-git-send-email-timur@freescale.com>
 <110EED8CC96DFC488B7E717A2027A27C02C5E8@039-SN1MPN1-002.039d.mgd.msft.net>
 <4F463006.7060507@freescale.com>
In-Reply-To: <4F463006.7060507@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>,
 Wood Scott-B07421 <B07421@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Tabi Timur-B04825
> Sent: Thursday, February 23, 2012 8:25 PM
> To: Huang Changming-R66093
> Cc: galak@kernel.crashing.org; benh@kernel.crashing.org; Wood Scott-
> B07421; Li Yang-R58472; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] powerpc/85xx: allow CONFIG_PHYS_64BIT to be
> selectable
>=20
> Huang Changming-R66093 wrote:
> > I have one similar patch to remove the "select PHYS_64BIT".
> > http://patchwork.ozlabs.org/patch/132351/
>=20
> That one doesn't update the defconfigs, which means that the default
> kernel will not have PHYS_64BIT enabled.
I think it is not necessary to enable the 64BIT,
if customer want to enable it, he can do it manually.=20
