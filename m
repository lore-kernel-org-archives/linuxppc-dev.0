Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcP3h73rszDqgD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 07:35:12 +1000 (AEST)
Date: Tue, 22 Aug 2017 14:35:10 -0700 (PDT)
Message-Id: <20170822.143510.1048652578169181274.davem@davemloft.net>
To: madalin.bucur@nxp.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] fsl/fman: enable FMan Keygen
From: David Miller <davem@davemloft.net>
In-Reply-To: <1503423066-15420-2-git-send-email-madalin.bucur@nxp.com>
References: <1503423066-15420-1-git-send-email-madalin.bucur@nxp.com>
 <1503423066-15420-2-git-send-email-madalin.bucur@nxp.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Madalin Bucur <madalin.bucur@nxp.com>
Date: Tue, 22 Aug 2017 20:31:01 +0300

>  /**
> + * fman_get_keygen
> + *
> + * @fman:	A Pointer to FMan device
> + *
> + * Get the handle to KeyGen module part of FM driver
> + *
> + * Return: Handle to KeyGen
> + */
> +struct fman_keygen *fman_get_keygen(struct fman *fman)
> +{
> +	return fman->keygen;
> +}
> +EXPORT_SYMBOL(fman_get_keygen);

Please don't do this.

Just directly derefence the pointer in the source code to
get the keygen.

Thank you.
