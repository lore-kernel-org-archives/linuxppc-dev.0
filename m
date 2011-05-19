Return-Path: <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/85xx:Create dts of each core in CAMP mode for
	P1020RDB
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1303974000-2943-1-git-send-email-prabhakar@freescale.com>
Date: Thu, 19 May 2011 01:33:06 -0500
Message-Id: <C0FC0AB9-E31C-4976-991E-80D3DBA40BDF@kernel.crashing.org>
References: <1303974000-2943-1-git-send-email-prabhakar@freescale.com>
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


On Apr 28, 2011, at 2:00 AM, Prabhakar Kushwaha wrote:

> Create the dts files for each core and splits the devices between the =
two cores
> for P1020RDB.
>=20
> Core0 has core0 to have memory, l2, i2c, spi, gpio, tdm, dma, usb, =
eth1, eth2,
> sdhc, crypto, global-util, message, pci0, pci1, msi.
> Core1 has l2, eth0, crypto.
>=20
> MPIC is shared between two cores but each core will protect its =
interrupts from
> other core by using "protected-sources" of mpic.
>=20
> Fix compatible property for global-util node of P1020si.dtsi.
>=20
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> ---
> Based upon =
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git(branc=
h master)
>=20
> This patch depends on following patch
> 	"powerpc/85xx: P1020 DTS : re-organize dts files"
>=20
> arch/powerpc/boot/dts/p1020rdb_camp_core0.dts |  213 =
+++++++++++++++++++++++++
> arch/powerpc/boot/dts/p1020rdb_camp_core1.dts |  148 +++++++++++++++++
> arch/powerpc/boot/dts/p1020si.dtsi            |    2 +-
> 3 files changed, 362 insertions(+), 1 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/p1020rdb_camp_core0.dts
> create mode 100644 arch/powerpc/boot/dts/p1020rdb_camp_core1.dts

applied to next

- k=
