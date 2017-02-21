Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSWkW3wqPzDqGp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 07:07:31 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1LJxs5R008493
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 15:07:29 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28rshfqrnq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 15:07:29 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Tue, 21 Feb 2017 13:07:28 -0700
Subject: Re: [PATCH] cxl: Enable PCI device ID for future IBM CXL adapter
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 Ian Munsie <imunsie@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
References: <1487303123-7835-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <63ce34b0-a712-9d31-ea51-c36daa35252b@au1.ibm.com>
Cc: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Date: Tue, 21 Feb 2017 14:07:18 -0600
MIME-Version: 1.0
In-Reply-To: <63ce34b0-a712-9d31-ea51-c36daa35252b@au1.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <525d735e-2d98-8e19-c962-50e868768fd9@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2/19/2017 4:54 AM, Andrew Donnellan wrote:
> On 17/02/17 14:45, Uma Krishnan wrote:
>> From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
>>
>> Add support for a future IBM Coherent Accelerator (CXL) device
>> with an ID of 0x0623.
>>
>> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
>> Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
>
> Is this a CAIA 1 or CAIA 2 device?
>

CAIA 1 device
