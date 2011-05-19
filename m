Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BC415B6F7B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 16:30:12 +1000 (EST)
Subject: Re: [PATCH] powerpc/85xx: Save and restore pcie ATMU windows for PM
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1303972729-32242-1-git-send-email-prabhakar@freescale.com>
Date: Thu, 19 May 2011 01:30:03 -0500
Message-Id: <3A8FAEED-7BD9-4776-85A9-560D07417BA8@kernel.crashing.org>
References: <1303972729-32242-1-git-send-email-prabhakar@freescale.com>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Cc: meet2prabhu@gmail.com, linuxppc-dev@lists.ozlabs.org,
	Jiang Yutang <b14898@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 28, 2011, at 1:38 AM, Prabhakar Kushwaha wrote:

> D3-cold state indicates removal of the clock and power. however =
auxiliary (AUX)
> Power may remain available even after the main power rails are powered =
down.
>=20
> wakeup from D3-cold state requires full context restore. Other things =
are taken
> care in pci-driver except ATMUs.
> ATMU windows needs to be saved and restored during suspend and resume.
>=20
> Signed-off-by: Jiang Yutang <b14898@freescale.com>
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> ---
> Based upon =
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git(branc=
h master)
>=20
> arch/powerpc/sysdev/fsl_pci.c |  116 =
+++++++++++++++++++++++++++++++++++++++++
> arch/powerpc/sysdev/fsl_pci.h |    7 ++-
> 2 files changed, 121 insertions(+), 2 deletions(-)

Is this patch for when we are a host or agent?

- k=
