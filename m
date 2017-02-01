Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vD6GZ6m9HzDqFF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 02:18:46 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v11FDYFL065312
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Feb 2017 10:18:44 -0500
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28ba9yjvx2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Feb 2017 10:18:44 -0500
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 1 Feb 2017 20:48:40 +0530
Received: from d28relay07.in.ibm.com (d28relay07.in.ibm.com [9.184.220.158])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id E58F1E0024
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 20:49:57 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v11FHf4524969414
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Feb 2017 20:47:41 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v11FIa7N031907
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Feb 2017 20:48:37 +0530
Subject: Re: [PATCH 2/5] powerpc/perf: Add PM_INST_DISP event to Power9 event
 list
To: Anton Blanchard <anton@samba.org>
References: <1485779021-31936-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1485779021-31936-2-git-send-email-maddy@linux.vnet.ibm.com>
 <20170201220044.09df70f7@kryten>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Wed, 1 Feb 2017 20:48:36 +0530
MIME-Version: 1.0
In-Reply-To: <20170201220044.09df70f7@kryten>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <b90db1f6-5139-4b6b-f9d2-6fc1d880fc4a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 01 February 2017 04:30 PM, Anton Blanchard wrote:
> Hi Maddy,
>
>> +EVENT(PM_INST_DISP,				0x200f0)
>> +EVENT(PM_INST_DISP_ALT,				0x300f0)
> Are you sure these are the right events? 0x200f2, 0x300f2 should be
> instruction dispatch I think.
Damn. This is bad. I looked at the wrong column. You are right
0x200f2 and 0x300f2 are the PM_INST_DISPL. Nice catch.

Will fix it.

Thanks Anton.
Maddy

>
> Anton
>
