Return-Path: <scottwood@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 396AC2C00A9
 for <linuxppc-dev@ozlabs.org>; Thu, 14 Nov 2013 06:41:23 +1100 (EST)
Received: from mail4-co1 (localhost [127.0.0.1])	by mail4-co1-R.bigfish.com
 (Postfix) with ESMTP id 53C41E05FE	for <linuxppc-dev@ozlabs.org>; Wed, 13 Nov
 2013 19:41:20 +0000 (UTC)
Received: from CO1EHSMHS012.bigfish.com (unknown [10.243.78.251])	by
 mail4-co1.bigfish.com (Postfix) with ESMTP id D1E0344009D	for
 <linuxppc-dev@ozlabs.org>; Wed, 13 Nov 2013 19:41:17 +0000 (UTC)
Message-ID: <1384371674.1403.164.camel@snotra.buserror.net>
Subject: Re: [PATCH V2] powerpc/85xx: Merge 85xx/p1023_defconfig into
 mpc85xx_smp_defconfig and mpc85xx_defconfig
From: Scott Wood <scottwood@freescale.com>
To: Emil Medve <Emilian.Medve@freescale.com>
Date: Wed, 13 Nov 2013 13:41:14 -0600
In-Reply-To: <5283C51F.9090708@Freescale.com>
References: <1383952632-5770-1-git-send-email-Lijun.Pan@freescale.com>
 <1384197913-24610-1-git-send-email-Lijun.Pan@freescale.com>
 <1384293891.1403.70.camel__45039.5534084693$1384293935$gmane$org@snotra.buserror.net>
 <5282B277.4090300@Freescale.com>
 <1384307175.1403.118.camel__32063.4016803981$1384307228$gmane$org@snotra.buserror.net>
 <5282E52B.2040306@Freescale.com>
 <1384366750.1403.154.camel@snotra.buserror.net>
 <5283C51F.9090708@Freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-11-13 at 12:29 -0600, Emil Medve wrote:
> Somebody gratuitously added a P1023 defconfig more then two years ago
> with the notion that P1023 is special due to its datapath and we're
> still one year out before we'll have the (P1023) datapath driver
> upstream.  As of now this defconfig is just bit-rotting in the tree
> creating confusion. Let's just remove it for now and we'll deal with the
> entire e500v2_dpaa business when the datapath support will be upstreamed

Sure.

-Scott
