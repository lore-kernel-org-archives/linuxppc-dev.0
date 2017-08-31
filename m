Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjgLk64JxzDqTs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 21:36:30 +1000 (AEST)
In-Reply-To: <1504012311-37079-1-git-send-email-bryantly@linux.vnet.ibm.com>
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
 sam.bobroff@au1.ibm.com
Subject: Re: powerpc/kernel: Change retrieval of pci_dn
Message-Id: <3xjgLk30hVz9t2M@ozlabs.org>
Date: Thu, 31 Aug 2017 21:36:29 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-08-29 at 13:11:51 UTC, "Bryant G. Ly" wrote:
> For a PCI device it's pci_dn can be retrieved from
> pdev->dev.archdata.firmware_data, PCI_DN(devnode), or parent's list.
> Thus, we should just use the existing function pci_get_pdn_by_devfn
> to get the pci_dn.
> 
> Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
> Reviewed-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f9df74dfce542ad2aea2e601ef1a12

cheers
