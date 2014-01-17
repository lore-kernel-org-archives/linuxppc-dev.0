Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C20A42C0098
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jan 2014 04:02:14 +1100 (EST)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH] powerpc/configs: Enbale Freescale IFC controller
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1389938981-30858-1-git-send-email-prabhakar@freescale.com>
Date: Fri, 17 Jan 2014 11:02:07 -0600
Message-Id: <B2E40837-4025-4975-8DAC-BB47E2B07E1A@kernel.crashing.org>
References: <1389938981-30858-1-git-send-email-prabhakar@freescale.com>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 17, 2014, at 12:09 AM, Prabhakar Kushwaha =
<prabhakar@freescale.com> wrote:

> Currently IFC NAND driver is enabled in corenet32smp_defconfig. But =
IFC
> controller is not enabled
>=20
> So, Enable IFC controller in corenet32smp_defconfig.
>=20
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> ---
> Based upon =
git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git
> branch master
>=20
> arch/powerpc/configs/corenet32_smp_defconfig |    1 +
> 1 file changed, 1 insertion(+)

Shouldn=92t the NAND driver get the IFC controller enabled by Kconfig =
dependancies?

- k=
