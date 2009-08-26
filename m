Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6D2F1B7257
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 Aug 2009 23:29:23 +1000 (EST)
Message-Id: <E575F71A-166A-4933-8612-1F0E88A426C5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20090826060716.30936.40578.stgit@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH V2 3/3] powerpc/pci: Merge ppc32 and ppc64 versions of
	phb_scan()
Date: Wed, 26 Aug 2009 08:29:08 -0500
References: <20090826060659.30936.75706.stgit@localhost.localdomain>
	<20090826060716.30936.40578.stgit@localhost.localdomain>
Cc: linuxppc-dev@lists.ozlabs.org, sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 26, 2009, at 1:07 AM, Grant Likely wrote:

> +/**
> + * pci_scan_phb - Given a pci_controller, setup and scan the PCI bus
> + * @hose: Pointer to the PCI host controller instance structure
> + * @data: value to use for sysdata pointer.  ppc32 and ppc64 differ  
> here
> + *
> + * Note: the 'data' pointer is a temporary measure.  As 32 and 64 bit
> + * pci code gets merged, this parameter should become unnecessary  
> because
> + * both will use the same value.
> + */
> +void __devinit pcibios_scan_phb(struct pci_controller *hose, void  
> *data)
> +{
> +

Just a nit, but why not data -> sysdata since that's what we using it  
as.

- k
