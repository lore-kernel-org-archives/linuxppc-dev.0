Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6B14EDDE98
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Sep 2008 11:39:05 +1000 (EST)
Message-Id: <99055FC9-255A-4ECF-863B-3CDB6589ED9E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Peter Korsgaard <jacmet@sunsite.dk>
In-Reply-To: <1222026361-28133-1-git-send-email-jacmet@sunsite.dk>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH v2] powerpc: gpio driver for mpc8349/8572/8610 and
	compatible
Date: Sun, 21 Sep 2008 20:38:58 -0500
References: <1222026361-28133-1-git-send-email-jacmet@sunsite.dk>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 21, 2008, at 2:46 PM, Peter Korsgaard wrote:

> +GPIO controllers on MPC8xxx SoCs
> +
> +Every GPIO controller node must have #gpio-cells property defined,
> +this information will be used to translate gpio-specifiers.
> +

Can we add a comment about this being the non-QE/CPM/GUTs GPIO  
support.  And maybe a reference to the 8349 as an example of the  
controller if unsure about the compatibility.

Also, does it make sense to have a reference to the top-level generic  
GPIO info w/regards to pin specific info, etc..

> +Required properties:
> +- compatible : "fsl,<CHIP>-gpio" followed by "fsl,mpc8349-gpio" for
> +  83xx, "fsl,mpc8572-gpio" for 85xx and "fsl,mpc8610-gpio" for 86xx.
> +- #gpio-cells : Should be two. The first cell is the pin number and  
> the
> +  second cell is used to specify optional parameters (currently  
> unused).
> + - interrupts : Interrupt mapping for GPIO IRQ (currently unused).
> + - interrupt-parent : Phandle for the interrupt controller that
> +   services interrupts for this device.
> +- gpio-controller : Marks the port as GPIO controller.

- k
