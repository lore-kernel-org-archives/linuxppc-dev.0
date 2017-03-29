Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vtPcc2qhJzDqH3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 21:48:16 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2TAiYkw047388
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 06:48:09 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29ftv291wm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 06:48:09 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 29 Mar 2017 06:48:07 -0400
Subject: Re: [PATCH V5 02/17] powerpc/mm/slice: Update the function prototype
To: Paul Mackerras <paulus@ozlabs.org>
References: <1490153823-29241-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1490153823-29241-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20170329034338.GB13844@fergus.ozlabs.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 29 Mar 2017 16:18:01 +0530
MIME-Version: 1.0
In-Reply-To: <20170329034338.GB13844@fergus.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <48543412-6a34-8734-cf6e-02325180e0f7@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 29 March 2017 09:13 AM, Paul Mackerras wrote:
> On Wed, Mar 22, 2017 at 09:06:48AM +0530, Aneesh Kumar K.V wrote:
>> This avoid copying the slice_mask struct as function return value
>
> Did you do before/after comparisons of kernel text size?
>
> Paul.
>
    text    data     bss     dec     hex filename
10114479        5023602 1071772 16209853         f757bd 
./vmlinux.beforepatch
10114351        5023602 1071772 16209725         f7573d ./vmlinux.afterpatch

-aneesh
