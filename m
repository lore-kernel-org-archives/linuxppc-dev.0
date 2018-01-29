Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zVGND71mrzDqmn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 15:13:48 +1100 (AEDT)
In-Reply-To: <20180105164552.36371-8-bryantly@linux.vnet.ibm.com>
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: jjalvare@linux.vnet.ibm.com, aik@ozlabs.ru, linux-pci@vger.kernel.org,
 eli@mellanox.com, saeedm@mellanox.com, alex.williamson@redhat.com,
 helgaas@kernel.org, seroyer@linux.vnet.ibm.com,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 bodong@mellanox.com
Subject: Re: [v4,7/7] pseries/setup: Add Initialization of VF Bars
Message-Id: <3zVGND3MxBz9t20@ozlabs.org>
Date: Mon, 29 Jan 2018 15:13:48 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-01-05 at 16:45:52 UTC, "Bryant G. Ly" wrote:
> When enabling SR-IOV in pseries platform,
> the VF bar properties for a PF are reported on
> the device node in the device tree.
> 
> This patch adds the IOV Bar resources to Linux
> structures from the device tree for later use
> when configuring SR-IOV by PF driver.
> 
> Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
> Signed-off-by: Juan J. Alvarez <jjalvare@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/fc5f622163637308a3d520a3155274

cheers
