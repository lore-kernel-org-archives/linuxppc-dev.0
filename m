Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zFgkZ75NdzF0PS
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 03:31:02 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.21) with SMTP id
 w08GT6e8080909
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Jan 2018 11:31:00 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fc6w3r0c2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jan 2018 11:31:00 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Mon, 8 Jan 2018 16:30:58 -0000
Subject: Re: [PATCH v5 1/2] powerpc/powernv: Enable tunneled operations
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: clombard@linux.vnet.ibm.com, benh@au1.ibm.com
References: <20171222123624.1880-1-felix@linux.vnet.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Mon, 8 Jan 2018 17:30:54 +0100
MIME-Version: 1.0
In-Reply-To: <20171222123624.1880-1-felix@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <3b0e743c-9b89-43ab-75e0-6629941004d4@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 22/12/2017 à 13:36, Philippe Bergheaud a écrit :
> P9 supports PCI tunneled operations (atomics and as_notify). This
> patch adds support for tunneled operations on powernv, with a new
> API, to be called by device drivers:
> 
> pnv_pci_get_tunnel_ind()
>     Tell driver the 16-bit ASN indication used by kernel.
> 
> pnv_pci_set_tunnel_bar()
>     Tell kernel the Tunnel BAR Response address used by driver.
>     This function uses two new OPAL calls, as the PBCQ Tunnel BAR
>     register is configured by skiboot.
> 
> pnv_pci_get_as_notify_info()
>     Return the ASN info of the thread to be woken up.
> 
> Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
> ---

Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
