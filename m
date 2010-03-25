Return-Path: <jgunthorpe@obsidianresearch.com>
Received: from quartz.orcorp.ca (quartz.orcorp.ca [139.142.54.143])
	by ozlabs.org (Postfix) with ESMTP id 17825B7C98
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Mar 2010 16:23:38 +1100 (EST)
Date: Wed, 24 Mar 2010 23:23:28 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Rajiv Andrade <srajiv@linux.vnet.ibm.com>
Subject: Re: [tpmdd-devel] [PATCH] TPM: Provide a tpm_tis OF driver
Message-ID: <20100325052328.GB9769@obsidianresearch.com>
References: <20100309200135.GF30462@obsidianresearch.com>
	<1269490841.12676.32.camel@blackbox.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1269490841.12676.32.camel@blackbox.ibm.com>
Cc: linuxppc-dev@ozlabs.org, tpmdd-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 25, 2010 at 01:20:41AM -0300, Rajiv Andrade wrote:

> Why not 
> 
> +#ifdef CONFIG_OF
> +	return of_register_platform_driver(&tis_of_driver);
> +#elif CONFIG_PNP
> +	return pnp_register_driver(&tis_pnp_driver);
> +#endif
> 
> ?

AFAIK they are not exclusive options? I can't imagine anyone building
a kernel with both, but the rest of the patch is designed to allow
both at once..

> Acked-by: Rajiv Andrade <srajiv@linux.vnet.ibm.com>

Thanks - who can pick this up to feed it upstream?

Jason
