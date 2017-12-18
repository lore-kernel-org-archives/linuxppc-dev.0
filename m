Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0046.hostedemail.com
 [216.40.44.46])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0m7R436QzDqXn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 03:04:18 +1100 (AEDT)
Message-ID: <1513613052.31581.84.camel@perches.com>
Subject: Re: [PATCH 13/13] ocxl: add MAINTAINERS entry
From: Joe Perches <joe@perches.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, mpe@ellerman.id.au,
 andrew.donnellan@au1.ibm.com, alastair@au1.ibm.com
Date: Mon, 18 Dec 2017 08:04:12 -0800
In-Reply-To: <44bdca7f352748a658840889d6e6f52561b4a987.1513608243.git.fbarrat@linux.vnet.ibm.com>
References: <cover.1513608243.git.fbarrat@linux.vnet.ibm.com>
 <44bdca7f352748a658840889d6e6f52561b4a987.1513608243.git.fbarrat@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-12-18 at 16:21 +0100, Frederic Barrat wrote:
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> ---
>  MAINTAINERS | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a6e86e20761e..edc9e1db352b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3919,6 +3919,18 @@ F:	drivers/scsi/cxlflash/
>  F:	include/uapi/scsi/cxlflash_ioctls.h
>  F:	Documentation/powerpc/cxlflash.txt
>  
> +OCXL (Open Coherent Accelerator Processor Interface OpenCAPI) DRIVER
> +M:	Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> +M:	Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> +L:	linuxppc-dev@lists.ozlabs.org
> +S:	Supported
> +F:	arch/powerpc/platforms/powernv/ocxl.c
> +F:	arch/powerpc/include/asm/pnv-ocxl.h
> +F:	drivers/misc/ocxl/
> +F:	include/misc/ocxl*
> +F:	include/uapi/misc/ocxl.h
> +F:	Documentation/accelerators/ocxl.txt
> +

Alphabetic ordering by section header please...

Maybe CXL - OCXL ...

>  CYBERPRO FB DRIVER
>  M:	Russell King <linux@armlinux.org.uk>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
