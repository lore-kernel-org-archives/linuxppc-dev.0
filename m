Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BFB41DDE0E
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 12:42:15 +1100 (EST)
In-Reply-To: <20071105032802.GA16613@lixom.net>
References: <20071105032802.GA16613@lixom.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <cd9a9e67893406e486d2ffc7599e28b7@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] pasemi: Broaden specific references to 1682M
Date: Tue, 6 Nov 2007 02:42:08 +0100
To: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, Doug Thompson <dougthompson@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Olof,

Nice cleanup!  One minor thing...

>  static struct of_device_id pasemi_bus_ids[] = {
> +	/* Unfortunately needed for legacy firmwares */
>  	{ .type = "localbus", },
>  	{ .type = "sdc", },
> +	{ .compatible = "pasemi,localbus", },
> +	{ .compatible = "pasemi,sdc", },

The new comment is for the device_type entries only, right?  You
might want to make that more clear.


Segher
