Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sb6CR61H4zDskW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 17:21:23 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8G7IVeO133540
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 03:21:21 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25fnnyw2jb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 03:21:21 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 16 Sep 2016 17:21:18 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B3AF82BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 17:21:15 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8G7LFE551970142
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 17:21:15 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8G7LEnR012440
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 17:21:15 +1000
Subject: Re: [PATCH] MAINTAINERS: Update cxl maintainers
To: Michael Neuling <mikey@neuling.org>, mpe@ellerman.id.au
References: <1474000124-4646-1-git-send-email-mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, imunsie@au1.ibm.com,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Fri, 16 Sep 2016 17:21:14 +1000
MIME-Version: 1.0
In-Reply-To: <1474000124-4646-1-git-send-email-mikey@neuling.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <5e2af05a-38ff-a43e-67c9-3fb9abc28bfa@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 16/09/16 14:28, Michael Neuling wrote:
 > Fred has taken over the cxl maintenance I was doing.  This updates the
 > MAINTAINERS file to reflect this.
 >
 > It also removes a duplicate entry in the files covered.
 >
 > Signed-off-by: Michael Neuling <mikey@neuling.org>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

 >  CXL (IBM Coherent Accelerator Processor Interface CAPI) DRIVER
 >  M:    Ian Munsie <imunsie@au1.ibm.com>
 > -M:    Michael Neuling <mikey@neuling.org>
 > +M:    Frederic Barrat <fbarrat@linux.vnet.ibm.com>
 >  L:    linuxppc-dev@lists.ozlabs.org
 >  S:    Supported
 >  F:    drivers/misc/cxl/
 >  F:    include/misc/cxl*
 >  F:    include/uapi/misc/cxl.h
 >  F:    Documentation/powerpc/cxl.txt
 > -F:    Documentation/powerpc/cxl.txt
 >  F:    Documentation/ABI/testing/sysfs-class-cxl

We should probably add:

F:    arch/powerpc/platforms/powernv/pci-cxl.c

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
