Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (dns-bn1lp0143.outbound.protection.outlook.com [207.46.163.143])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F0CA71A0186
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Aug 2014 09:03:10 +1000 (EST)
Message-ID: <1407970977.7427.197.camel@snotra.buserror.net>
Subject: Re: MPC8641D SMP "Processor 1 is stuck"
From: Scott Wood <scottwood@freescale.com>
To: Chris Enrique <microdevel@googlemail.com>
Date: Wed, 13 Aug 2014 18:02:57 -0500
In-Reply-To: <CAOB9jCKmpuSSAea_DVHPNEYXOuLL3xUJ=JrMrxVO=uhrajY1Fg@mail.gmail.com>
References: <CAOB9jCKmpuSSAea_DVHPNEYXOuLL3xUJ=JrMrxVO=uhrajY1Fg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-08-12 at 16:29 +0200, Chris Enrique wrote:
> Hello,
> 
> i am currently working on a GE PPC9A board which has a MPC8641D
> processor.
> 
> 
> My work on this board is currently based on the yocto project (where i
> also put this issue on the mailinglist) but the issue affects mainly
> the kernel's SMP feature so i want to share this issue here as well
> and see if anybody can help:
> 
> 
> 
> i created a BSP for this board and yocto generates a fully working
> 3.14 kernel and rootfs as well as devicetree.
> 
> the only thing which is causing problems is SMP. i included the
> following kernel options:
> 
> CONFIG_SMP=y
> CONFIG_SCHED_SMT=y
> CONFIG_NR_CPUS=64
> 
> 
> Unfortunately, only one CPU is brought up during boot:

Which U-Boot version are you using?

If experimenting with U-Boot versions doesn't help, you could try
instrumenting the spin table code, and/or using JTAG to see what the
second core is up to.

-Scott
