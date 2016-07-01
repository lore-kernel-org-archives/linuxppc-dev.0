Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgzB01ssbzDqhC
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jul 2016 00:21:43 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u61EIuW5044052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 10:21:41 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23wbbbu20w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Jul 2016 10:21:41 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Fri, 1 Jul 2016 15:21:39 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 17EB2219005F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 15:21:06 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u61ELaVa48955584
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 14:21:36 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u61ELXhq021285
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 08:21:35 -0600
Subject: Re: [PATCH v2] cxl: Ignore CAPI adapters misplaced in switched slots
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <1467372772-9422-1-git-send-email-felix@linux.vnet.ibm.com>
Cc: mikey@neuling.org, tgrobeck@us.ibm.com, imunsie@au1.ibm.com
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Fri, 1 Jul 2016 16:21:30 +0200
MIME-Version: 1.0
In-Reply-To: <1467372772-9422-1-git-send-email-felix@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <57767C6A.6090408@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 01/07/2016 13:32, Philippe Bergheaud a écrit :
> One should not attempt to switch a PHB into CAPI mode if there is
> a switch between the PHB and the adapter. This patch modifies the
> cxl driver to ignore CAPI adapters misplaced in switched slots.
>
> Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
> ---
> This patch fixes Bz 142217.
>
> Changes since v1:
>    - As suggested by Fred, tell user that CAPI adapter is misplaced
>      s/dev_dbg/dev_info/

Thanks!

Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
