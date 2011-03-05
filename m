Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3479FB6F0B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  6 Mar 2011 08:29:59 +1100 (EST)
Subject: Re: [PATCH] fsl_pci: Add support for FSL PCIe controllers v2.x
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1298540104-16545-1-git-send-email-prabhakar@freescale.com>
Date: Sat, 5 Mar 2011 15:29:47 -0600
Message-Id: <400355E2-134B-48CF-9CE0-67526252A0EE@kernel.crashing.org>
References: <1298540104-16545-1-git-send-email-prabhakar@freescale.com>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Cc: meet2prabhu@gmail.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 24, 2011, at 3:35 AM, Prabhakar Kushwaha wrote:

> FSL PCIe controller v2.1:
>     - New MSI inbound window
>     - Same Inbound windows address as PCIe controller v1.x
>=20
> Added new pit_t member(pmit) to struct ccsr_pci for MSI inbound window
>=20
> FSL PCIe controller v2.2 and v2.3:
>     - Different addresses for PCIe inbound window 3,2,1
>     - Exposed PCIe inbound window 0
>     - New PCIe interrupt status register
>=20
> Added new config and interrupt Status register to struct ccsr_pci & =
updated
> pit_t array size to reflect the 4 inbound windows.
>=20
> Device tree is used to maintain backward compatibility i.e. update =
inbound
> window 1 index depending upon "compatible" field witin PCIE node.
>=20
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> Acked-by: Roy Zang <tie-fei.zang@freescale.com>
> Acked-by: Kumar Gala <kumar.gala@freescale.com>
> ---
>=20
> Based upon =
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git =
(branch master )
>=20
> arch/powerpc/sysdev/fsl_pci.c |   15 +++++++++++----
> arch/powerpc/sysdev/fsl_pci.h |   17 ++++++++++-------
> 2 files changed, 21 insertions(+), 11 deletions(-)

applied to next

- k=
