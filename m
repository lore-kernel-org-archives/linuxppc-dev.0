Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpLxV4FNczDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 18:32:46 +1000 (AEST)
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Mon, 18 Apr 2016 09:32:41 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 72D921B08069
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 09:32:56 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3I8WCeR917842
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 08:32:12 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3I8WBnQ013553
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 02:32:12 -0600
Subject: Re: [PATCH] cxl: static-ify variables to fix sparse warnings
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <1460955830-27267-1-git-send-email-andrew.donnellan@au1.ibm.com>
Cc: imunsie@au1.ibm.com, clombard@linux.vnet.ibm.com
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Message-ID: <57149B8A.3080806@linux.vnet.ibm.com>
Date: Mon, 18 Apr 2016 10:32:10 +0200
MIME-Version: 1.0
In-Reply-To: <1460955830-27267-1-git-send-email-andrew.donnellan@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Thanks Andrew!

Reviewed-by: fbarrat@linux.vnet.ibm.com

  Fred


Le 18/04/2016 07:03, Andrew Donnellan a écrit :
> Make a couple more variables static. Found by sparse.
>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> ---
>   drivers/misc/cxl/flash.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/misc/cxl/flash.c b/drivers/misc/cxl/flash.c
> index 68dd0b7..c63d61e 100644
> --- a/drivers/misc/cxl/flash.c
> +++ b/drivers/misc/cxl/flash.c
> @@ -24,8 +24,8 @@ struct ai_header {
>   };
>
>   static struct semaphore sem;
> -unsigned long *buffer[CXL_AI_MAX_ENTRIES];
> -struct sg_list *le;
> +static unsigned long *buffer[CXL_AI_MAX_ENTRIES];
> +static struct sg_list *le;
>   static u64 continue_token;
>   static unsigned int transfer;
>
>
