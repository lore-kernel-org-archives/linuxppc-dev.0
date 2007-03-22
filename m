Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2A1F8DDF3F
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 15:59:21 +1100 (EST)
Date: Wed, 21 Mar 2007 23:55:54 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH 2/2 Rev 2] Add initial MPC8544DS platform files.
In-Reply-To: <1174407550.6595.419.camel@ld0161-tx32>
Message-ID: <Pine.LNX.4.64.0703212355410.1023@localhost.localdomain>
References: <1174407550.6595.419.camel@ld0161-tx32>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 20 Mar 2007, Jon Loeliger wrote:

>
> This patch provides the basic 8544 platform code and config.
> Follow-up patches will add peripherals such as PCI and SATA.
>
> Signed-off-by: Xianghua Xiao <x.xiao@freescale.com>
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> Signed-off-by: York Sun <yorksun@freescale.com>
> Signed-off-by: Andy Fleming <afleming@freescale.com>
> Signed-off-by: Jon Loeliger <jdl@freescale.com>
> ---
>  arch/powerpc/boot/dts/mpc8544ds.dts      |  136 ++++++++++++++++++++++++++++
>  arch/powerpc/platforms/85xx/Kconfig      |    9 ++-
>  arch/powerpc/platforms/85xx/Makefile     |    1 +
>  arch/powerpc/platforms/85xx/mpc8544_ds.c |  144 ++++++++++++++++++++++++++++++
>  4 files changed, 289 insertions(+), 1 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/mpc8544ds.dts
>  create mode 100644 arch/powerpc/platforms/85xx/mpc8544_ds.c
>

applied.

- k
