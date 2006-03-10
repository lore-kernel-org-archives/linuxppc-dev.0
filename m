Return-Path: <carlos.mitidieri@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id 0791F679E2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Mar 2006 22:32:51 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.sysgo.com (Postfix) with ESMTP id 8C98EFB88C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Mar 2006 12:32:49 +0100 (CET)
Received: from donald.sysgo.com (unknown [172.20.1.30])
	by mail.sysgo.com (Postfix) with ESMTP id 73287FB88C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Mar 2006 12:32:49 +0100 (CET)
Received: from cam (unknown [172.40.1.200])
	by donald.sysgo.com (Postfix) with ESMTP id CC84BF5C01
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Mar 2006 12:32:48 +0100 (CET)
From: Carlos Mitidieri <carlos.mitidieri@sysgo.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: kernel 2.6.15-rc5-latest doesn't work anymore on mpc8540ads
Date: Fri, 10 Mar 2006 12:32:39 +0100
References: <43A2E175.9050004@anagramm.de> <43A6ED1E.20506@anagramm.de>
In-Reply-To: <43A6ED1E.20506@anagramm.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200603101232.40155.carlos.mitidieri@sysgo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
The kernel actually hangs when schedule() is called in rest_init() in main.c
Would someone risk a guess ?
(keeping the walk...) Thanks,

On Monday 19 December 2005 18:25, Clemens Koller wrote:
> Hello!
>
> Here is a little update:
> > I am just about to update my kernel from 2.6.13-rc7 which is working
> > fine to linus' 2.6.15-rc5-latest git on my mpc8540ads flavored board.
> > However, the kernel hangs pretty early after
> >
> > openpic: exit
>
> openpic_init() is called by mpc85xx_ads_init_IRQ in ppc/platforms/85xx
>
> ppc_md.init_IRQ=mpc85xx_ads_init_IRQ in ppc/platforms/85xx
>
> ppc_md.init_IRQ() is called from powerpc/kernel/irq.c
>
> init_IRQ() is  called from init/main.c:start_kernel()
>
> and that seems to work fine. So, it crashes silently somewhere
> after that point. I try to build 2.6.15-rc6-latest with kgbd support,
> not knowing if it's supposed to work on this platform.
>
> Are there some open issues from the ppc->powerpc migration?
>
> Thanks,

-- 
Best regards,
Carlos Mitidieri
