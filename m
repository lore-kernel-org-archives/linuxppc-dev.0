Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rjtgV6VHpzDqnw
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 03:05:26 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u64H4Vp6114464
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2016 13:05:23 -0400
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23x9rkuefh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Jul 2016 13:05:23 -0400
Received: from localhost
 by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Mon, 4 Jul 2016 18:05:22 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2C3801B0805F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 18:06:37 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u64H5JUj5308880
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2016 17:05:19 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u64H5I81006606
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2016 11:05:19 -0600
Subject: Re: [PATCH v2] cxl: Refine slice error debug messages
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <1467644856-762-1-git-send-email-felix@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, imunsie@au1.ibm.com, mikey@neuling.org
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Mon, 4 Jul 2016 19:05:17 +0200
MIME-Version: 1.0
In-Reply-To: <1467644856-762-1-git-send-email-felix@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <577A974D.3000404@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 04/07/2016 17:07, Philippe Bergheaud a écrit :
> Signed-off-by: Philippe Bergheaud<felix@linux.vnet.ibm.com>
> ---
> Changes since v1:
>    - Rebased on Ian's patch
>      "cxl: Abstract the differences between the PSL and XSL"

Thanks!

Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
