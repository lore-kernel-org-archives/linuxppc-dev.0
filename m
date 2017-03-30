Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vv55X1ks0zDqLT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 00:27:12 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2UDOGiG137035
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 09:26:54 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29gbu2xean-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 09:26:53 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Thu, 30 Mar 2017 14:26:50 +0100
Subject: Re: [PATCH V3 0/7] cxl: Add support for Coherent Accelerator
 Interface Architecture 2.0
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 imunsie@au1.ibm.com
References: <1490714052-18902-1-git-send-email-clombard@linux.vnet.ibm.com>
 <9d6099a1-23d0-6b32-a015-fa9a2e2a42a5@au1.ibm.com>
From: christophe lombard <clombard@linux.vnet.ibm.com>
Date: Thu, 30 Mar 2017 15:26:21 +0200
MIME-Version: 1.0
In-Reply-To: <9d6099a1-23d0-6b32-a015-fa9a2e2a42a5@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <a32d73cd-2cdd-8233-124c-f2d1291f1f0d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 30/03/2017 à 06:44, Andrew Donnellan a écrit :
> On 29/03/17 02:14, Christophe Lombard wrote:
>> This series adds support for a cxl card which supports the Coherent
>> Accelerator Interface Architecture 2.0.
>>
>> It requires IBM Power9 system and the Power Service Layer, version 9.
>> The PSL provides the address translation and system memory cache for
>> CAIA compliant Accelerators.
>> the PSL attaches to the IBM Processor chip through the PCIe link using
>> the PSL-specific “CAPI Protocol” Transaction Layer Packets.
>> The PSL and CAPP communicate using PowerBus packets.
>> When using a PCIe link the PCIe Host Bridge (PHB) decodes the CAPI
>> Protocol Packets from the PSL and forwards them as PowerBus data
>> packets. The PSL also has an optional DMA feature which allows the AFU
>> to send native PCIe reads and writes to the Processor.
>
> Today Mikey reminded me that Documentation/powerpc/cxl.txt still 
> exists - we probably ought to update it.
>

right. good point. thanks
