Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yG1hB5QmKzDrVD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 01:59:54 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9GExX9F014673
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 10:59:52 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dmubebn4m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 10:59:52 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 16 Oct 2017 10:59:51 -0400
Subject: Re: [PATCH0/8] Support for ibm, dynamic-memory-v2 device tree property
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <150705593139.7318.5934648279979743833.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
 <8760bsc51n.fsf@concordia.ellerman.id.au>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Mon, 16 Oct 2017 09:59:48 -0500
MIME-Version: 1.0
In-Reply-To: <8760bsc51n.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <da50b5ad-77c1-de2d-fb2e-48bc13987bc9@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/06/2017 04:58 PM, Michael Ellerman wrote:
> Nathan Fontenot <nfont@linux.vnet.ibm.com> writes:
>> This patch set provides a set of updates to de-couple the LMB information
>> provided in the ibm,dynamic-memory device tree property from the device
>> tree property format. The goal is to provide a data set of LMB information
>> so that consumners of this data do not need to understand and provide
>> multiple parsing routines for the supported device tree property formats.
> 
> Couple of build problems in this series.
> 
> The non-pseries build dies with:
> 
>   arch/powerpc/kernel/prom.c:541:4: error: implicit declaration of function 'early_init_dt_scan_drmem_lmbs' [-Werror=implicit-function-declaration]
> 
> And pseries dies with:
> 
>   arch/powerpc/platforms/pseries/hotplug-memory.c:860:21: error: 'lmbs_available' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> cheers
> 

Ugh! I was hoping I had tried all permutations. Obviously I missed some.

I'll send out an updated patch set after fixing the build issues.

-Nathan
