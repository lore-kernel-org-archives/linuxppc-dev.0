Return-Path: <manoj@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B93791A0CD1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 06:17:52 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <manoj@linux.vnet.ibm.com>;
 Tue, 23 Feb 2016 12:17:50 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 03C3D1FF0026
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 12:05:57 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1NJHlHt27984016
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 12:17:47 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1NJHlDh011389
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 12:17:47 -0700
Received: from [9.41.250.246] (manoj.austin.ibm.com [9.41.250.246])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u1NJHkBt011372
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 12:17:47 -0700
Reply-To: manoj@linux.vnet.ibm.com
Subject: Re: [PATCH v5 09/18] cxl: New possible return value from hcall
References: <1456244519-18934-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1456244519-18934-10-git-send-email-fbarrat@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
From: Manoj Kumar <manoj@linux.vnet.ibm.com>
Message-ID: <56CCB070.6030603@linux.vnet.ibm.com>
Date: Tue, 23 Feb 2016 13:18:08 -0600
MIME-Version: 1.0
In-Reply-To: <1456244519-18934-10-git-send-email-fbarrat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reviewed-by: Manoj Kumar <manoj@linux.vnet.ibm.com>

---
Manoj Kumar

On 2/23/2016 10:21 AM, Frederic Barrat wrote:
> From: Christophe Lombard <clombard@linux.vnet.ibm.com>
>
> The hcalls introduced for cxl use a possible new value:
> H_STATE (invalid state).
>
> Co-authored-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>
> ---
>   arch/powerpc/include/asm/hvcall.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
> index e3b54dd..0bc9c28 100644
> --- a/arch/powerpc/include/asm/hvcall.h
> +++ b/arch/powerpc/include/asm/hvcall.h
> @@ -94,6 +94,7 @@
>   #define H_SG_LIST	-72
>   #define H_OP_MODE	-73
>   #define H_COP_HW	-74
> +#define H_STATE		-75
>   #define H_UNSUPPORTED_FLAG_START	-256
>   #define H_UNSUPPORTED_FLAG_END		-511
>   #define H_MULTI_THREADS_ACTIVE	-9005
>
