Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyFpf2RY7zDr49
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 18:10:34 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5S84A2r017913
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 04:10:32 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bc7a3bnt5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 04:10:32 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 28 Jun 2017 09:10:29 +0100
Subject: Re: [PATCH] MAINTAINERS: Remove myself as cxl maintainer
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
References: <20170628061920.26722-1-imunsie@au.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Wed, 28 Jun 2017 10:09:59 +0200
MIME-Version: 1.0
In-Reply-To: <20170628061920.26722-1-imunsie@au.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d9793035-08e8-59d2-0083-be2b51c3ea0b@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 28/06/2017 à 08:19, Ian Munsie a écrit :
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> I am no longer employed by IBM and will no longer have access to cxl
> hardware, so remove myself as a cxl maintainer.
> 
> If anyone needs to contact me in the future, please use my personal
> email address darkstarsword@gmail.com
> 
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---

Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>


>   MAINTAINERS | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9e984645c4b0..1e8a915577fa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3721,7 +3721,6 @@ S:	Supported
>   F:	drivers/net/ethernet/chelsio/cxgb4vf/
> 
>   CXL (IBM Coherent Accelerator Processor Interface CAPI) DRIVER
> -M:	Ian Munsie <imunsie@au1.ibm.com>
>   M:	Frederic Barrat <fbarrat@linux.vnet.ibm.com>
>   L:	linuxppc-dev@lists.ozlabs.org
>   S:	Supported
> 
