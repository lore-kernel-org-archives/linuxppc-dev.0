Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C8519B7DEE
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Feb 2010 17:15:16 +1100 (EST)
Subject: Re: [PATCH 9/9] of: remove undefined request_OF_resource &
	release_OF_resource
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20100213160314.4767.93924.stgit@angua>
References: <20100213154838.4767.83881.stgit@angua>
	<20100213160314.4767.93924.stgit@angua>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 14 Feb 2010 17:14:57 +1100
Message-ID: <1266128097.16346.67.camel@pasglop>
Mime-Version: 1.0
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	sparclinux@vger.kernel.org, jeremy.kerr@canonical.com, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2010-02-13 at 09:03 -0700, Grant Likely wrote:
> Neither request_OF_resource or release_OF_resource are defined
> anywhere.  Remove the declarations.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

>  arch/microblaze/include/asm/prom.h |    4 ----
>  arch/powerpc/include/asm/prom.h    |    5 -----
>  2 files changed, 0 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/microblaze/include/asm/prom.h b/arch/microblaze/include/asm/prom.h
> index aa1a437..03f45a9 100644
> --- a/arch/microblaze/include/asm/prom.h
> +++ b/arch/microblaze/include/asm/prom.h
> @@ -31,10 +31,6 @@
>  /* Other Prototypes */
>  extern int early_uartlite_console(void);
>  
> -extern struct resource *request_OF_resource(struct device_node *node,
> -				int index, const char *name_postfix);
> -extern int release_OF_resource(struct device_node *node, int index);
> -
>  /*
>   * OF address retreival & translation
>   */
> diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
> index 7f9a50a..ddd408a 100644
> --- a/arch/powerpc/include/asm/prom.h
> +++ b/arch/powerpc/include/asm/prom.h
> @@ -39,11 +39,6 @@ extern struct device_node* pci_device_to_OF_node(struct pci_dev *);
>  extern void pci_create_OF_bus_map(void);
>  #endif
>  
> -extern struct resource *request_OF_resource(struct device_node* node,
> -				int index, const char* name_postfix);
> -extern int release_OF_resource(struct device_node* node, int index);
> -
> -
>  /*
>   * OF address retreival & translation
>   */
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
