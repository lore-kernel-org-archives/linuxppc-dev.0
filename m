Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQZ793VVXzDqW7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 14:47:33 +1100 (AEDT)
Message-ID: <1458186445.19333.3.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: luigi burdo <intermediadc@hotmail.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "matthew@a-eon.com" <matthew@a-eon.com>, Trevor Dickinson
 <contact@a-eon.com>, Christian Zigotzky <chzigotzky@xenosoft.de>
Date: Wed, 16 Mar 2016 22:47:25 -0500
In-Reply-To: <DUB406-EAS2759FE0784777D029FB586BC88A0@phx.gbl>
References: <DUB117-W18044BE969CC05E69F545CC8BA0@phx.gbl>
 <1457482205.5360.114.camel@buserror.net>
 <DUB117-W1369999A718E6C0B33E4DC8C8B30@phx.gbl>
 <DUB117-W6931726DAC4EB1D528591DC8B40@phx.gbl>
 <1458081467.12370.31.camel@buserror.net>
 <DUB406-EAS2759FE0784777D029FB586BC88A0@phx.gbl>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: Freescale P5020 cpu will be kvm-pr?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-03-16 at 07:24 +0100, luigi burdo wrote:
> hi Scott,
> the P5020 mmu is signed by the kernel no book3e found 

I don't understand this sentence.

> kvm ppc64 crash if run by qemu.

You didn't show that log.

> in the kernel( 4.5 too)all is enabled we had a base .config by freescale/nix
> where kvm options and book3e  where enabled.

You should start with corenet64_smp_defconfig, and enable KVM options plus
PPC_QEMU_E500.

> my suspect is this can be an generated issue by  the host uboot

Host U-Boot has nothing to do with KVM.

>  or a missed tdb parameter and not a linux kernel problem.

What is tdb?

-Scott
