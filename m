Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wpsTF340qzDq8B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 17:29:53 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5G7OX0e091403
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 03:29:50 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b489xeskf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 03:29:50 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Fri, 16 Jun 2017 08:29:48 +0100
Subject: Re: [PATCH V2] cxl: Export library to support IBM XSL
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, vaibhav@linux.vnet.ibm.com
References: <1497446944-15759-1-git-send-email-clombard@linux.vnet.ibm.com>
 <3dba232a-2936-15df-decd-2bdefa0d7a8e@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Fri, 16 Jun 2017 09:29:45 +0200
MIME-Version: 1.0
In-Reply-To: <3dba232a-2936-15df-decd-2bdefa0d7a8e@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <0a098395-a0b8-e63d-e43d-626eaa0270b9@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 16/06/2017 à 09:13, Andrew Donnellan a écrit :
>>
>> +config CXL_LIB
>> +    bool
>> +    default n
>> +
> 
> How necessary is this? Are there any drivers using cxllib that we're 
> trying to get in during this cycle?

That was a Mellanox request, so that they can enable code in their 
driver. Like we've done previously, I expect we should be able to drop 
it once their code is upstream.

   Fred
