Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 738061A0598
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 06:28:15 +1100 (AEDT)
Message-ID: <1456255694.29555.21.camel@neuling.org>
Subject: Re: [PATCH v5 09/18] cxl: New possible return value from hcall
From: Michael Neuling <mikey@neuling.org>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, ian@ozlabs.au.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Date: Tue, 23 Feb 2016 13:28:14 -0600
In-Reply-To: <1456244519-18934-10-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1456244519-18934-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1456244519-18934-10-git-send-email-fbarrat@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-02-23 at 17:21 +0100, Frederic Barrat wrote:
> From: Christophe Lombard <clombard@linux.vnet.ibm.com>
>=20
> The hcalls introduced for cxl use a possible new value:
> H_STATE (invalid state).

FWIW, this patch subject be powerpc: not cxl:=20


> Co-authored-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>
> ---
>  arch/powerpc/include/asm/hvcall.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/powerpc/include/asm/hvcall.h
> b/arch/powerpc/include/asm/hvcall.h
> index e3b54dd..0bc9c28 100644
> --- a/arch/powerpc/include/asm/hvcall.h
> +++ b/arch/powerpc/include/asm/hvcall.h
> @@ -94,6 +94,7 @@
>  #define H_SG_LIST	-72
>  #define H_OP_MODE	-73
>  #define H_COP_HW	-74
> +#define H_STATE		-75
>  #define H_UNSUPPORTED_FLAG_START	-256
>  #define H_UNSUPPORTED_FLAG_END		-511
>  #define H_MULTI_THREADS_ACTIVE	-9005
