Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vT0WY6k3zzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 01:44:41 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1MEiPIZ019851
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 09:44:39 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28rq82vywe-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 09:44:39 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 22 Feb 2017 14:44:32 -0000
Subject: Re: [PATCH] cxl: Enable PCI device ID for future IBM CXL adapter
To: Uma Krishnan <ukrishn@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, Ian Munsie <imunsie@au1.ibm.com>
References: <1487303123-7835-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Cc: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Wed, 22 Feb 2017 15:44:04 +0100
MIME-Version: 1.0
In-Reply-To: <1487303123-7835-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <c4d059e9-c7b0-29f2-f2db-c9d76cb84497@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 17/02/2017 à 04:45, Uma Krishnan a écrit :
> From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
>
> Add support for a future IBM Coherent Accelerator (CXL) device
> with an ID of 0x0623.
>
> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
> ---


Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>



>  drivers/misc/cxl/pci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index cca9388..16d858f 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -123,6 +123,7 @@ static const struct pci_device_id cxl_pci_tbl[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x044b), },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x04cf), },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x0601), },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x0623), },
>  	{ PCI_DEVICE_CLASS(0x120000, ~0), },
>
>  	{ }
>
