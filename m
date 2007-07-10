Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E180DDDED9
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 23:56:10 +1000 (EST)
In-Reply-To: <11840606621515-git-send-email-wei.zhang@freescale.com>
References: <1184060662530-git-send-email-wei.zhang@freescale.com>
	<11840606624025-git-send-email-wei.zhang@freescale.com>
	<11840606621515-git-send-email-wei.zhang@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <55F09B00-F81A-4B70-B0F7-2FEBDBB2B48A@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/4] Add dma sector to mpc8641hpcn board dts
Date: Tue, 10 Jul 2007 15:55:58 +0200
To: Zhang Wei <wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +		dma@21000{
> +			compatible = "fsl,mpc8xxx-dma";

Please use a real name, not this "xxx" stuff.

> +			reg = <21000 100>;
> +			ranges = <0 21000 1000>;

These overlap, that can't be right; it is just begging for
trouble.

> +			ch0@100{
> +				reg = <100 80>;
> +				extended;

I think you want a little more detailed property name
than "extended" here?


Segher
