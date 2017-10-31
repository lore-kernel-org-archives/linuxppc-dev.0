Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yR73v3sWczDqwZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 21:33:30 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9VASkx6107109
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 06:33:26 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dxkmdvy63-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 06:33:26 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Tue, 31 Oct 2017 10:33:24 -0000
Subject: Re: [PATCH] powerpc/powernv: Enable tunneled operations
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: fbarrat@linux.vnet.ibm.com
References: <20171025105215.19547-1-felix@linux.vnet.ibm.com>
From: christophe lombard <clombard@linux.vnet.ibm.com>
Date: Tue, 31 Oct 2017 11:33:18 +0100
MIME-Version: 1.0
In-Reply-To: <20171025105215.19547-1-felix@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <89990442-5d51-1f7c-642b-dc577d0daa93@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 25/10/2017 à 12:52, Philippe Bergheaud a écrit :

> P9 supports PCI tunneled operations (atomics and as_notify).
>
> This patch adds support for tunneled operations on powernv, by adding a
> new API to be called by drivers:
>
> pnv_pci_get_tunnel_ind() -- tell driver the 16-bit ASN indication set by
> kernel.
>
> pnv_pci_set_tunnel_bar() -- tell kernel the Tunnel BAR address mask used
> by driver.
>
> These functions use four new OPAL calls, as PBCQ and PHB configurations
> are done by skiboot.
>
> Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
> ---
> This patch depends on the following skiboot prerequisites:
>
>    https://patchwork.ozlabs.org/patch/829294/
>    [1/2] phb4: set PHB CMPM registers for tunneled operations
>
>    https://patchwork.ozlabs.org/patch/829293/
>    [2/2] phb4: set PBCQ Tunnel BAR for tunneled operations
>

Looks good for me.

Acked-by:  Christophe Lombard<clombard@linux.vnet.ibm.com>

Thanks
