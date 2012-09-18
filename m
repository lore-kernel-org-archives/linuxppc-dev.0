Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AE6822C007E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2012 15:03:38 +1000 (EST)
Subject: Re: [PATCH][V4] powerpc/fsl-pci: Add pci inbound/outbound PM support
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1347934234-18223-1-git-send-email-B38951@freescale.com>
Date: Tue, 18 Sep 2012 00:03:39 -0500
Message-Id: <86ADF4ED-B84C-4560-8781-D9FA4486D854@kernel.crashing.org>
References: <1347934234-18223-1-git-send-email-B38951@freescale.com>
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


On Sep 17, 2012, at 9:10 PM, Jia Hongtao wrote:

> Power supply for PCI inbound/outbound window registers is off when =
system
> go to deep-sleep state. We save the values of registers before suspend
> and restore to registers after resume.
>=20
> Signed-off-by: Jiang Yutang <b14898@freescale.com>
> Signed-off-by: Jia Hongtao <B38951@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> Changes for V4:
> We just rebase the patch upon following patch:
> powerpc/fsl-pci: Unify pci/pcie initialization code
>=20
> arch/powerpc/include/asm/pci-bridge.h |    2 +-
> arch/powerpc/sysdev/fsl_pci.c         |  121 =
+++++++++++++++++++++++++++++++++
> 2 files changed, 122 insertions(+), 1 deletions(-)

Did you ever compare this to just re-parsing device tree method?

- k=
