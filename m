Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BDD0CB6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 31 Mar 2011 19:23:07 +1100 (EST)
Subject: Re: [PATCH] powerpc/dts:Update PCIe memory maps to match u-boot of
	Px020RDB
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1301028465-3897-1-git-send-email-prabhakar@freescale.com>
Date: Thu, 31 Mar 2011 03:22:57 -0500
Message-Id: <38B7F1DC-21FC-4723-AF41-E66E04DF0B1F@kernel.crashing.org>
References: <1301028465-3897-1-git-send-email-prabhakar@freescale.com>
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


On Mar 24, 2011, at 11:47 PM, Prabhakar Kushwaha wrote:

> PCIe memory address space is 1:1 mapped with u-boot.
>=20
> Update dts of Px020RDB i.e. P1020RDB and P2020RDB to match the address =
map
> changes in u-boot.
>=20
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> Acked-by: Kumar Gala <kumar.gala@freescale.com>
> ---
> Based upon =
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git =
(Branch master)
>=20
> arch/powerpc/boot/dts/p1020rdb.dts            |   12 ++++++------
> arch/powerpc/boot/dts/p2020rdb.dts            |   12 ++++++------
> arch/powerpc/boot/dts/p2020rdb_camp_core0.dts |    4 ++--
> arch/powerpc/boot/dts/p2020rdb_camp_core1.dts |   10 +++++-----
> 4 files changed, 19 insertions(+), 19 deletions(-)

applied to 'merge'

- k=
