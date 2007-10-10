Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C0F41DDEF8
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 00:31:34 +1000 (EST)
Date: Wed, 10 Oct 2007 09:31:23 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH] drivers/ata: add support to Freescale 3.0Gbps SATA
	Controller
In-Reply-To: <1192011083-20220-1-git-send-email-leoli@freescale.com>
Message-ID: <Pine.LNX.4.64.0710100927120.865@gate.crashing.org>
References: <1192011083-20220-1-git-send-email-leoli@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com,
	Ashish Kalra <ashish.kalra@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Wed, 10 Oct 2007, Li Yang wrote:

> From: Ashish Kalra <ashish.kalra@freescale.com>
>
> This patch adds support for Freescale 3.0Gbps SATA Controller supporting
> Native Command Queueing(NCQ), device hotplug, and ATAPI.  This controller
> can be found on MPC8315 and MPC8378.
>
> Signed-off-by: Ashish Kalra <ashish.kalra@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
>  drivers/ata/Kconfig    |    9 +
>  drivers/ata/Makefile   |    1 +
>  drivers/ata/sata_fsl.c | 1505 ++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/ata/sata_fsl.h |  104 ++++
>  4 files changed, 1619 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/ata/sata_fsl.c
>  create mode 100644 drivers/ata/sata_fsl.h

This patch shouldn't be accepted until we close on the device tree
definition since it impacts the driver.

Also CONFIG_SATA_FSL_FPGA_PCI should be removed since that was just an
internal debug thing.

- k
