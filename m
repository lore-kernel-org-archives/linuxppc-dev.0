Return-Path: <desnesn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zXzyf54dgzDqgY
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Feb 2018 01:34:34 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w12ETXmt121864
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Feb 2018 09:34:31 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fvrwbb0mk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Feb 2018 09:34:31 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <desnesn@linux.vnet.ibm.com>;
 Fri, 2 Feb 2018 07:34:30 -0700
Subject: Re: [PATCH, net] ibmvnic: fix firmware version when no firmware level
 has been provided by the VIOS server
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 tlfalcon@linux.vnet.ibm.com, jallen@linux.vnet.ibm.com,
 nfont@linux.vnet.ibm.com
References: <20180201180430.16950-1-desnesn@linux.vnet.ibm.com>
 <20180201.145935.1511421104143236233.davem@davemloft.net>
From: =?UTF-8?Q?Desnes_Augusto_Nunes_do_Ros=c3=a1rio?=
 <desnesn@linux.vnet.ibm.com>
Date: Fri, 2 Feb 2018 12:34:25 -0200
MIME-Version: 1.0
In-Reply-To: <20180201.145935.1511421104143236233.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <afddeb9a-c4c7-97b4-b38e-f2ffc8d64a5c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello David,

Thank you for your review and the heads up about protocol.

On 02/01/2018 05:59 PM, David Miller wrote:
> From: Desnes Augusto Nunes do Rosario <desnesn@linux.vnet.ibm.com>
> Date: Thu,  1 Feb 2018 16:04:30 -0200
> 
>> Older versions of VIOS servers do not send the firmware level in the VPD
>> buffer for the ibmvnic driver. Thus, not only the current message is mis-
>> leading but the firmware version in the ethtool will be NULL. Therefore,
>> this patch fixes the firmware string and its warning.
>>
>> Fixes: 4e6759be28e4 ("ibmvnic: Feature implementation of VPD for the ibmvnic driver")
>>
>> Signed-off-by: Desnes A. Nunes do Rosario <desnesn@linux.vnet.ibm.com>
> 
> Applied.
> 
> Please do not put empty lines between Fixes: and Signed-off-by: and other
> tags, all tags are equal and are placed together in an uninterrupted
> sequences of consequetive lines.
> 
> Thank you.
> 

-- 
Desnes Augusto Nunes do Rosário
------------------------------------------

Linux Developer - IBM / Brazil
M.Sc. in Electrical and Computer Engineering - UFRN
