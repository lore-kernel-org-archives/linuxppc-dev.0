Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrPFJ3TygzDqFK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 17:23:48 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6F7NXgA119982
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 03:23:45 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 246k0u4ke4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 03:23:45 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 15 Jul 2016 17:23:42 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 53A4F2BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 17:23:41 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6F7Nfdr18874376
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 17:23:41 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6F7Nevl018364
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 17:23:41 +1000
Subject: Re: [bug report] cxl: Add guest-specific code
To: Dan Carpenter <dan.carpenter@oracle.com>, clombard@linux.vnet.ibm.com
References: <20160714215352.GA19749@mwanda>
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Philippe Bergheaud <felix@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Fri, 15 Jul 2016 17:23:39 +1000
MIME-Version: 1.0
In-Reply-To: <20160714215352.GA19749@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <32ab2339-9d4f-dfb9-9095-4ea3d08c3503@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 15/07/16 07:53, Dan Carpenter wrote:
>    919          if (afu->crs_len < 0) {
>                     ^^^^^^^^^^^^^^^^
> Remove this test.  Unsigned is never less than zero.

Is there another lower bound that we should be checking against here?

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
