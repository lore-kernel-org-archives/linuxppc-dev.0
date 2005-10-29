Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17251.265.196352.234376@cargo.ozlabs.ibm.com>
Date: Sat, 29 Oct 2005 14:56:41 +1000
From: Paul Mackerras <paulus@samba.org>
To: Sven Luther <sl@bplan-gmbh.de>
In-Reply-To: <20051025075159.GA10316@localhost.localdomain>
References: <20051025075159.GA10316@localhost.localdomain>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2.6.14-rc5 1/1] : mv643xx_eth_pcidev - implements hotplug
	for the marvell gige functionality by probing the northbridge
	pci id.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sven Luther writes:

> +static struct pci_device_id pci_marvell_mv64360[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, PCI_DEVICE_ID_MARVELL_MV64360) },

Are there other devices in this northbridge whose drivers might also
want to bind to this PCI id?

What other devices does this northbridge contain?

Paul.
