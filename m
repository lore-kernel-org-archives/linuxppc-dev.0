Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4NgV6pFRzDqRs
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 05:39:34 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u73JdIaS001253
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Aug 2016 15:39:32 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24kkaj1cdc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Aug 2016 15:39:32 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Wed, 3 Aug 2016 16:39:30 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id E0929352006E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 15:39:07 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u73JdR904636828
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Aug 2016 16:39:27 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u73JdRRA001211
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Aug 2016 16:39:27 -0300
Subject: Re: [PATCH] powerpc: convert 'iommu_alloc failed' messages to dynamic
 debug
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
References: <1465563831-6565-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <1465686148.19533.28.camel@kernel.crashing.org>
 <575EB4DE.9080807@linux.vnet.ibm.com>
 <1465853216.3022.26.camel@kernel.crashing.org>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Wed, 3 Aug 2016 16:39:27 -0300
MIME-Version: 1.0
In-Reply-To: <1465853216.3022.26.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <57A2486F.6000208@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

On 06/13/2016 06:26 PM, Benjamin Herrenschmidt wrote:
> Another option would be to use a dma_attr for silencing mapping errors
> which NVME could use provided it does handle them gracefully ...

I recently submitted patches that implement your suggestion [1].
May you please review/comment if they're OK with you?

Thanks!

[1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-August/146850.html

-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center
