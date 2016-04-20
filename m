Return-Path: <manoj@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqpzJ1rPWzDqZT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 03:39:23 +1000 (AEST)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <manoj@linux.vnet.ibm.com>;
 Wed, 20 Apr 2016 11:39:21 -0600
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 2CB413E4003B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 11:39:20 -0600 (MDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3KHdJFB40042726
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 17:39:19 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3KHdIVo005319
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 13:39:19 -0400
Reply-To: manoj@linux.vnet.ibm.com
Subject: Re: [PATCH] cxl: Increase timeout for detection of AFU mmio hang
References: <1461083664-12283-1-git-send-email-fbarrat@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, imunsie@au1.ibm.com,
 mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
From: Manoj Kumar <manoj@linux.vnet.ibm.com>
Message-ID: <5717BEDB.5090903@linux.vnet.ibm.com>
Date: Wed, 20 Apr 2016 12:39:39 -0500
MIME-Version: 1.0
In-Reply-To: <1461083664-12283-1-git-send-email-fbarrat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Tested-by: Manoj Kumar <manoj@linux.vnet.ibm.com>

On 4/19/2016 11:34 AM, Frederic Barrat wrote:
> PSL designers recommend a larger value for the mmio hang pulse, 256 us
> instead of 1 us. The CAIA architecture states that it needs to be
> smaller than 1/2 of the RTOS timeout set in the PHB for outbound
> non-posted transactions, which is still (easily) the case here.
>
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> ---
> Needs to be applied on top of http://patchwork.ozlabs.org/patch/604029/
