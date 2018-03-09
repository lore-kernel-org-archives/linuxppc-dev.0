Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zyFlD2G1XzF1pR
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Mar 2018 16:08:23 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w29553bW096359
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Mar 2018 00:08:21 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gkk1mhg5g-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Mar 2018 00:08:20 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 9 Mar 2018 05:08:18 -0000
Subject: Re: [PATCH v2 00/38] cxlflash: OCXL transport support
To: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Cc: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
References: <1519683513-16731-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <yq18tb5rskt.fsf@oracle.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Fri, 9 Mar 2018 16:08:12 +1100
MIME-Version: 1.0
In-Reply-To: <yq18tb5rskt.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <6d69dab9-7f8d-0f4c-d276-d5cf2e882df6@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/03/18 05:01, Martin K. Petersen wrote:
> 
>> This patch series adds OCXL support to the cxlflash driver. With this
>> support, new devices using the OCXL transport will be supported by the
>> cxlflash driver along with the existing CXL devices. An effort is made
>> to keep this transport specific function independent of the existing
>> core driver that communicates with the AFU.
> 
> This one has been sitting for a week without any reviews. Andrew, when
> will you have time to take a look? >
> Being a pretty big chunk of code, I would like to merge it sooner rather
> than later. Or we can postpone until 4.18, of course.
> 

Slowly getting through it, though as of next Friday I'll be disappearing 
from the face of the earth for 3 weeks and I'm not sure I'll be finished 
by then.

Fred: could you take a look at this series if you have spare cycles?

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
