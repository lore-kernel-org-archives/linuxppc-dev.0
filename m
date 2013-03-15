Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CEA1B2C007A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Mar 2013 03:22:07 +1100 (EST)
Subject: Re: [PATCH V2] powerpc/85xx: Add platform_device declaration to
 fsl_pci.h
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1363328098-20343-1-git-send-email-hongtao.jia@freescale.com>
Date: Fri, 15 Mar 2013 11:17:41 -0500
Message-Id: <B9641F1E-AA41-4927-A590-5FD635F158D7@kernel.crashing.org>
References: <1363328098-20343-1-git-send-email-hongtao.jia@freescale.com>
To: Jia Hongtao <hongtao.jia@freescale.com>
Cc: B07421@freescale.com, linuxppc-dev@lists.ozlabs.org, b38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 15, 2013, at 1:14 AM, Jia Hongtao wrote:

> mpc85xx_pci_err_probe(struct platform_device *op) need platform_device
> declaration for definition. Otherwise, it will cause compile error if =
any
> files including fsl_pci.h without declaration of platform_device.
>=20
> Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
> ---
> Changes for V2:
> - Just declare platform_device instead of including =
<linux/platform_device.h>
>=20
> arch/powerpc/sysdev/fsl_pci.h | 2 ++
> 1 file changed, 2 insertions(+)

applied to next

- k=
