Return-Path: <domen.puncer@telargo.com>
Received: from out001.atlarge.net (out001.atlarge.net [129.41.63.69])
	by ozlabs.org (Postfix) with ESMTP id BD159DDE44
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 18:43:46 +1000 (EST)
Date: Wed, 29 Aug 2007 10:43:41 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: Document and implement an improved flash device binding
Message-ID: <20070829084341.GS13994@moe.telargo.com>
References: <20070829061300.GF3206@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070829061300.GF3206@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 29/08/07 16:13 +1000, David Gibson wrote:

<snip>
>  static int __devinit of_physmap_probe(struct of_device *dev, const struct of_device_id *match)
>  {
>  	struct device_node *dp = dev->node;
>  	struct resource res;
>  	struct physmap_flash_info *info;
> -	const char **probe_type;
> -	const char *of_probe;
> +	const char *probe_type = (const char *)match->data;
>  	const u32 *width;
>  	int err;
>  
> +	dev_warn(&dev->dev, "Device tree uses obsolete \"direct-mapped\" "
> +		 "flash binding\n");

This is printed for new binding too :-)

Other than this, it works fine for me.


	Domen
