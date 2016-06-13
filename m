Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rStrX612tzDqZq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 23:28:12 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5DDOFFg074387
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 09:28:08 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23getkpqdx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 09:28:08 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Mon, 13 Jun 2016 10:28:06 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 5A26A352007C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 09:27:48 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5DDS3kx65011756
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 10:28:03 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5DDS2k1030491
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 10:28:02 -0300
Subject: Re: [PATCH] powerpc: convert 'iommu_alloc failed' messages to dynamic
 debug
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
References: <1465563831-6565-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <1465686148.19533.28.camel@kernel.crashing.org>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Mon, 13 Jun 2016 10:27:58 -0300
MIME-Version: 1.0
In-Reply-To: <1465686148.19533.28.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <575EB4DE.9080807@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

On 06/11/2016 08:02 PM, Benjamin Herrenschmidt wrote:
> I'm not fan of this. This is a very useful message to diagnose why,
> for example, your network adapter is not working properly.
>
> A lot of drivers don't deal well with IOMMU errors.
>
> The fact that NVME trigger these is a problem that needs to be solved
> differently.

Ok, I understand your points.

Thanks for the review -- helps in setting another direction.

Kind regards,

-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center
