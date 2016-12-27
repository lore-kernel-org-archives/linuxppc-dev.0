Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tp9cg5x1GzDq9r
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Dec 2016 09:33:23 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBRMOAjM041027
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Dec 2016 17:33:19 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27ku9vbh1y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Dec 2016 17:33:19 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Tue, 27 Dec 2016 15:33:18 -0700
Subject: Re: [PATCH v2] pci: hotplug: This patch removes unnecessary return
 statement using spatch tool
To: Rahul Krishnan <mrahul.krishnan@gmail.com>, benh@kernel.crashing.org
References: <20161224093800.GA24893@rahul>
Cc: linux-kernel@vger.kernel.org, paulus@samba.org, linux-pci@vger.kernel.org,
 bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Tue, 27 Dec 2016 14:33:13 -0800
MIME-Version: 1.0
In-Reply-To: <20161224093800.GA24893@rahul>
Content-Type: text/plain; charset=windows-1252
Message-Id: <a90f4dce-ab69-d5ea-5c03-4a3a5b1ad164@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/24/2016 01:38 AM, Rahul Krishnan wrote:
> 
> This patch removes unnecessary return statement using spatch tool
> 
> Signed-off-by: Rahul Krishnan <mrahul.krishnan@gmail.com>

Reviewed-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

> ---
>  drivers/pci/hotplug/rpadlpar_core.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
> index dc67f39..78ce2c7 100644
> --- a/drivers/pci/hotplug/rpadlpar_core.c
> +++ b/drivers/pci/hotplug/rpadlpar_core.c
> @@ -455,7 +455,6 @@ static inline int is_dlpar_capable(void)
> 
>  int __init rpadlpar_io_init(void)
>  {
> -	int rc = 0;
> 
>  	if (!is_dlpar_capable()) {
>  		printk(KERN_WARNING "%s: partition not DLPAR capable\n",
> @@ -463,8 +462,7 @@ int __init rpadlpar_io_init(void)
>  		return -EPERM;
>  	}
> 
> -	rc = dlpar_sysfs_init();
> -	return rc;
> +	return dlpar_sysfs_init();
>  }
> 
>  void rpadlpar_io_exit(void)
> 
