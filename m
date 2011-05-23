Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 390DCB6FAC
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 May 2011 08:41:17 +1000 (EST)
Subject: Re: [PATCH][v3] powerpc/85xx: add host-pci(e) bridge only for RC
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1306146205-22772-1-git-send-email-prabhakar@freescale.com>
Date: Mon, 23 May 2011 17:41:08 -0500
Message-Id: <127FB8A0-FB0E-4066-9808-C1207C82CAA3@kernel.crashing.org>
References: <1306146205-22772-1-git-send-email-prabhakar@freescale.com>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Cc: meet2prabhu@gmail.com, linuxppc-dev@lists.ozlabs.org,
	Vivek Mahajan <vivek.mahajan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 23, 2011, at 5:23 AM, Prabhakar Kushwaha wrote:

> FSL PCIe controller can act as agent(EP) or host(RC).
> Under Agent(EP) mode they are configured via Host. So it is not =
required to add
> with the PCI(e) sub-system.
>=20
> Add and configure PCIe controller only for RC mode.
>=20
> Signed-off-by: Vivek Mahajan <vivek.mahajan@freescale.com>
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> ---
> Based upon =
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git(branc=
h master)
>=20
> Chages for v2: Incorporated Kumar's comment
> 	- Use PCI_CLASS_PROG instead of PCI_HEADER_TYPE=20
> Changes for v3:=20
> 	- updated if check condition
> 	- removed checkpatch warning
>=20
> arch/powerpc/sysdev/fsl_pci.c |   14 ++++++++++++++
> 1 files changed, 14 insertions(+), 0 deletions(-)

applied to next.

- k=
