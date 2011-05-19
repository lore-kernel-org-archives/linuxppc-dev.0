Return-Path: <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/85xx:DTS: Fix PCIe IDSEL for Px020RDB
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1303272764-15333-1-git-send-email-prabhakar@freescale.com>
Date: Thu, 19 May 2011 01:16:28 -0500
Message-Id: <12CBD4BB-FC1B-4A44-91A2-B6E00AC251D8@kernel.crashing.org>
References: <1303272764-15333-1-git-send-email-prabhakar@freescale.com>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Cc: meet2prabhu@gmail.com, devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 19, 2011, at 11:12 PM, Prabhakar Kushwaha wrote:

> PCIe device in legacy mode can trigger interrupts using the wires =
#INTA, #INTB
> ,#INTC and #INTD. PCI devices are obligated to use #INTx for =
interrupts under
> legacy mode.  Each PCI slot or device is typically wired to different =
inputs on
> the interrupt controller.=20
>=20
> So, Define interrupt-map and interrupt-map-mask properties for device =
tree to
> of map each PCI interrupt signal to the inputs of the interrupt =
controller.
>=20
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> ---
> Based upon =
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git(branc=
h master)
>=20
> This patch has depedency on following 2 patches
> 	-- powerpc/85xx: P2020 DTS: re-organize dts files
> 	-- powerpc/85xx: P1020 DTS : re-organize dts files
>=20
> arch/powerpc/boot/dts/p1020rdb.dts            |   16 ++++++++++++++++
> arch/powerpc/boot/dts/p2020rdb.dts            |   16 ++++++++++++++++
> arch/powerpc/boot/dts/p2020rdb_camp_core0.dts |    8 ++++++++
> arch/powerpc/boot/dts/p2020rdb_camp_core1.dts |    8 ++++++++
> 4 files changed, 48 insertions(+), 0 deletions(-)

applied to next

- k=
