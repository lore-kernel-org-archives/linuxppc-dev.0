Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A077ADE1FD
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 07:18:41 +1000 (EST)
Subject: Re: [PATCH v2] [POWERPC] 4xx: Add endpoint support to 4xx PCIe driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <1208789670-28909-1-git-send-email-sr@denx.de>
References: <1208789670-28909-1-git-send-email-sr@denx.de>
Content-Type: text/plain
Date: Tue, 22 Apr 2008 07:16:31 +1000
Message-Id: <1208812591.9640.45.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-04-21 at 16:54 +0200, Stefan Roese wrote:

> --------------
> - As suggested by Benjamin Herrenschmidt, don't determine endpoint mode
>   by looking at the already configured PCIe port state, but evaluate
>   the device_type property instead. This makes it possible for boards
>   without a previously run PCIe configuration (e.g. U-Boot) to configure
>   a port as endpoint as well.
> 
> - Don't map the big external config space upon endpoint configuration.
> 
> - Introduce "vendor-id" and "device-id" properties to be written to
>   the host bridge.

and class-code too ?

Appart from that, I'll have a quick look at the patch later today but at
first it looks good.

Cheers,
Ben.
