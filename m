Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z2J2r4P59zF0B9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Dec 2017 15:05:40 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBL45A3V066238
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 23:05:38 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2f03t9cj7b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 23:05:37 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Thu, 21 Dec 2017 04:05:35 -0000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] cxl: Check if vphb exists before iterating over AFU
 devices
In-Reply-To: <20171220170307.GA31793@kroah.com>
References: <20171220093706.16217-1-vaibhav@linux.vnet.ibm.com>
 <20171220170307.GA31793@kroah.com>
Date: Thu, 21 Dec 2017 09:35:26 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87efnoraih.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Greg KH <greg@kroah.com> writes:

> On Wed, Dec 20, 2017 at 03:07:06PM +0530, Vaibhav Jain wrote:
>> commit 12841f87b7a8ceb3d54f171660f72a86941bfcb3 upstream, for 4.9.
>
> Thanks, do we also need this for 4.4?  If so, can you provide a
> backport?
>
Thanks Greg for applying this patch on 4.9 stable tree. I have done a
back-port for 4.3+ and will send the back-ported-patch across.

Cheers,
-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
