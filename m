Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTvQW0kTZzDqh9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 14:57:38 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5F4rVAF005025
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 00:57:36 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23jgmnay12-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 00:57:36 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Wed, 15 Jun 2016 14:57:33 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 33BB03578053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 14:57:31 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5F4vVPH7274942
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 14:57:31 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5F4vUdY019934
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 14:57:30 +1000
Date: Wed, 15 Jun 2016 10:27:25 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
CC: ego@linux.vnet.ibm.com, mikey@neuling.org, linux-pm@vger.kernel.org,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 maddy@linux.vnet.ibm.com, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 10/11] cpuidle/powernv: Add support for POWER ISA v3
 idle states
References: <1465404871-5406-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1465404871-5406-11-git-send-email-shreyas@linux.vnet.ibm.com>
 <20160613153446.GF10634@linaro.org>	 <575FE0B0.4030309@linux.vnet.ibm.com>
 <1465903788.30200.8.camel@kernel.crashing.org>
In-Reply-To: <1465903788.30200.8.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Message-Id: <5760E035.4070103@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 06/14/2016 04:59 PM, Benjamin Herrenschmidt wrote:
> On Tue, 2016-06-14 at 16:17 +0530, Shreyas B Prabhu wrote:
> 
>>
>> I ignored adding this check because this is part of initcall and we are
>> unlikely to run out of memory at this state. But I'll add the check in
>> next version.
> 
> Why do you malloc the u64 array and not the string pointer array ?
> Shouldn't you either have both on stack or both allocated ?
> 

Yes. I'll make this consistent.

Thanks,
Shreyas
