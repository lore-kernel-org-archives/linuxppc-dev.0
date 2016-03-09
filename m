Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0511F1A004B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 23:51:37 +1100 (AEDT)
In-Reply-To: <1457049194-9281-2-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [v15,01/12] PCI/IOV: Rename and export virtfn_{add, remove}
Message-Id: <20160309125136.DBA6114032B@ozlabs.org>
Date: Wed,  9 Mar 2016 23:51:36 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-03-03 at 23:53:03 UTC, Gavin Shan wrote:
> From: Wei Yang <weiyang@linux.vnet.ibm.com>
> 
> During EEH recovery, hotplug is applied to the devices which don't
> have drivers or their drivers don't support EEH. However, the hotplug,
> which was implemented based on PCI bus, can't be applied to VF directly.
> Instead, we unplug and plug individual PCI devices (VFs).
> 
> This renames virtn_{add,remove}() and exports them so they can be used
> in PCI hotplug during EEH recovery.
> 
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c194f7ea7f68f2690533832ec2

cheers
