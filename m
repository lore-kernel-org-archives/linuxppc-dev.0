Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A301CB6F14
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 05:21:39 +1000 (EST)
Subject: Re: [PATCH 1/2] tqm85xx: update PCI interrupt-map attribute
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1279744404-10171-2-git-send-email-dbaryshkov@gmail.com>
Date: Wed, 4 Aug 2010 14:21:30 -0500
Message-Id: <F92B6946-150A-432E-A9F5-2DB6C35F073F@kernel.crashing.org>
References: <1279744404-10171-1-git-send-email-dbaryshkov@gmail.com>
	<1279744404-10171-2-git-send-email-dbaryshkov@gmail.com>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 21, 2010, at 3:33 PM, Dmitry Eremin-Solenikov wrote:

> Update PCI IRQ mapping on TQM85xx platforms: include INTC and INTD on PCI-X
> slot and add INTA/INTB mapping for PCMCIA bridge.
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
> arch/powerpc/boot/dts/tqm8540.dts          |    9 ++++++++-
> arch/powerpc/boot/dts/tqm8541.dts          |    9 ++++++++-
> arch/powerpc/boot/dts/tqm8548-bigflash.dts |    9 ++++++++-
> arch/powerpc/boot/dts/tqm8548.dts          |    9 ++++++++-
> arch/powerpc/boot/dts/tqm8555.dts          |    9 ++++++++-
> arch/powerpc/boot/dts/tqm8560.dts          |    9 ++++++++-
> 6 files changed, 48 insertions(+), 6 deletions(-)

applied to next

- k
