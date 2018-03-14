Return-Path: <desnesn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401kvR4s5xzF09Y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 08:12:35 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2EL5nMJ114504
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 17:12:33 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gqava983h-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 17:12:32 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <desnesn@linux.vnet.ibm.com>;
 Wed, 14 Mar 2018 17:12:31 -0400
Subject: Re: [PATCH 1/2, pci] pci: Addition of PCI_DEV_FLAGS_QUIET_PCI_REALIGN
 attribute to the PCI subsystem
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ruscur@russell.cc, aik@ozlabs.ru, david@gibson.dropbear.id.au,
 fbarrat@linux.vnet.ibm.com, brking@linux.vnet.ibm.com
References: <20180314163455.15854-1-desnesn@linux.vnet.ibm.com>
 <20180314163455.15854-2-desnesn@linux.vnet.ibm.com>
 <20180314180642.GC179719@bhelgaas-glaptop.roam.corp.google.com>
 <30c63477-620b-3f8b-82df-fd1e34cd99b8@linux.vnet.ibm.com>
 <20180314185508.GE179719@bhelgaas-glaptop.roam.corp.google.com>
From: =?UTF-8?Q?Desnes_Augusto_Nunes_do_Ros=c3=a1rio?=
 <desnesn@linux.vnet.ibm.com>
Date: Wed, 14 Mar 2018 18:12:23 -0300
MIME-Version: 1.0
In-Reply-To: <20180314185508.GE179719@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <442e2ae9-9423-8bf3-a7c1-a35381781145@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/14/2018 03:55 PM, Bjorn Helgaas wrote:

>>> As far as I'm concerned, we can just remove these messages completely.
>>> I don't think there's any real value there.
>>
>> After I found out that this was happening to all PCI devices on powerpc due
>> to the __weak
>> pcibios_default_alignment() interface (necessary for VFIO passthrough and
>> performance), I confess that this was my first approach to this matter;
>> however I couldn't vouch the need of these messages on other architectures.
>>
>> If there are no further concerns, I definitely prefer sending a second
>> version of this patch only eliminating these messages and attesting the
>> reason why.
>>
>> Thank you very much for your review Bjorn,
> 
> No problem, welcome to PCI, and I hope we see more of your work!

Bjorn,

Awesome! A second version of this fix has been sent with a new title: 
"[PATCH, pci, v2] pci: Delete PCI disabling informational messages"

Thanks for the review and warm welcome!

-- 
Desnes A. Nunes do Rosário
--------------------------
