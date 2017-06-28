Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyFpX5dHVzDqlL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 18:10:28 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5S843TY006723
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 04:10:26 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bbx86w9p4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 04:10:26 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 28 Jun 2017 09:10:24 +0100
Subject: Re: [PATCH] MAINTAINERS: cxl: update maintainership
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Cc: imunsie@au1.ibm.com
References: <20170628072230.7204-1-andrew.donnellan@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Wed, 28 Jun 2017 10:10:17 +0200
MIME-Version: 1.0
In-Reply-To: <20170628072230.7204-1-andrew.donnellan@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <3e8080fc-de0f-8bb1-ccc3-dcf08a0aa9a2@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 28/06/2017 à 09:22, Andrew Donnellan a écrit :
> As Ian's stepping down from his maintainer role now that he's leaving IBM,
> Frederic has asked me to add myself to the cxl maintainer list. Updating
> accordingly.
> 
> Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Cc: Ian Munsie <imunsie@au1.ibm.com>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> 
> ---
> 
> Applies on top of http://patchwork.ozlabs.org/patch/781464
> ---

Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>




>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6547fc1b5299..b1fd5a02dd28 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3722,6 +3722,7 @@ F:	drivers/net/ethernet/chelsio/cxgb4vf/
> 
>   CXL (IBM Coherent Accelerator Processor Interface CAPI) DRIVER
>   M:	Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> +M:	Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>   L:	linuxppc-dev@lists.ozlabs.org
>   S:	Supported
>   F:	arch/powerpc/platforms/powernv/pci-cxl.c
> 
