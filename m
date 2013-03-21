Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7C9B52C00BC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 20:04:11 +1100 (EST)
Subject: Re: [PATCH] powerpc: add CONFIG(s) require for using flash controller
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1363595483-7248-1-git-send-email-prabhakar@freescale.com>
Date: Thu, 21 Mar 2013 04:04:15 -0500
Message-Id: <19ADE248-F551-40F5-AF9A-79FBB6AA5B32@kernel.crashing.org>
References: <1363595483-7248-1-git-send-email-prabhakar@freescale.com>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 18, 2013, at 3:31 AM, Prabhakar Kushwaha wrote:

> Add CONFIG(s) required for NAND and NOR flash controller usage.
> It defines MTD, Jffs2 and UBIFS file system required for controllers.
>=20
> It also enables IFC controller
>=20
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> ---
> Based upon =
http://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
> branch next
>=20
> arch/powerpc/configs/corenet64_smp_defconfig |   35 =
+++++++++++++++++++++++++-
> arch/powerpc/configs/mpc85xx_defconfig       |   31 =
+++++++++++++++++++++++
> arch/powerpc/configs/mpc85xx_smp_defconfig   |   31 =
+++++++++++++++++++++++
> 3 files changed, 96 insertions(+), 1 deletion(-)

applied to next

- k=
