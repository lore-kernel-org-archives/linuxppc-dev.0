Return-Path: <jeremymc@gmail.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 07D35DE29B
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 06:04:27 +1000 (EST)
Message-ID: <481F685C.400@gmail.com>
Date: Mon, 05 May 2008 16:04:44 -0400
From: Jeremy McNicoll <jeremymc@gmail.com>
MIME-Version: 1.0
To: Jeremy McNicoll <jeremy.mcnicoll@windriver.com>
Subject: Re: [PATCH] SBC8548: Add flash support and HW Rev reporting
References: <1209759601-5659-1-git-send-email-jeremy.mcnicoll@windriver.com>
In-Reply-To: <1209759601-5659-1-git-send-email-jeremy.mcnicoll@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jeremy McNicoll wrote:
> The following adds local bus, flash and MTD partition nodes for
> sbc8548. As well, a compatible field for the soc node, so that
> of_platform_bus_probe() will pick it up.
>
> Something that is provided through this newly added epld node
> is the Hardware Revision is now being reported at bootup.
>
> Signed-off-by: Jeremy McNicoll <jeremy.mcnicoll@windriver.com>
> ---
>  arch/powerpc/boot/dts/sbc8548.dts     |   94 +++++++++++++++++++++++++++++++++
>  arch/powerpc/platforms/85xx/sbc8548.c |   25 +++++++++
>  2 files changed, 119 insertions(+), 0 deletions(-)
>   
This patch may not be as efficient as it could be, an updated version to 
follow.

-jeremy
