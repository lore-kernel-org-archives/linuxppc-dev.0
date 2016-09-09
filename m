Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sVfQ03RxxzDrp7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Sep 2016 11:15:04 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u891Cqle105835
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Sep 2016 21:15:01 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25bc2q8kts-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Sep 2016 21:15:01 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 9 Sep 2016 11:14:58 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B902F3578052
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Sep 2016 11:14:56 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u891EuVN57409640
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Sep 2016 11:14:56 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u891EuVU008618
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Sep 2016 11:14:56 +1000
Subject: Re: [PATCH v2 1/5] powerpc/cell: drop unused iic_get_irq_host()
To: Daniel Axtens <dja@axtens.net>, Arnd Bergmann <arnd@arndb.de>,
 linuxppc-dev@lists.ozlabs.org
References: <1473139963-7496-1-git-send-email-dja@axtens.net>
 <6411576.kd9HS3NQth@wuerfel> <87wpildhsa.fsf@possimpible.ozlabs.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Fri, 9 Sep 2016 11:14:55 +1000
MIME-Version: 1.0
In-Reply-To: <87wpildhsa.fsf@possimpible.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <f2cc92ed-1299-6c33-3d01-4a6f4134767c@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/09/16 10:43, Daniel Axtens wrote:
> Andrew Donellan was telling me there's a Coccinelle script that looks
> for things that are both static and EXPORTed - maybe that's worth
> following up on this point?

https://github.com/coccinelle/coccinellery/blob/master/is_static/is_static.cocci

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
