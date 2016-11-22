Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNNc82BTVzDvn8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 22:32:23 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAMBSriP112441
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 06:32:22 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26vhbdbsty-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 06:32:21 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 22 Nov 2016 11:32:19 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6CE931B08023
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 11:34:34 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAMBWFSV32440420
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 11:32:15 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAMBWFTs021768
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 04:32:15 -0700
Subject: Re: [PATCH] cxl: fix coccinelle warnings
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, imunsie@au1.ibm.com
References: <20161122101327.14281-1-andrew.donnellan@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Tue, 22 Nov 2016 12:32:15 +0100
MIME-Version: 1.0
In-Reply-To: <20161122101327.14281-1-andrew.donnellan@au1.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <f8804712-d36d-ca81-1ffe-4a79a6946dc1@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 22/11/2016 à 11:13, Andrew Donnellan a écrit :
> Fix the following coccinelle warnings:
>
>     drivers/misc/cxl/debugfs.c:46:0-23: WARNING: fops_io_x64 should be
>         defined with DEFINE_DEBUGFS_ATTRIBUTE
>     drivers/misc/cxl/guest.c:890:5-26: WARNING: Comparison to bool
>     drivers/misc/cxl/irq.c:107:3-23: WARNING: Assignment of bool to 0/1
>     drivers/misc/cxl/native.c:57:2-3: Unneeded semicolon
>     drivers/misc/cxl/native.c:170:2-3: Unneeded semicolon
>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> ---

Thanks!

Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
