Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQVd00dqPzDq68
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 02:09:55 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u59G3rQj084252
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Jun 2016 12:09:53 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23eejymq6k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jun 2016 12:09:52 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Fri, 10 Jun 2016 02:09:50 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id C4F0B2BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 02:09:37 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u59G9MOx4981128
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 02:09:27 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u59G9Lwo024865
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 02:09:22 +1000
Date: Thu, 09 Jun 2016 21:39:09 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
CC: mpe@ellerman.id.au, ego@linux.vnet.ibm.com, mikey@neuling.org,
 maddy@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 08/11] powerpc/powernv: Add platform support for stop
 instruction
References: <1464871141-11568-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1464871141-11568-9-git-send-email-shreyas@linux.vnet.ibm.com>
 <20160609044225.GA16550@tungsten.ozlabs.ibm.com>
In-Reply-To: <20160609044225.GA16550@tungsten.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <575994A5.3010205@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 06/09/2016 10:12 AM, Sam Bobroff wrote:
> On Thu, Jun 02, 2016 at 07:38:58AM -0500, Shreyas B. Prabhu wrote:
> 
> ...
> 
>> +/* Power Management - PSSCR Fields */
> 
> It might be nice to give the full name of the register, as below with the FPSCR.
> 

I'll make the change while posting the next rev.

Thanks,
Shreyas

>> +#define PSSCR_RL_MASK		0x0000000F
>> +#define PSSCR_MTL_MASK		0x000000F0
>> +#define PSSCR_TR_MASK		0x00000300
>> +#define PSSCR_PSLL_MASK		0x000F0000
>> +#define PSSCR_EC		0x00100000
>> +#define PSSCR_ESL		0x00200000
>> +#define PSSCR_SD		0x00400000
>> +
>> +
>>  /* Floating Point Status and Control Register (FPSCR) Fields */
> 
> Cheers,
> Sam.
> 
