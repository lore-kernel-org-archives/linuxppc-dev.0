Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rT6Dm5n96zDqZv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 08:01:28 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5DLwU0X084242
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 18:01:27 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23gf66ntym-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 18:01:26 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Mon, 13 Jun 2016 19:01:24 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id C3B8D3520068
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 18:01:06 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5DM1M5j4501564
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 19:01:22 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5DM1M1g015359
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 19:01:22 -0300
Subject: Re: [PATCH] powerpc: convert 'iommu_alloc failed' messages to dynamic
 debug
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
References: <1465563831-6565-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <1465686148.19533.28.camel@kernel.crashing.org>
 <575EB4DE.9080807@linux.vnet.ibm.com>
 <1465853216.3022.26.camel@kernel.crashing.org>
 <575F290A.2070902@linux.vnet.ibm.com>
 <1465854679.3022.31.camel@kernel.crashing.org>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Mon, 13 Jun 2016 19:01:19 -0300
MIME-Version: 1.0
In-Reply-To: <1465854679.3022.31.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <575F2D2F.2050302@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/13/2016 06:51 PM, Benjamin Herrenschmidt wrote:
> Approximate wasn't a great choice of word but what I meant is:
>
>   - The size doesn't mean you can do an allocation that size (pools
> layout etc..)

>   - And it might be shared with another device (though less likely
> these days).

Ah, yup - ok, now I get it; thanks.


-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center
