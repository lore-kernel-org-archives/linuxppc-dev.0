Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xPCL76pL6zDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Aug 2017 02:38:55 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v74GYfoP109203
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Aug 2017 12:38:52 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c4r439dq9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Aug 2017 12:38:51 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Fri, 4 Aug 2017 10:38:51 -0600
Subject: Re: [PATCH] PCI: Convert to using %pOF instead of full_name
To: Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, Paul Mackerras
 <paulus@samba.org>, linux-tegra@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20170718214339.7774-41-robh@kernel.org>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Fri, 4 Aug 2017 09:38:42 -0700
MIME-Version: 1.0
In-Reply-To: <20170718214339.7774-41-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Message-Id: <dd5a317b-9e72-97bc-0386-8470998421c3@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/18/2017 02:43 PM, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-tegra@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  drivers/pci/host/pci-mvebu.c        | 8 ++++----
>  drivers/pci/host/pci-tegra.c        | 3 +--
>  drivers/pci/hotplug/pnv_php.c       | 4 ++--
>  drivers/pci/hotplug/rpadlpar_core.c | 4 ++--
>  drivers/pci/hotplug/rpaphp_core.c   | 2 +-
>  drivers/pci/hotplug/rpaphp_pci.c    | 4 ++--
>  drivers/pci/hotplug/rpaphp_slot.c   | 4 ++--
>  drivers/pci/pci-sysfs.c             | 4 ++--
>  drivers/pci/pci.c                   | 4 ++--
>  9 files changed, 18 insertions(+), 19 deletions(-)
> 

Reviewed-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
