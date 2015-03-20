Return-Path: <bhelgaas@google.com>
Received: from mail-ig0-x233.google.com (mail-ig0-x233.google.com
 [IPv6:2607:f8b0:4001:c05::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404161A0372
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2015 08:22:52 +1100 (AEDT)
Received: by igbud6 with SMTP id ud6so2726948igb.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 14:22:49 -0700 (PDT)
Date: Fri, 20 Mar 2015 16:22:46 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH V14 14/21] powerpc/powernv: Allocate struct pnv_ioda_pe
 iommu_table dynamically
Message-ID: <20150320212246.GM26935@google.com>
References: <1426820797-6267-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1426820797-6267-15-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426820797-6267-15-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, benh@au1.ibm.com, linuxppc-dev@lists.ozlabs.org,
 gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 20, 2015 at 11:06:30AM +0800, Wei Yang wrote:
> Previously the iommu_table had the same lifetime as a struct pnv_ioda_pe
> and was embedded in it. The pnv_ioda_pe was assigned to a PE on the bootup
> stage. Since PEs are based on the hardware layout which is static in the
> system, they will never get released. This means the iommu_table in the
> pnv_ioda_pe will never get rleased neither.

"will never get released either."
