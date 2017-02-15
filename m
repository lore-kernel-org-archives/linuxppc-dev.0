Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNS4M6jw1zDqCr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 16:08:51 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1F58mJm049978
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 00:08:50 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28kk8pua2c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 00:08:49 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 14 Feb 2017 22:08:42 -0700
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 37CD91FF001E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 22:08:17 -0700 (MST)
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Mukesh Ojha <mukesh02@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Mukesh Ojha <mukesh02@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] powerpc/powernv/opal-dump : Use IRQ_HANDLED instead
 of numbers in interrupt handler
In-Reply-To: <1480583289-6380-2-git-send-email-mukesh02@linux.vnet.ibm.com>
References: <1480583289-6380-1-git-send-email-mukesh02@linux.vnet.ibm.com>
 <1480583289-6380-2-git-send-email-mukesh02@linux.vnet.ibm.com>
Date: Wed, 15 Feb 2017 16:08:34 +1100
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <874lzw9h2l.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mukesh Ojha <mukesh02@linux.vnet.ibm.com> writes:

> Converts all the return explicit number to a more proper IRQ_HANDLED,
> which looks proper incase of interrupt handler returning case.
>
> Signed-off-by: Mukesh Ojha <mukesh02@linux.vnet.ibm.com>
> Reviewed-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/opal-dump.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Should also have:
Fixes: 8034f715f ("powernv/opal-dump: Convert to irq domain")

?

-- 
Stewart Smith
OPAL Architect, IBM.
