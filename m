Return-Path: <srs0=tsnp=3s=linux.vnet.ibm.com=khandual@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w1lKf6SGwzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 19:30:46 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3w1lKf5sNfz8t7X
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 19:30:46 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3w1lKf2yHzz9sNV
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2017 19:30:46 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3A9O7p0066152
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2017 05:30:23 -0400
Received: from e23smtp04.au.ibm.com ([202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29r5p5bgsd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2017 05:30:22 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 10 Apr 2017 19:30:15 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3A9U53h55050386
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2017 19:30:13 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3A9TbbF009954
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2017 19:29:37 +1000
Subject: Re: [PATCH] powerpc/powernv: Fix powernv Kconfig dependencies
To: Alistair Popple <alistair@popple.id.au>, mpe@ellerman.id.au
References: <1491801875-25733-1-git-send-email-alistair@popple.id.au>
Cc: linuxppc-dev@ozlabs.org
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Mon, 10 Apr 2017 14:59:18 +0530
MIME-Version: 1.0
In-Reply-To: <1491801875-25733-1-git-send-email-alistair@popple.id.au>
Content-Type: text/plain; charset=windows-1252
Message-Id: <f05e6976-d320-917a-ca58-ac36b7c503a6@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/10/2017 10:54 AM, Alistair Popple wrote:
> The patch to introduce address translation services for Nvlink2 uses
> MMU notifiers. However usage of MMU notifiers requires a Kconfig
> option which is not selected by default on powerpc so add it to the
> powernv Kconfig.

We would also need this for HMM enablement on powerpc going forward.
