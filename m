Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DA4F11A0C34
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 07:06:40 +1100 (AEDT)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 14 Jan 2015 15:06:37 -0500
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 053706E8045
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jan 2015 14:58:28 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0EK6Yu329687934
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jan 2015 20:06:34 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0EK6YVb028660
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jan 2015 15:06:34 -0500
Message-ID: <54B6CC48.70205@linux.vnet.ibm.com>
Date: Wed, 14 Jan 2015 14:06:32 -0600
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/2] MAINTAINERS: ibmvscsi driver maintainer change
References: <1421109095-18613-1-git-send-email-tyreld@linux.vnet.ibm.com>
In-Reply-To: <1421109095-18613-1-git-send-email-tyreld@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Cc: brking@linux.vnet.ibm.com, linux-kernel@vger.linux.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/12/2015 06:31 PM, Tyrel Datwyler wrote:
> Change maintainer of ibmvscsi driver to Tyrel Datwyler.
> 
> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> Cc: Brian King <brking@linux.vnet.ibm.com>

Acked-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 79b2e4b..a646b94 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4754,7 +4754,7 @@ S:	Supported
>  F:	drivers/net/ethernet/ibm/ibmveth.*
>  
>  IBM Power Virtual SCSI Device Drivers
> -M:	Nathan Fontenot <nfont@linux.vnet.ibm.com>
> +M:	Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
>  L:	linux-scsi@vger.kernel.org
>  S:	Supported
>  F:	drivers/scsi/ibmvscsi/ibmvscsi*
> 
