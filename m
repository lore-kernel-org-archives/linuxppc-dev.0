Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 458751A039E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Oct 2014 11:01:11 +1100 (AEDT)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 17 Oct 2014 18:01:07 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 3822E3E4003D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Oct 2014 18:01:05 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9I0133r43516138
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Oct 2014 02:01:04 +0200
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9I0136d002636
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Oct 2014 18:01:03 -0600
Message-ID: <5441ADBA.1070800@linux.vnet.ibm.com>
Date: Fri, 17 Oct 2014 19:00:58 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Dan Streetman <ddstreet@ieee.org>, Michael Ellerman <mpe@ellerman.id.au>,
 benh@kernel.crashing.org
Subject: Re: [PATCH] MAINTAINERS: nx-842 driver maintainer change
References: <1413587999-12684-1-git-send-email-ddstreet@ieee.org>
In-Reply-To: <1413587999-12684-1-git-send-email-ddstreet@ieee.org>
Content-Type: text/plain; charset=windows-1252
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/17/2014 06:19 PM, Dan Streetman wrote:
> Change maintainer of nx-842 compression coprocessor driver
> to Dan Streetman.
> 
> Signed-off-by: Dan Streetman <ddstreet@ieee.org>
> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Acked-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b0f17d5..3cc3e41 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4605,7 +4605,7 @@ S:	Supported
>  F:	drivers/crypto/nx/
> 
>  IBM Power 842 compression accelerator
> -M:	Nathan Fontenot <nfont@linux.vnet.ibm.com>
> +M:	Dan Streetman <ddstreet@us.ibm.com>
>  S:	Supported
>  F:	drivers/crypto/nx/nx-842.c
>  F:	include/linux/nx842.h
> 
