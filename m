Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0BB281A001E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 14:13:04 +1000 (AEST)
Message-ID: <1438920783.16275.0.camel@neuling.org>
Subject: Re: [PATCH 1/4] cxl: Compile with -Werror
From: Michael Neuling <mikey@neuling.org>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
 imunsie@au.ibm.com
Date: Fri, 07 Aug 2015 14:13:03 +1000
In-Reply-To: <1438917500-12100-1-git-send-email-dja@axtens.net>
References: <1438917500-12100-1-git-send-email-dja@axtens.net>
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

On Fri, 2015-08-07 at 13:18 +1000, Daniel Axtens wrote:
> It's a good idea, and it brings us in line with the rest of arch/powerpc.
>=20
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Acked-by: Michael Neuling <mikey@neuling.org>

> ---
>  drivers/misc/cxl/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/misc/cxl/Makefile b/drivers/misc/cxl/Makefile
> index 14e3f8219a11..6f484dfe78f9 100644
> --- a/drivers/misc/cxl/Makefile
> +++ b/drivers/misc/cxl/Makefile
> @@ -1,3 +1,5 @@
> +ccflags-y :=3D -Werror
> +
>  cxl-y				+=3D main.o file.o irq.o fault.o native.o
>  cxl-y				+=3D context.o sysfs.o debugfs.o pci.o trace.o
>  cxl-y				+=3D vphb.o api.o
