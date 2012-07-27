Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3580A2C0098
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2012 23:24:29 +1000 (EST)
Subject: Re: [PATCH 5/6] powerpc/fsl-pci: Add pci inbound/outbound PM support
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1343125210-16720-5-git-send-email-B38951@freescale.com>
Date: Fri, 27 Jul 2012 08:24:23 -0500
Message-Id: <946C76FC-1F2E-4F09-919F-D5769D29E1A4@kernel.crashing.org>
References: <1343125210-16720-1-git-send-email-B38951@freescale.com>
 <1343125210-16720-5-git-send-email-B38951@freescale.com>
To: Jia Hongtao <B38951@freescale.com>
Cc: B07421@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 24, 2012, at 5:20 AM, Jia Hongtao wrote:

> Power supply for PCI inbound/outbound window registers is off when =
system
> go to deep-sleep state. We save the values of registers before suspend
> and restore to registers after resume.
>=20
> Signed-off-by: Jiang Yutang <b14898@freescale.com>
> Signed-off-by: Jia Hongtao <B38951@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/include/asm/pci-bridge.h |    2 +-
> arch/powerpc/sysdev/fsl_pci.c         |  121 =
+++++++++++++++++++++++++++++++++
> 2 files changed, 122 insertions(+), 1 deletions(-)

Remind me why we need to save/restore PCI ATMUs, why not just re-parse =
the device tree to restore?

- k=
