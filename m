Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DE94BB8280
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Apr 2010 14:14:03 +1000 (EST)
Subject: Re: [PATCH] powerpc/85xx/86xx: Fix build w/ CONFIG_PCI=n
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100416190724.GA15891@oksana.dev.rtsoft.ru>
Date: Mon, 19 Apr 2010 23:13:58 -0500
Message-Id: <22DA49DA-7C57-4168-92B9-A03B9C7B4F5F@kernel.crashing.org>
References: <20100416190724.GA15891@oksana.dev.rtsoft.ru>
To: Anton Vorontsov <avorontsov@mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 16, 2010, at 2:07 PM, Anton Vorontsov wrote:

> Currently some MPC85xx and MPC86xx boards fail to build without
> CONFIG_PCI:
>=20
> arch/powerpc/platforms/fsl_uli1575.c: In function =
'quirk_final_uli5249':
> arch/powerpc/platforms/fsl_uli1575.c:234: error: implicit declaration =
of function 'pci_bus_for_each_resource'
> arch/powerpc/platforms/fsl_uli1575.c:234: error: expected ';' before =
'{' token
> cc1: warnings being treated as errors
> arch/powerpc/platforms/fsl_uli1575.c:223: warning: unused variable =
'dummy'
> make[1]: *** [arch/powerpc/platforms/fsl_uli1575.o] Error 1
>=20
> This patch fixes the issue by appending 'if PCI' condition when
> selecting FSL_ULI1575 Kconfig symbol.
>=20
> Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
> ---
> arch/powerpc/platforms/85xx/Kconfig |    4 ++--
> arch/powerpc/platforms/86xx/Kconfig |    4 ++--
> 2 files changed, 4 insertions(+), 4 deletions(-)

applied to merge.

- k=
