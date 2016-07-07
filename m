Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlRrD5ZmhzDqxH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 16:03:24 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u675xFNL054667
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 02:03:22 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2415xmmn81-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jul 2016 02:03:21 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 7 Jul 2016 16:03:19 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id AC1803578052
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 16:03:17 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6763HlS10289470
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 16:03:17 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6763HWI017823
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 16:03:17 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 "andrew.donnellan" <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Huy Nguyen <huyn@mellanox.com>
Subject: Re: [PATCH 10/14] cxl: Add support for interrupts on the Mellanox CX4
In-reply-to: <577D50E6.4080204@linux.vnet.ibm.com>
References: <1467638532-9250-1-git-send-email-imunsie@au.ibm.com>
 <1467638532-9250-11-git-send-email-imunsie@au.ibm.com>
 <577D50E6.4080204@linux.vnet.ibm.com>
Date: Thu, 07 Jul 2016 16:03:15 +1000
Message-Id: <1467871294-sup-4948@x230.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Frederic Barrat's message of 2016-07-06 20:41:42 +0200:
> I think we want:
>     if (WARN_ON(hwirq <= 0))
> cxl_find_afu_irq() returns 0 if doesn't find the irq, which is not 
> supposed to happen here.

Good catch - will fix in v2.

Cheers,
-Ian
