Return-Path: <r58472@freescale.com>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe004.messaging.microsoft.com
 [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4184CB6EEA
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 13:30:26 +1100 (EST)
From: Li Yang-R58472 <r58472@freescale.com>
To: Huang Changming-R66093 <r66093@freescale.com>, Tabi Timur-B04825
 <B04825@freescale.com>
Subject: RE: [PATCH] powerpc/85xx: allow CONFIG_PHYS_64BIT to be selectable
Date: Fri, 24 Feb 2012 02:29:56 +0000
Message-ID: <94F013E7935FF44C83EBE7784D62AD3F0578CD9A@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1329853995-7533-1-git-send-email-timur@freescale.com>
 <110EED8CC96DFC488B7E717A2027A27C02C5E8@039-SN1MPN1-002.039d.mgd.msft.net>
 <4F463006.7060507@freescale.com>
 <110EED8CC96DFC488B7E717A2027A27C02E4A8@039-SN1MPN1-002.039d.mgd.msft.net>
In-Reply-To: <110EED8CC96DFC488B7E717A2027A27C02E4A8@039-SN1MPN1-002.039d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Wood Scott-B07421 <B07421@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > Subject: Re: [PATCH] powerpc/85xx: allow CONFIG_PHYS_64BIT to be
> > selectable
> >
> > Huang Changming-R66093 wrote:
> > > I have one similar patch to remove the "select PHYS_64BIT".
> > > http://patchwork.ozlabs.org/patch/132351/
> >
> > That one doesn't update the defconfigs, which means that the default
> > kernel will not have PHYS_64BIT enabled.
> I think it is not necessary to enable the 64BIT, if customer want to
> enable it, he can do it manually.

I agree with Changming that we shouldn't setting PHYS_64BIT by default.  Fo=
r the platforms covered by the mpc85xx_defconfig, most user won't need the =
PHYS_64BIT.  We shouldn't set the one with worse performance and unnecessar=
y to most people as default.  Also all these platforms supports 32-bit mode=
.

- Leo
