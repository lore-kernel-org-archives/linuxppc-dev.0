Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net
	[151.189.21.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 016C2DDED8
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 15:11:31 +1000 (EST)
In-Reply-To: <20070515020026.GG565@localhost.localdomain>
References: <20070515020026.GG565@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8492e53122b6e1ba269afd53b48a4968@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Small fixes for the Ebony device tree
Date: Tue, 15 May 2007 07:11:07 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Just a few more things...

>  	plb {
> -		device_type = "ibm,plb";
>  		compatible = "ibm,plb-440gp", "ibm,plb4";

You match on "ibm,plb" though.  Well you got one
in three right ;-)

> +		SDRAM0: memory-controller {
>  			compatible = "ibm,sdram-440gp", "ibm,sdram";

"ibm,sdram" is way too generic to ever be usefully
used for device matching.

> +		SRAM0: sram {
> +			compatible = "ibm,sram440gp";

You spell this one without a dash, all others with one.


Segher
