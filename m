Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3B7D12C015F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 10:40:25 +1000 (EST)
Message-ID: <1366677610.2886.8.camel@pasglop>
Subject: Re: [PATCH] powerpc/rtas_flash: New return code to indicate FW
 entitlement expiry
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Date: Tue, 23 Apr 2013 10:40:10 +1000
In-Reply-To: <20130419114410.19115.35846.stgit@hegdevasant>
References: <20130419114410.19115.35846.stgit@hegdevasant>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-04-19 at 17:14 +0530, Vasant Hegde wrote:
> Add new return code to rtas_flash to indicate firmware entitlement
> expiry. This will be used by the update_flash script to return
> appropriate message to the user.

What's the point of that patch ? It adds a definition to a private .c
file not exposed to user space and doesn't do anything with it ...

Ben.

> Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/rtas_flash.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/kernel/rtas_flash.c b/arch/powerpc/kernel/rtas_flash.c
> index a7020d2..0a12c16 100644
> --- a/arch/powerpc/kernel/rtas_flash.c
> +++ b/arch/powerpc/kernel/rtas_flash.c
> @@ -64,6 +64,7 @@
>  #define VALIDATE_TMP_COMMIT_DL 4     /* Validate Return Status */
>  #define VALIDATE_TMP_COMMIT    5     /* Validate Return Status */
>  #define VALIDATE_TMP_UPDATE_DL 6     /* Validate Return Status */
> +#define VALIDATE_OUT_OF_WRNTY  7     /* Validate Return Status */
>  
>  /* ibm,manage-flash-image operation tokens */
>  #define RTAS_REJECT_TMP_IMG   0
