Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E3436DDF27
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 23:22:28 +1000 (EST)
Message-Id: <A6347425-265D-4376-81BE-C3C27F2C1B95@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: John Rigby <jrigby@freescale.com>
In-Reply-To: <1214500077-9254-2-git-send-email-jrigby@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH 1/2] powerpc: pci config cleanup [rev2]
Date: Tue, 15 Jul 2008 08:22:19 -0500
References: <1214500077-9254-1-git-send-email-jrigby@freescale.com>
	<1214500077-9254-2-git-send-email-jrigby@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 26, 2008, at 12:07 PM, John Rigby wrote:

> Choosing PCI or not at config time is allowed on some
> platforms via an if expression in arch/powerpc/Kconfig.
> To add a new platform with PCI support selectable at
> config time, you must change the if expression.  This
> patch makes this easier by changing:
>    bool "PCI support" if <long expression>
> to
>    bool "PCI support" if PPC_PCI_CHOICE
> and adding select PPC_PCI_CHOICE to all the config nodes that
> were previously in the PCI if expression.
>
> Platforms with unconditional PCI support continue to
> just select PCI in their config nodes.
>
> Signed-off-by: John Rigby <jrigby@freescale.com>
> ---
> arch/powerpc/Kconfig                   |   12 ++++++++----
> arch/powerpc/platforms/52xx/Kconfig    |    1 +
> arch/powerpc/platforms/83xx/Kconfig    |    1 +
> arch/powerpc/platforms/85xx/Kconfig    |    2 +-
> arch/powerpc/platforms/86xx/Kconfig    |    2 ++
> arch/powerpc/platforms/Kconfig         |    1 +
> arch/powerpc/platforms/Kconfig.cputype |    2 ++
> arch/powerpc/platforms/iseries/Kconfig |    1 +
> arch/powerpc/platforms/ps3/Kconfig     |    1 +
> arch/powerpc/platforms/pseries/Kconfig |    1 +
> 10 files changed, 19 insertions(+), 5 deletion

applied.

- k
