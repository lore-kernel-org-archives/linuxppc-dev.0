Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sb6046yBnzDscL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 17:11:32 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8G6wBBr121145
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 03:11:30 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25ftr85ed4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 03:11:29 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 16 Sep 2016 17:11:27 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id F041F2CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 17:11:24 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8G7BO4I6357468
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 17:11:24 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8G7BO5P006104
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 17:11:24 +1000
Subject: Re: [PATCH] MAINTAINERS: Update cxl maintainers
To: Michael Neuling <mikey@neuling.org>, mpe@ellerman.id.au
References: <1474000124-4646-1-git-send-email-mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, imunsie@au1.ibm.com,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Fri, 16 Sep 2016 17:11:23 +1000
MIME-Version: 1.0
In-Reply-To: <1474000124-4646-1-git-send-email-mikey@neuling.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <af48338c-458e-3cba-5166-b0fa731b854d@au1.ibm.com>
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
>  M:	Ian Munsie <imunsie@au1.ibm.com>
> -M:	Michael Neuling <mikey@neuling.org>
> +M:	Frederic Barrat <fbarrat@linux.vnet.ibm.com>
>  L:	linuxppc-dev@lists.ozlabs.org
>  S:	Supported
>  F:	drivers/misc/cxl/
>  F:	include/misc/cxl*
>  F:	include/uapi/misc/cxl.h
>  F:	Documentation/powerpc/cxl.txt
> -F:	Documentation/powerpc/cxl.txt
>  F:	Documentation/ABI/testing/sysfs-class-cxl

We should probably add:

F:	arch/powerpc/platforms/powernv/pci-cxl.c

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
