Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXrPD5TC0zDvk7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2016 16:52:16 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB65mugj069257
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Dec 2016 00:52:13 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 275ht2n0x6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Dec 2016 00:52:12 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Tue, 6 Dec 2016 15:52:10 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3E3043578053
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2016 16:52:07 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB65q7eI29622286
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Dec 2016 16:52:07 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB65q6f7002244
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Dec 2016 16:52:06 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: "andrew.donnellan" <andrew.donnellan@au1.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 pradghos <pradghos@in.ibm.com>, ukrishn <ukrishn@linux.vnet.ibm.com>,
 fbarrat <fbarrat@linux.vnet.ibm.com>
Subject: Re: [PATCH] cxl: prevent read/write to AFU config space while AFU not
 configured
In-reply-to: <20161205132242.13517-1-andrew.donnellan@au1.ibm.com>
References: <20161205132242.13517-1-andrew.donnellan@au1.ibm.com>
Date: Tue, 06 Dec 2016 16:52:04 +1100
Message-Id: <1481003494-sup-9080@x230.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Looks like a reasonable solution

> Pradipta found this while doing testing for cxlflash. I've tested this 
> patch and I'm satisfied that it solves the issue, but I've asked Pradipta 
> to test it a bit further. 

:)
