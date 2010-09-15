Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (mail.lixom.net [70.86.134.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6AACFB6EEB
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 04:29:16 +1000 (EST)
Date: Wed, 15 Sep 2010 13:29:14 -0500
From: Olof Johansson <olof@lixom.net>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: [PATCH 10/15] ppc/pasemi: clean up pasemi iommu table
	initializations
Message-ID: <20100915182914.GA6068@lixom.net>
References: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
	<1284573958-8397-11-git-send-email-nacc@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1284573958-8397-11-git-send-email-nacc@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Milton Miller <miltonm@bga.com>,
	Paul Mackerras <paulus@samba.org>, Yinghai Lu <yinghai@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 15, 2010 at 11:05:53AM -0700, Nishanth Aravamudan wrote:
> No need for empty helpers with iommu off, the ppc_md hooks are optional.

Not any more, they used to be needed. :-)

> The direct_dma_ops are the default pci_dma_ops, so no need to set in the
> them iommu off case.
> 
> No need to set the device tree device_node pci node iommu pointer, its
> only used for dlpar remove.
> 
> Signed-off-by: Milton Miller <miltonm@bga.com>
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
