Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2D2042C00C8
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Apr 2013 01:17:25 +1000 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r3AFHLVl017980
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Apr 2013 10:17:22 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Apple Message framework v1278)
Subject: Re: [RFC][PATCH 1/2] powerpc/fsl-pci: Keep PCI SoC controller
 registers in
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1363201636-7318-1-git-send-email-galak@kernel.crashing.org>
Date: Wed, 10 Apr 2013 10:17:20 -0500
Message-Id: <A807F0BC-0D83-4A42-A2A0-D7DF1ECB95A7@kernel.crashing.org>
References: <1363201636-7318-1-git-send-email-galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 13, 2013, at 2:07 PM, Kumar Gala wrote:

> Move to keeping the SoC registers that control and config the PCI
> controllers on FSL SoCs in the pci_controller struct.  This allows us =
to
> not need to ioremap() the registers in multiple different places that
> use them.
>=20
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/include/asm/pci-bridge.h |    5 ++-
> arch/powerpc/sysdev/fsl_pci.c         |   69 =
++++++++++++++-------------------
> 2 files changed, 34 insertions(+), 40 deletions(-)

applied to next

- k=
