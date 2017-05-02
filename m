Return-Path: <srs0=d2lv=4i=linux.vnet.ibm.com=vaibhav@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wH4xb17pDzDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 May 2017 12:29:39 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wH4xZ73MGz8sxs
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 May 2017 12:29:38 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wH4xZ31K5z9sNG
 for <linuxppc-dev@ozlabs.org>; Tue,  2 May 2017 12:29:37 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v422DZor075982
 for <linuxppc-dev@ozlabs.org>; Mon, 1 May 2017 22:29:27 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2a6gn6spaj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 01 May 2017 22:29:27 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Tue, 2 May 2017 12:29:24 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v422TCE37078334
 for <linuxppc-dev@ozlabs.org>; Tue, 2 May 2017 12:29:20 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v422Sgvd000918
 for <linuxppc-dev@ozlabs.org>; Tue, 2 May 2017 12:28:42 +1000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@ozlabs.org
Cc: frederic.barrat@fr.ibm.com, andrew.donnellan@au1.ibm.com,
 "Alastair D'Silva" <alastair@d-silva.org>
Subject: Re: [PATCH v4] cxl: mask slice error interrupts after first occurrence
In-Reply-To: <20170501005331.20131-3-alastair@au1.ibm.com>
References: <20170501005331.20131-3-alastair@au1.ibm.com>
Date: Tue, 02 May 2017 07:58:21 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87vapkj8l6.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Thanks for upadating the patch with review comments Alastair.

Alastair D'Silva <alastair@au1.ibm.com> writes:

> From: Alastair D'Silva <alastair@d-silva.org>
>
> In some situations, a faulty AFU slice may create an interrupt storm of
> slice errors, rendering the machine unusable. Since these interrupts are
> informational only, present the interrupt once, then mask it off to
> prevent it from being retriggered until the AFU is reset.
>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---

Reviewed-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
