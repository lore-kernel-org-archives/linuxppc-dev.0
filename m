Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 086F9DE0FE
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 23:06:58 +1000 (EST)
Message-Id: <CD570B49-998F-4D51-8AF8-CF6C9800CD62@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jason Jin <Jason.jin@freescale.com>
In-Reply-To: <1211531568-31402-2-git-send-email-Jason.jin@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 2/4 V6] MSI support on 83xx/85xx/86xx board
Date: Fri, 23 May 2008 08:06:50 -0500
References: <1211531568-31402-1-git-send-email-Jason.jin@freescale.com>
	<1211531568-31402-2-git-send-email-Jason.jin@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 23, 2008, at 3:32 AM, Jason Jin wrote:

> This MSI driver can be used on 83xx/85xx/86xx board.
> In this driver, virtual interrupt host and chip were
> setup. There are 256 MSI interrupts in this host, Every 32
> MSI interrupts cascaded to one IPIC/MPIC interrupt.
> The chip was treated as edge sensitive and some necessary
> functions were setup for this chip.
>
> Before using the MSI interrupt, PCI/PCIE device need to
> ask for a MSI interrupt in the 256 MSI interrupts. A 256bit
> bitmap show which MSI interrupt was used, reserve bit in
> the bitmap can be used to force the device use some designate
> MSI interrupt in the 256 MSI interrupts. Sometimes this is useful
> for testing the all the MSI interrupts. The msi-available-ranges
> property in the dts file was used for this purpose.
>
> Signed-off-by: Jason Jin <Jason.jin@freescale.com>

applied.

- k
