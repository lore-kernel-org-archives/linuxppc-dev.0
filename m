Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yrpzZ577jzDrpd
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Dec 2017 04:44:57 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vB5HcrFZ035135
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Dec 2017 12:44:54 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2envy1ty8q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Dec 2017 12:44:53 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 5 Dec 2017 17:44:51 -0000
Subject: Re: [PATCH] cxl: Enable PCI device ID for future CAPI adapter
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, vaibhav@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com
References: <1512493568-1751-1-git-send-email-clombard@linux.vnet.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Tue, 5 Dec 2017 18:44:49 +0100
MIME-Version: 1.0
In-Reply-To: <1512493568-1751-1-git-send-email-clombard@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <2560a2da-622a-c12e-984c-72cdc796a82f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 05/12/2017 à 18:06, Christophe Lombard a écrit :
> Add support for future Coherent Accelerator device with an
> ID of 0x060e.
> 
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> ---

mpe, you can drop that patch, it's not needed. Christophe and I have 
sync'd up.

   Fred


>   drivers/misc/cxl/pci.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 19969ee..5f5b9aa 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -123,6 +123,7 @@ static const struct pci_device_id cxl_pci_tbl[] = {
>   	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x044b), },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x04cf), },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x0601), },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x060e), },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x0623), },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x0628), },
>   	{ PCI_DEVICE_CLASS(0x120000, ~0), },
> 
