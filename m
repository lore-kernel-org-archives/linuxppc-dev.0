Return-Path: <B35336@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E61692C007F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2012 21:39:14 +1000 (EST)
From: Zhao Chenhui-B35336 <B35336@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH v7 2/5] powerpc/85xx: add HOTPLUG_CPU support
Date: Tue, 17 Jul 2012 11:39:04 +0000
Message-ID: <7AA2FF042C086D469F577FA6723434DA071060@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1341310879-5468-1-git-send-email-chenhui.zhao@freescale.com>
 <1341310879-5468-2-git-send-email-chenhui.zhao@freescale.com>
 <0090811B-107A-4496-ADF1-DD07081BF6B9@kernel.crashing.org>
In-Reply-To: <0090811B-107A-4496-ADF1-DD07081BF6B9@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Friday, July 13, 2012 8:15 PM
> To: Zhao Chenhui-B35336
> Cc: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421; linux-kernel@vger.k=
ernel.org; Li Yang-R58472
> Subject: Re: [PATCH v7 2/5] powerpc/85xx: add HOTPLUG_CPU support
>=20
>=20
> On Jul 3, 2012, at 5:21 AM, Zhao Chenhui wrote:
>=20
> > From: Li Yang <leoli@freescale.com>
> >
> > Add support to disable and re-enable individual cores at runtime
> > on MPC85xx/QorIQ SMP machines. Currently support e500v1/e500v2 core.
> >
> > MPC85xx machines use ePAPR spin-table in boot page for CPU kick-off.
> > This patch uses the boot page from bootloader to boot core at runtime.
> > It supports 32-bit and 36-bit physical address.
> >
> > Add generic_set_cpu_up() to set cpu_state as CPU_UP_PREPARE in kick_cpu=
().
>=20
> Shouldn't the generic_setup_cpu_up() be a separate patch, and refactor sm=
p_generic_kick_cpu() to use
> it.
>=20
> Also, we should pull the conversion of the spintable from #defines to str=
uct into a separate patch
> before this one.
>=20

Ok. I will split this patch.

-Chenhui
