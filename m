Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrTvD5KLRzDqyY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 20:53:28 +1000 (AEST)
In-Reply-To: <1468444634-1866-15-git-send-email-imunsie@au.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Huy Nguyen <huyn@mellanox.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Ian Munsie <imunsie@au1.ibm.com>, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [14/15] PCI/hotplug: pnv_php: handle OPAL_PCI_SLOT_OFFLINE power
 state
Message-Id: <3rrTvD2DB5z9sBg@ozlabs.org>
Date: Fri, 15 Jul 2016 20:53:28 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-13-07 at 21:17:13 UTC, Ian Munsie wrote:
> From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> 
> When calling pnv_php_set_slot_power_state() with state ==
> OPAL_PCI_SLOT_OFFLINE, remove devices from the device tree as if we're
> dealing with OPAL_PCI_SLOT_POWER_OFF.
> 
> Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Cc: linux-pci@vger.kernel.org
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5473a6bf635d35d5c1d12d0e13

cheers
