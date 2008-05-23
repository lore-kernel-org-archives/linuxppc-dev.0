Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E2761DE03C
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 13:31:56 +1000 (EST)
Message-Id: <0855C418-66AB-4335-A677-371E5DC08B5C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: "Jin Zhengxiong" <Jason.Jin@freescale.com>
In-Reply-To: <CC27DED0F8F39E48A7E75FD768688B7A915AB8@zch01exm27.fsl.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH v2] [POWERPC] mpic: deal with bogus NIRQ in
	FeatureReporting Register
Date: Thu, 22 May 2008 22:31:43 -0500
References: <Pine.LNX.4.64.0805211559110.31758@blarg.am.freescale.net>
	<1211403708.8297.251.camel@pasglop>
	<CC27DED0F8F39E48A7E75FD768688B7A915AB8@zch01exm27.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 22, 2008, at 9:15 PM, Jin Zhengxiong wrote:

> Hi, Kumar,
>
> So I should  change the MSI hwirq num according to this change, The
> patches
> will be send after this changes updated to your tree. How about  
> applying
> the MSI
> driver firstly?

I've asked Paul to pick up this patch for powerpc-next.  If you can  
rework the MSI patches with this patch applied and just change the  
board support for mpc85xx_ds and 8610 to set the flag.

- k
