Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zhm1R11DlzF11V
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 17:03:54 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1F602Pk014186
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 01:03:51 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g4xb8b5pb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 01:03:51 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Thu, 15 Feb 2018 06:03:49 -0000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@linux.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
Subject: Re: [PATCH] cxl: Remove function write_timebase_ctrl_psl9() for PSL9
In-Reply-To: <17a1d3c8-c38d-0134-9463-4eebf1eced70@linux.vnet.ibm.com>
References: <20180209041009.14456-1-vaibhav@linux.vnet.ibm.com>
 <17a1d3c8-c38d-0134-9463-4eebf1eced70@linux.vnet.ibm.com>
Date: Thu, 15 Feb 2018 11:33:42 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87fu62x001.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:

> The code change looks ok, but am I the only one to think the commit 
> message doesn't match? The enable bit has always been in the PSL_CONTROL 
> register, it was just badly documented on p8. What's been removed is 
> much of the configuration found in PSL_TB_CTLSTAT.
>
Thanks for pointing this out Fred. I wrongly assumed looking at the PSL8
implementation that writing to the PSL_TV_CTLSTAT regiser enabled the
TB. I will update the patch description and resend the patch.

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
