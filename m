Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgqvj668XzDql5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 18:53:53 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u618nFV1090824
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 04:53:52 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23wajet4bc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Jul 2016 04:53:51 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Fri, 1 Jul 2016 09:53:49 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2062217D805F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 09:55:08 +0100 (BST)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u618rkRE3604912
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 08:53:46 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u617rmuu000377
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 01:53:49 -0600
Subject: Re: [PATCH] cxl: Ignore CAPI adapters misplaced in switched slots
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <1467287137-25366-1-git-send-email-felix@linux.vnet.ibm.com>
Cc: mikey@neuling.org, imunsie@au1.ibm.com, tgrobeck@us.ibm.com
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Fri, 1 Jul 2016 10:53:45 +0200
MIME-Version: 1.0
In-Reply-To: <1467287137-25366-1-git-send-email-felix@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <57762F99.3080904@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Salut Philippe,

Le 30/06/2016 13:45, Philippe Bergheaud a écrit :
> +	if (cxl_slot_is_switched(dev)) {
> +		dev_dbg(&dev->dev, "cxl_init_adapter: Ignoring switched slot device\n");
> +		return -ENODEV;
> +	}


I think it would be useful for the user who has inserted the card in the 
wrong slot to be notified, i.e. raise the level of the message. 
Otherwise he would be wondering why the card is not recognized.

   Fred
