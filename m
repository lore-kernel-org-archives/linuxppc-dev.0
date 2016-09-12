Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXZpR69P0zDsMB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 14:39:26 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8C4bpjQ005847
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 00:39:24 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25ce5wm6bn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 00:39:24 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 12 Sep 2016 14:39:21 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 443F82CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 14:39:20 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8C4dKrK62324990
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 14:39:20 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8C4dKSp008488
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 14:39:20 +1000
Subject: Re: [PATCH 1/3] powerpc/eeh: Null check uses of eeh_pe_bus_get
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
References: <20160912041724.16646-1-ruscur@russell.cc>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Mon, 12 Sep 2016 14:39:19 +1000
MIME-Version: 1.0
In-Reply-To: <20160912041724.16646-1-ruscur@russell.cc>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <56556240-3093-54b9-cce8-a2d6a24bfc32@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/09/16 14:17, Russell Currey wrote:
> eeh_pe_bus_get() can return NULL if a PCI bus isn't found for a given PE.
> Some callers don't check this, and can cause a null pointer dereference
> under certain circumstances.
>
> Fix this by checking NULL everywhere eeh_pe_bus_get() is called.
>
> Cc: stable #3.10+
> Signed-off-by: Russell Currey <ruscur@russell.cc>

Looks good to me.

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
