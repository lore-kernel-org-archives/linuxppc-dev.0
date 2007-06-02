Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070601232022.GA21237@mag.az.mvista.com>
References: <20070601232022.GA21237@mag.az.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5ad8e3f3f79ecc1f3000eaa2da6e5fd0@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
Date: Sat, 2 Jun 2007 10:46:41 +0200
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +static int __init prpmc2800_register_mtd(void)
> +{
> +	struct device_node *np;
> +
> +	np = of_find_compatible_node(NULL, "rom", "direct-mapped");
> +	of_platform_device_create(np, np->name, NULL);
> +}

Needs error checking -- what if the node doesn't exist.


Segher
