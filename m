Return-Path: <B11780@freescale.com>
Subject: Re: [PATCH][v2] powerpc/85xx: P1020 DTS : re-organize dts files
MIME-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1302167455-21538-1-git-send-email-prabhakar@freescale.com>
Date: Thu, 19 May 2011 01:16:16 -0500
Message-ID: <432676EA-9461-4B8D-9215-C7EF32366A8C@freescale.com>
References: <1302167455-21538-1-git-send-email-prabhakar@freescale.com>
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


On Apr 7, 2011, at 4:10 AM, Prabhakar Kushwaha wrote:

> Creates P1020si.dtsi, containing information for the P1020 SoC. =
Modifies dts
> files for P1020 based systems to use dtsi file
>=20
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> Acked-by: Kumar Gala <kumar.gala@freescale.com>
> ---
> Based upon =
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git(branc=
h master)
>=20
> Please see mpc5200b.dtsi for reference.
>=20
> Tested on P1020RDB
>=20
> Changes for v2: Incorporated Grant Likely's comment
> 	-updated model name
>=20
> arch/powerpc/boot/dts/p1020rdb.dts |  316 =
+------------------------------
> arch/powerpc/boot/dts/p1020si.dtsi |  377 =
++++++++++++++++++++++++++++++++++++
> 2 files changed, 380 insertions(+), 313 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/p1020si.dtsi

applied to next

- k=
