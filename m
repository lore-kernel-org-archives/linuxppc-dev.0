Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 333CE1A006F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 13:03:16 +1100 (AEDT)
In-Reply-To: <1456724453-10152-1-git-send-email-vaibhav@linux.vnet.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: cxl: Ignore probes for virtual afu pci devices
Message-Id: <20160310020315.EEBBB140783@ozlabs.org>
Date: Thu, 10 Mar 2016 13:03:15 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-29-02 at 05:40:53 UTC, Vaibhav Jain wrote:
> Add a check at the beginning of cxl_probe function to ignore virtual pci
> devices created for each afu registered. This fixes the the errors
> messages logged about missing CXL vsec, when cxl probe is unable to
> find necessary vsec entries in device pci config space. The error
> message logged are of the form :
> 
> cxl-pci 0004:00:00.0: ABORTING: CXL VSEC not found!
> cxl-pci 0004:00:00.0: cxl_init_adapter failed: -19
> 
> Cc: Ian Munsie <imunsie@au1.ibm.com>
> Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> Reviewed-by: fbarrat@linux.vnet.ibm.com
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/17eb3eef19f2c0541a7f04ad37

cheers
