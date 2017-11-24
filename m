Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjrtn41wYzDrnn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 20:46:41 +1100 (AEDT)
In-Reply-To: <20171123033857.13122-1-vaibhav@linux.vnet.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, stable@vger.kernel.org,
 Alastair D'Silva <alastair@linux.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
Subject: Re: [v3] cxl: Check if vphb exists before iterating over AFU devices
Message-Id: <3yjrtn33cvz9s71@ozlabs.org>
Date: Fri, 24 Nov 2017 20:46:40 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-11-23 at 03:38:57 UTC, Vaibhav Jain wrote:
> During an eeh a kernel-oops is reported if no vPHB is allocated to the
> AFU. This happens as during AFU init, an error in creation of vPHB is
> a non-fatal error. Hence afu->phb should always be checked for NULL
> before iterating over it for the virtual AFU pci devices.
> 
> This patch fixes the kenel-oops by adding a NULL pointer check for
> afu->phb before it is dereferenced.
> 
> Fixes: 9e8df8a2196("cxl: EEH support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/12841f87b7a8ceb3d54f171660f72a

cheers
