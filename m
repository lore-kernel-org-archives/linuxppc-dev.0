Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w32Vb0s5YzDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 21:57:58 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3CBrg5m105512
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 07:57:55 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29scjejjk2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 07:57:55 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 12 Apr 2017 12:57:53 +0100
Subject: Re: [PATCH V4 7/7] cxl: Add psl9 specific code
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, imunsie@au1.ibm.com
References: <1491574319-11852-1-git-send-email-clombard@linux.vnet.ibm.com>
 <1491574319-11852-8-git-send-email-clombard@linux.vnet.ibm.com>
 <12e9c746-4f52-d807-2e4f-32ad0b827fb2@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Wed, 12 Apr 2017 13:57:24 +0200
MIME-Version: 1.0
In-Reply-To: <12e9c746-4f52-d807-2e4f-32ad0b827fb2@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <50091fa6-d6f5-47ff-dab3-ab9e2c50ab6b@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 12/04/2017 à 09:52, Andrew Donnellan a écrit :
> On 08/04/17 00:11, Christophe Lombard wrote:
>> +static u32 get_phb_index(struct device_node *np)
>>  {
>>      u32 phb_index;
>>
>>      if (of_property_read_u32(np, "ibm,phb-index", &phb_index))
>> -        return 0;
>> +        return -ENODEV;
>
> Function is unsigned.
>

[Christophe is off till the end of the week, so I'm following up]

Michael: what's the easiest for you at this point? Shall I send a new 
version of the 7th patch with all changes consolidated (tab error + doc 
+ Andrew's remark above)?

   Fred
