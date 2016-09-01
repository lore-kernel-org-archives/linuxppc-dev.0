Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sQ3942tJkzDrcD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Sep 2016 23:32:55 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u81DNcAl145031
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Sep 2016 09:32:52 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 256anfj9n2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Sep 2016 09:32:51 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Thu, 1 Sep 2016 10:32:49 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 827DE3520070
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Sep 2016 09:32:25 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u81DWl444993098
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Sep 2016 10:32:47 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u81DWlYX023724
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Sep 2016 10:32:47 -0300
Subject: Re: [PATCH] powerpc: add kernel parameter iommu_alloc_quiet
To: linuxppc-dev@lists.ozlabs.org,
 "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
References: <1472734602-14330-1-git-send-email-mauricfo@linux.vnet.ibm.com>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Thu, 1 Sep 2016 10:32:44 -0300
MIME-Version: 1.0
In-Reply-To: <1472734602-14330-1-git-send-email-mauricfo@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <a7059cda-7a9a-a183-3a98-a7e00eab1802@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael / Ben,

On 09/01/2016 09:56 AM, Mauricio Faria de Oliveira wrote:
> +#define IOMMU_ALLOC_QUIET_LEN	16 /* includes '\0' */

Guilherme suggested MAX_PARAM_PREFIX_LEN for this, which looks
better (a few extra bytes).

Would you mind to s/16/MAX_PARAM_PREFIX_LEN/ if you like that?
I can send a v2 too; just let me know.

Thanks,

-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center
