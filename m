Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vtsX562jlzDqKT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 15:45:57 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2U4hq78052319
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 00:45:54 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29gfk2ce5b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 00:45:53 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 30 Mar 2017 14:45:50 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2U4jdp546792890
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 15:45:47 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2U4jFf1016201
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 15:45:15 +1100
Subject: Re: [PATCH V3 0/7] cxl: Add support for Coherent Accelerator
 Interface Architecture 2.0
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 imunsie@au1.ibm.com
References: <1490714052-18902-1-git-send-email-clombard@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 30 Mar 2017 15:44:50 +1100
MIME-Version: 1.0
In-Reply-To: <1490714052-18902-1-git-send-email-clombard@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <9d6099a1-23d0-6b32-a015-fa9a2e2a42a5@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 29/03/17 02:14, Christophe Lombard wrote:
> This series adds support for a cxl card which supports the Coherent
> Accelerator Interface Architecture 2.0.
>
> It requires IBM Power9 system and the Power Service Layer, version 9.
> The PSL provides the address translation and system memory cache for
> CAIA compliant Accelerators.
> the PSL attaches to the IBM Processor chip through the PCIe link using
> the PSL-specific “CAPI Protocol” Transaction Layer Packets.
> The PSL and CAPP communicate using PowerBus packets.
> When using a PCIe link the PCIe Host Bridge (PHB) decodes the CAPI
> Protocol Packets from the PSL and forwards them as PowerBus data
> packets. The PSL also has an optional DMA feature which allows the AFU
> to send native PCIe reads and writes to the Processor.

Today Mikey reminded me that Documentation/powerpc/cxl.txt still exists 
- we probably ought to update it.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
