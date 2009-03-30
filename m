Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DACBCDDE1B
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 00:51:44 +1100 (EST)
Message-Id: <7E26E694-85F8-445F-9113-88DCD61BC32C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1238383506.17330.0.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: Build error
Date: Mon, 30 Mar 2009 08:51:38 -0500
References: <1238383506.17330.0.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 29, 2009, at 10:25 PM, Benjamin Herrenschmidt wrote:

> My next branch (after merging from you):
>
> ERROR: "fsl_pq_mdio_bus_name" [drivers/net/gianfar_driver.ko]  
> undefined!
>
> I'll ask Linus to pull anyway though.
>
> Cheers,
> Ben.

I believe this is fixed in net-next (and possible linus has already  
pulled that in.)

- k
