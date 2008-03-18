Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 500FBDDE04
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 09:41:10 +1100 (EST)
In-Reply-To: <1205847466-17854-1-git-send-email-sr@denx.de>
References: <1205847466-17854-1-git-send-email-sr@denx.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <23bc1271d080c41ab54a4917d256a76b@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/2] [POWERPC] Add L2 cache node to AMCC Taishan dts file
Date: Tue, 18 Mar 2008 23:40:47 +0100
To: Stefan Roese <sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +	L2C0: l2c@30 {
> +		compatible = "ibm,l2-cache-440gx", "ibm,l2-cache";
> +		dcr-reg = <20 8			/* Internal SRAM DCR's */
> +			   30 8>;		/* L2 cache DCR's */

The unit address is based on the _first_ entry in "reg".  No2 this
is "dcr-reg", but you don't really want to be more incompatible than
necessary...


Segher
