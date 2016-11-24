Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPS6z6QmvzDw45
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 16:14:19 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAO5EA7l116598
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 00:14:16 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26wdwvapa2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 00:14:15 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 24 Nov 2016 15:14:07 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3916B3578052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 16:14:04 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAO5E4qh31785096
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 16:14:04 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAO5E33K008193
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 16:14:03 +1100
Subject: Re: [RFC][PATCH] Update ppc disassembly in xmon
To: Balbir Singh <bsingharora@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>
References: <6229e33e-2d6e-25d8-4206-2b62f3a11500@gmail.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 24 Nov 2016 16:14:03 +1100
MIME-Version: 1.0
In-Reply-To: <6229e33e-2d6e-25d8-4206-2b62f3a11500@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <9f8b3a9a-3744-6452-5c33-bcf0cdbdaa21@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 24/11/16 13:05, Balbir Singh wrote:
> 9. The license for these files is now GPL v3 or later

As much as I love the GPLv3, isn't this an instant NAK?

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
