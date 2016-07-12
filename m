Return-Path: <stewart@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpXj641RXzDqDT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 16:52:58 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rpXj56x6cz9s9Z
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jul 2016 16:52:57 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6C6n8JI079642
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jul 2016 02:52:55 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 243etye8br-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jul 2016 02:52:55 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 12 Jul 2016 02:52:54 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 01/14] powerpc/powernv: Add XICS emulation APIs
In-Reply-To: <1467959838-6900-1-git-send-email-benh@kernel.crashing.org>
References: <1467959838-6900-1-git-send-email-benh@kernel.crashing.org>
Date: Tue, 12 Jul 2016 16:52:46 +1000
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87oa63qrep.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> OPAL provides an emulated XICS interrupt controller to
> use as a fallback on newer processors that don't have a
> XICS. It's meant as a way to provide backward compatibility
> with future processors. Add the corresponding interfaces.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

These OPAL calls have the correct OPAL API numbers and they've been
assigned upstream in skiboot.

Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>

-- 
Stewart Smith
OPAL Architect, IBM.
