Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qWf976v8PzDqJs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Mar 2016 21:06:51 +1100 (AEDT)
In-Reply-To: <1458145736-20326-1-git-send-email-felix@linux.vnet.ibm.com>
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Philippe Bergheaud <felix@linux.vnet.ibm.com>, mikey@neuling.org,
 imunsie@au1.ibm.com
Subject: Re: [v2,1/2] powerpc: Define PVR value for POWER8NVL processor
Message-Id: <3qWf975ZFgz9sDG@ozlabs.org>
Date: Fri, 25 Mar 2016 21:06:51 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-16-03 at 16:28:55 UTC, Philippe Bergheaud wrote:
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index c4cb2ff..6a6de4a 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -1174,6 +1174,7 @@
>  #define PVR_970GX	0x0045
>  #define PVR_POWER7p	0x004A
>  #define PVR_POWER8E	0x004B
> +#define PVR_POWER8NVL	0x004C
>  #define PVR_POWER8	0x004D
>  #define PVR_BE		0x0070
>  #define PVR_PA6T	0x0090

Oh wow, we have those defined separately to the cputable. That is "special" :/

Not your fault though.

cheers
