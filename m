Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 43CF0DDEC0
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 12:09:51 +1000 (EST)
In-Reply-To: <Pine.LNX.4.64.0709121119160.19430@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0709121119160.19430@blarg.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <13038b1ac10f19f2e1fdbd0c1323c1e7@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v4] [POWERPC] 85xx: Add basic Uniprocessor MPC8572 DS port
Date: Thu, 13 Sep 2007 00:22:58 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +	soc8572@ffe00000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		device_type = "soc";
> +		ranges = <00000000 ffe00000 00100000>;
> +		reg = <ffe00000 00001000>;	// CCSRBAR & soc regs, remove once parse 
> code for immrbase fixed

Hrm, if you remove it here, where else are you going to describe
the SoC control register block (whatever it is called -- is that
IMMR?)


Segher
