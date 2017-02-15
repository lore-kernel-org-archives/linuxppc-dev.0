Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNRz74hNbzDqCr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 16:04:19 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1F53ZNB105954
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 00:04:17 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28mbtq0myh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 00:04:16 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 14 Feb 2017 22:04:16 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 498503E40044
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 22:04:13 -0700 (MST)
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Mukesh Ojha <mukesh02@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Mukesh Ojha <mukesh02@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/powernv/opal-dump : Handles opal_dump_info
 properly
In-Reply-To: <1480583289-6380-1-git-send-email-mukesh02@linux.vnet.ibm.com>
References: <1480583289-6380-1-git-send-email-mukesh02@linux.vnet.ibm.com>
Date: Wed, 15 Feb 2017 16:04:09 +1100
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <877f4s9h9y.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mukesh Ojha <mukesh02@linux.vnet.ibm.com> writes:
> Moves the return value check of 'opal_dump_info' to a proper place which
> was previously unnecessarily filling all the dump info even on failure.
>
> Signed-off-by: Mukesh Ojha <mukesh02@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/opal-dump.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)


Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>

-- 
Stewart Smith
OPAL Architect, IBM.
