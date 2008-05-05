Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ADC4DDDEDD
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 08:19:17 +1000 (EST)
Message-Id: <7C3FC1D9-52B1-41C6-8C77-2C4335CCD780@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jeremy McNicoll <jeremy.mcnicoll@windriver.com>
In-Reply-To: <1210025844-20681-1-git-send-email-jeremy.mcnicoll@windriver.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] SBC8548: Add flash support and HW Rev reporting
Date: Mon, 5 May 2008 17:19:12 -0500
References: <1209759601-5659-1-git-send-email-jeremy.mcnicoll@windriver.com>
	<1210025844-20681-1-git-send-email-jeremy.mcnicoll@windriver.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 5, 2008, at 5:17 PM, Jeremy McNicoll wrote:

> The following adds local bus, flash and MTD partition nodes for
> sbc8548. As well, a compatible field for the soc node, so that
> of_platform_bus_probe() will pick it up.
>
> Something that is provided through this newly added epld node
> is the Hardware Revision which is now being utilized.
>
> Signed-off-by: Jeremy McNicoll <jeremy.mcnicoll@windriver.com>

What was changed in this version?

- k
