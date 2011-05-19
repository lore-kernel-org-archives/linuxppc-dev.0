Return-Path: <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/85xx: P2020 DTS: re-organize dts files
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1302265625-10131-1-git-send-email-prabhakar@freescale.com>
Date: Thu, 19 May 2011 01:16:22 -0500
Message-Id: <FF5F027D-35D2-4645-8D0E-DFF500AF8149@kernel.crashing.org>
References: <1302265625-10131-1-git-send-email-prabhakar@freescale.com>
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


On Apr 8, 2011, at 7:27 AM, Prabhakar Kushwaha wrote:

> Creates P2020si.dtsi, containing information for P2020 SoC. Modifies =
dts files
> for P2020 based systems to use dtsi file.
>=20
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> ---
> Based upon =
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git(branc=
h master)
>=20
> Please see mpc5200b.dtsi for reference.
>=20
> Tested on P2020RDB and P2020DS
>=20
> arch/powerpc/boot/dts/p2020ds.dts             |  374 =
++----------------------
> arch/powerpc/boot/dts/p2020rdb.dts            |  362 =
++---------------------
> arch/powerpc/boot/dts/p2020rdb_camp_core0.dts |  237 +++-------------
> arch/powerpc/boot/dts/p2020rdb_camp_core1.dts |  142 ++++++----
> arch/powerpc/boot/dts/p2020si.dtsi            |  382 =
+++++++++++++++++++++++++
> 5 files changed, 564 insertions(+), 933 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/p2020si.dtsi

applied to next

- k=
