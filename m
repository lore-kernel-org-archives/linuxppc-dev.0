Return-Path: <minyard@acm.org>
Received: from mta1.adelphia.net (mta1.adelphia.net [68.168.78.175])
	by ozlabs.org (Postfix) with ESMTP id 7608767BCE
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Dec 2006 04:30:12 +1100 (EST)
Message-ID: <45799EBC.5060003@acm.org>
Date: Fri, 08 Dec 2006 11:19:56 -0600
From: Corey Minyard <minyard@acm.org>
MIME-Version: 1.0
To: Christian Krafft <krafft@de.ibm.com>
Subject: Re: [Openipmi-developer] [patch 1/1] ipmi: add autosensing of ipmi
	device on powerpc using device-tree
References: <20061207172259.64168f8c@localhost>
	<20061207172445.2108cf43@localhost>
In-Reply-To: <20061207172445.2108cf43@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, openipmi-developer@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ok, patch is in my tree with some minor changes required due to other 
changes that have gone in since 2.6.19.

Christian Krafft wrote:
> +};
> +
> +static void __devinit of_find_bmc(void)
> +{
> +	of_register_platform_driver(&ipmi_of_platform_driver);
> +}
> +#endif /* CONFIG_PM_OF */
>   
I took the liberty of changing this to "CONFIG_PPC_OF"
