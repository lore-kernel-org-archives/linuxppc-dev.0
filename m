Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0104.outbound.protection.outlook.com [157.56.110.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0501A1A0368
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2015 11:59:24 +1000 (AEST)
Message-ID: <1435283949.4306.16.camel@freescale.com>
Subject: Re: [v2,4/9] fsl/fman: Add FMan MURAM support
From: Scott Wood <scottwood@freescale.com>
To: igal.liberman@freescale.com
CC: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 madalin.bucur@freescale.com, pebolle@tiscali.nl
Date: Thu, 25 Jun 2015 20:59:09 -0500
In-Reply-To: <1435174496-7472-1-git-send-email-igal.liberman@freescale.com>
References: <1435174496-7472-1-git-send-email-igal.liberman@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-06-24 at 22:34 +0300, igal.liberman@freescale.com wrote:
> +     struct muram_info *p_muram;

No Hungarian notation.

> +void fm_muram_free(struct muram_info *p_muram)
> +{
> +     /* Destroy pool */
> +     gen_pool_destroy(p_muram->pool);
> +     /* Unmap memory */
> +     iounmap(p_muram->vbase);
> +     /* Free pointer */
> +     kfree(p_muram);
> +}

This type of commenting is not useful.

> +     memset_io((void __iomem *)vaddr, 0, (int)size);

Unnecessary cast of size.

-Scott
