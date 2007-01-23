Return-Path: <benjamin.zores@alcatel-lucent.fr>
Received: from smail4.alcatel.fr (smail4.alcatel.fr [62.23.212.167])
	by ozlabs.org (Postfix) with ESMTP id CCD05DDEC3
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Jan 2007 19:22:29 +1100 (EST)
Received: from bsf.alcatel.fr (mail205.sxb.bsf.alcatel.fr [155.132.205.115])
	by smail4.alcatel.fr (ALCANET/NETFR) with ESMTP id l0N8MD0f009880
	for <linuxppc-embedded@ozlabs.org>; Tue, 23 Jan 2007 09:22:14 +0100
Received: from mail (mail-bsf-alcatel-fr.sxb.bsf.alcatel.fr [155.132.205.91])
	by bsf.alcatel.fr (8.8.8p2+Sun/8.9.3) with ESMTP id JAA19612
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Jan 2007 09:22:13 +0100 (MET)
Received: from frilld0063506 (frilld0063506 [172.25.48.83])
	by mail (8.8.8p2+Sun/) with SMTP id JAA19608
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Jan 2007 09:22:13 +0100 (MET)
Date: Tue, 23 Jan 2007 09:18:02 +0100
From: Benjamin Zores <benjamin.zores@alcatel-lucent.fr>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [MPC8349ITX] USB Init with PPC arch
Message-Id: <20070123091802.95605193.benjamin.zores@alcatel-lucent.fr>
In-Reply-To: <3B008FD0-DF55-492B-A60A-EF0F9F8F75AB@kernel.crashing.org>
References: <20070122181027.89187533.benjamin.zores@alcatel-lucent.fr>
	<3B008FD0-DF55-492B-A60A-EF0F9F8F75AB@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 22 Jan 2007 16:19:06 -0600
Kumar Gala <galak@kernel.crashing.org> wrote:

> What are these features?

External RT patch that only supports PPC arch atm.
Also I've encountered some stability issues with PowerPC branch
(card hangs after some time for undetermined reason).

> If you are forward porting the Freescale patches and not using the in  
> kernel driver that would explain the issue.  There are bugs in the  
> Freescale driver that have been fixed in the driver that is in the  
> kernel.

I only ported what needs to be i.e. the platform initialization part.
I'm using the regular USB drivers (EHCI-FSL) from vanilla 2.6.19, this part
hasn't be ported from old 2.6.13 BSP code (which would have been useless).

The goal of the patch i've sent early is to init the USB bus the same way
it is done by OF device tree in arch/powerpc/sysdev/fsl_soc.c (but for PPC).

Does it sounds ok to you ?

Regards,

Ben
