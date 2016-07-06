Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rl6G71MSczDqxj
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 02:51:11 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u66GiOWv067650
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 12:51:09 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 240nf2fxp8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Jul 2016 12:51:08 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 6 Jul 2016 17:51:06 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7149D17D805F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 17:52:27 +0100 (BST)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u66Gp3bq17105248
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 16:51:04 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u66Gp3SR001292
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 10:51:03 -0600
Subject: Re: [PATCH 05/14] cxl: Allow a default context to be associated with
 an external pci_dev
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
References: <1467638532-9250-1-git-send-email-imunsie@au.ibm.com>
 <1467638532-9250-6-git-send-email-imunsie@au.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Wed, 6 Jul 2016 18:51:02 +0200
MIME-Version: 1.0
In-Reply-To: <1467638532-9250-6-git-send-email-imunsie@au.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <577D36F6.305@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 04/07/2016 15:22, Ian Munsie a écrit :
> From: Ian Munsie <imunsie@au1.ibm.com>
>
> The cxl kernel API has a concept of a default context associated with
> each PCI device under the virtual PHB. The Mellanox CX4 will also use
> the cxl kernel API, but it does not use a virtual PHB - rather, the AFU
> appears as a physical function as a peer to the networking functions.
>
> In order to allow the kernel API to work with those networking
> functions, we will need to associate a default context with them as
> well. To this end, refactor the corresponding code to do this in vphb.c
> and export it so that it can be called from the PHB code.
>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>

Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
