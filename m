Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id 399516855F
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Oct 2005 23:56:44 +1000 (EST)
Date: 14 Oct 2005 13:56:41 -0000
Message-ID: <20051014135641.15104.qmail@xyzzy.farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
To: nd@bplan-gmbh.de, linuxppc-dev@ozlabs.org
In-Reply-To: <1129233624.4161.30.camel@localhost.localdomain>
Subject: Re: [PATCH 2.6.14-rc3 1/1] chrp_pegasos_eth: Added Marvell Discovery
	II SRAM support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In article <1129233624.4161.30.camel@localhost.localdomain> Nicolas DET wrote:
> Added proper entry to support the Marvell MV64361 (Marvell Discovery II)
> SRAM.

Hi Nicolas,

I noticed a couple of style issues.

> +// Pegasos II location and size for the SRAM stuff

C++ style comments are discouraged in the kernel source.

> -	static struct pci_device_id pci_marvell_mv64360[] = {
> +	static struct pci_device_id pci_marvell_mv64360[] =
> +	{

> +	if (pci_dev_present(pci_marvell_mv64360))
> +	{

Open brace should not be on a line by itself except in function definitions.


-Dale Farnsworth
