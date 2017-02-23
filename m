Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTMYk52CYzDqGd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 16:02:50 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1N4xSGK085919
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 00:02:47 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28srg49cew-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 00:02:46 -0500
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 23 Feb 2017 15:02:44 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A714F2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 16:02:41 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1N52Xqn51838996
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 16:02:41 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1N529aM023507
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 16:02:09 +1100
Subject: Re: [RFC] Remove memory from nodes for memtrace.
To: RashmicaGupta <rashmicy@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Rashmica Gupta <rashmica.g@gmail.com>
References: <20170222213910.5628-1-rashmica.g@gmail.com>
 <20170223135635.5321dcc5@roar.ozlabs.ibm.com>
 <1be421cf-71f2-6e89-90be-fd701b3865da@au1.ibm.com>
 <7125d3ad-2c6e-e1bc-b88d-f8df322af9b2@gmail.com>
Cc: dllehr@us.ibm.com, linuxppc-dev@lists.ozlabs.org
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 23 Feb 2017 16:01:44 +1100
MIME-Version: 1.0
In-Reply-To: <7125d3ad-2c6e-e1bc-b88d-f8df322af9b2@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <7d4aec6b-fe12-a2a4-4a88-92c7b8aa0fa1@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 23/02/17 15:23, RashmicaGupta wrote:
>> You'll want to include the Signed-off-by of all authors involved
>
> Even without them seeing any changes first?

IIUC, you should either run the changes past them first, or add a note 
(e.g. "[rashmica: general cleanup, refactored foo]") with the changes 
between what they gave you and what you submitted between their SOB and 
your SOB.

Though generally this is a somewhat academic discussion :)

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
