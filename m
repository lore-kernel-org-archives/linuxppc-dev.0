Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rl5kf4QWrzDr15
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 02:27:22 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u66GOFhS018167
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 12:27:19 -0400
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 by mx0a-001b2d01.pphosted.com with ESMTP id 240nf2f522-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Jul 2016 12:27:19 -0400
Received: from localhost
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 6 Jul 2016 17:27:17 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3E74C17D8062
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 17:28:38 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u66GREjp16449814
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 16:27:14 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u66GRDrx013613
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 10:27:14 -0600
Subject: Re: [PATCH 01/14] powerpc/powernv: Split cxl code out into a separate
 file
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
References: <1467638532-9250-1-git-send-email-imunsie@au.ibm.com>
 <1467638532-9250-2-git-send-email-imunsie@au.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Wed, 6 Jul 2016 18:27:11 +0200
MIME-Version: 1.0
In-Reply-To: <1467638532-9250-2-git-send-email-imunsie@au.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <577D315F.8060705@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 04/07/2016 15:21, Ian Munsie a écrit :
> From: Ian Munsie <imunsie@au1.ibm.com>
>
> The support for using the Mellanox CX4 in cxl mode will require
> additions to the PHB code. In preparation for this, move the existing
> cxl code out of pci-ioda.c into a separate pci-cxl.c file to keep things
> more organised.
>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>


Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
