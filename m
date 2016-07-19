Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rthdF6Sh5zDqN5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 11:04:01 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: alastair@au1.ibm.com
Cc: benh@kernel.crashing.org, paulus@samba.org, herbert@gondor.apana.org.au,
 davem@davemloft.net, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alastair D'Silva <alastair@d-silva.org>
Subject: Re: [PATCH 1/2] powerpc: Add module autoloading based on CPU features
In-Reply-To: <1468388840-12068-3-git-send-email-alastair@au1.ibm.com>
References: <1468388840-12068-1-git-send-email-alastair@au1.ibm.com>
 <1468388840-12068-3-git-send-email-alastair@au1.ibm.com>
Date: Tue, 19 Jul 2016 11:04:01 +1000
Message-ID: <87d1maphfi.fsf@@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

alastair@au1.ibm.com writes:

> diff --git a/arch/powerpc/include/asm/cpufeature.h b/arch/powerpc/include/asm/cpufeature.h
> new file mode 100644
> index 0000000..df31627
> --- /dev/null
> +++ b/arch/powerpc/include/asm/cpufeature.h
> @@ -0,0 +1,70 @@
> +/* CPU feature definitions for module loading, used by
> + * module_cpu_feature_match(), see asm/cputable.h for powerpc CPU features
> + *
> + * Copyright 2016 Alastair D'Silva, IBM Corporation.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#ifndef __ASM_CPUFEATURE_H
> +#define __ASM_POWERPC_CPUFEATURE_H

Those should match. The latter is preferred.

cheers
