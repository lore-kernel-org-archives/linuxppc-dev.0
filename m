Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 437FF67B8F
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2006 14:06:42 +1000 (EST)
Date: Wed, 12 Apr 2006 06:06:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [PATCH 1/2] Base pSeries PCIe support
Message-ID: <20060412040635.GB7870@lst.de>
References: <20060331160203.f2bf8b53.moilanen@austin.ibm.com>
	<20060331160545.db3fa210.moilanen@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060331160545.db3fa210.moilanen@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 31, 2006 at 04:05:45PM -0600, Jake Moilanen wrote:
> +source "drivers/pci/pcie/Kconfig"

does it actually work on ppc64?  last time I checked that code was
utterly x86-centric.

> -		if (node->type == NULL || strcmp(node->type, "pci") != 0)
> +
> +		if (node->type == NULL || ((strcmp(node->type, "pci") != 0) && (strcmp(node->type, "pciex") != 0)))
>  			continue;

please don't add superflous braces
