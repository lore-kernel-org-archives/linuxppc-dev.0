Return-Path: <srs0=q1ye=5z=linux.vnet.ibm.com=victora@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsTfz1X8FzDqhk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 23:47:23 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wsTfy6dV8z8t85
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 23:47:22 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wsTfy23cDz9s1h
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2017 23:47:21 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5KDi06q112594
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2017 09:47:20 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b6ykx7b8u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2017 09:47:19 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <victora@linux.vnet.ibm.com>;
 Tue, 20 Jun 2017 09:47:18 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 20 Jun 2017 10:47:47 -0300
From: victora <victora@linux.vnet.ibm.com>
To: alistair@popple.id.au, jk@ozlabs.org
Cc: mauricfo@linux.vnet.ibm.com, victora@br.ibm.com, linuxppc-dev@ozlabs.org
Subject: 1M hugepage size being registered on Linux
Message-Id: <322aa4a1a11ca79008a8c894c12a80d5@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Alistair/Jeremy,

I am working on a bug related to 1M hugepage size being registered on 
Linux (Power 8 Baremetal - Garrison).

I was checking dmesg and it seems that 1M page size is coming from 
firmware to Linux.

[    0.000000] base_shift=20: shift=20, sllp=0x0130, avpnm=0x00000000, 
tlbiel=0, penc=2
[    1.528867] HugeTLB registered 1 MB page size, pre-allocated 0 pages

Should Linux support this page size? As afar as I know, this was an 
unsupported page size in the past isn't it? If this should be supported 
now, is there any specific reason for that?

Thanks,

Victor Aoqui
Software Engineer: Linux Kernel Backports
Linux Technology Center
IBM Systems
